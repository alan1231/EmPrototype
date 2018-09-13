//
//  BalanceViewController.swift
//  EmPrototype
//
//  Created by alan on 2018/8/20.
//  Copyright © 2018年 alan. All rights reserved.
//

import UIKit

class BalanceViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,MGSwipeTableCellDelegate {
    var mainTable : UITableView?

    fileprivate var name = [String]()
    fileprivate var balance = [String]()
    fileprivate var snapshot: UIView?
    fileprivate var sourceIndexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "余额"
        view.backgroundColor = UIColor.white
        
        let settingButton = UIBarButtonItem(title:"币别设定", style: UIBarButtonItemStyle.done, target: self, action:#selector(self._setting))
        self.navigationItem.rightBarButtonItem = settingButton
        
        self.loadDataSource()

    
        
    }
    func loadDataSource() {
        
        APIManager.getApi.getBalances(completion:{
            balances in
            let list  = balances!["list"] as! [String:AnyObject]
            print(list)
        
            list.forEach({ (key, value) in
                self.name.append(key)
                self.balance.append("\(value)")
            })

            DispatchQueue.main.async{
                self.setUpTable()

                self.mainTable?.reloadData()
            }
        })

    }
    
    func setUpTable(){
        mainTable = UITableView.init(frame: CGRect(x: 0, y: 0, width: viewSize.width, height: viewSize.height), style: UITableViewStyle.plain)
        mainTable!.delegate = self
        mainTable!.dataSource = self
        mainTable!.backgroundColor = UIColor.white
        mainTable!.tableFooterView = UIView()
        self.view.addSubview(mainTable!)
        //加入手勢
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(self.longPressGestureRecongnized(longPress:)))
        mainTable?.addGestureRecognizer(longPress)
        
        mainTable!.register(BalanceTableViewCell.self, forCellReuseIdentifier: "mainCell")

    }
    
    //長壓cell 移動
    @objc func longPressGestureRecongnized(longPress: UILongPressGestureRecognizer){
        let state = longPress.state
        let location = longPress.location(in: self.mainTable)
        guard let indexPath = self.mainTable?.indexPathForRow(at: location)else{
            self.cleanup()
            return
        }
        switch state {
        case .began:
            sourceIndexPath = indexPath
            guard let cell = self.mainTable?.cellForRow(at: indexPath) else{ return }
            snapshot = self.customSnapshotFromView(inputView: cell)
            guard  let snapshot = self.snapshot else { return }
            var center = cell.center
            snapshot.center = center
            snapshot.alpha = 0.0
            mainTable?.addSubview(snapshot)
            
            UIView.animate(withDuration: 0.25, animations: {
                center.y = location.y
                snapshot.center = center
                snapshot.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
                snapshot.alpha = 0.98
                cell.alpha = 0.0
            }, completion: { (finished) in
                cell.isHidden = true
            })
            
            break
        case .changed:
            guard let snapshot = self.snapshot else{
                return
            }
            var center = snapshot.center
            center.y = location.y
            snapshot.center = center
            guard let sourceIndexPath = self.sourceIndexPath else {
                return
            }
            if indexPath != sourceIndexPath{
                swap(&balance[indexPath.row], &balance[sourceIndexPath.row])
                swap(&name[indexPath.row], &name[sourceIndexPath.row])
                self.mainTable?.moveRow(at: sourceIndexPath, to: indexPath)
                self.sourceIndexPath = indexPath
            }
            break
        default:
            guard let cell = self.mainTable?.cellForRow(at: indexPath) else {
                return
            }
            guard  let snapshot = self.snapshot else {
                return
            }
            cell.isHidden = false
            cell.alpha = 0.0
            UIView.animate(withDuration: 0.25, animations: {
                snapshot.center = cell.center
                snapshot.transform = CGAffineTransform.identity
                snapshot.alpha = 0
                cell.alpha = 1
            }, completion: { (finished) in
                self.cleanup()
            })
        }
    }
    
    private func cleanup() {
        self.sourceIndexPath = nil
        snapshot?.removeFromSuperview()
        self.snapshot = nil
        self.mainTable?.reloadData()
    }
    
    private func customSnapshotFromView(inputView: UIView) -> UIView? {
        UIGraphicsBeginImageContextWithOptions(inputView.bounds.size, false, 0)
        if let CurrentContext = UIGraphicsGetCurrentContext() {
            inputView.layer.render(in: CurrentContext)
        }
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
            UIGraphicsEndImageContext()
            return nil
        }
        UIGraphicsEndImageContext()
        let snapshot = UIImageView(image: image)
        snapshot.layer.masksToBounds = false
        snapshot.layer.cornerRadius = 0
        //        snapshot.layer.shadowOffset = CGSize(width: -5, height: 0)
        //        snapshot.layer.shadowRadius = 5
        //        snapshot.layer.shadowOpacity = 0.4
        return snapshot
    }

    
    
    

    @objc func _setting (){
        let vc = BalanceSettingViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        self.navigationController?.navigationBar.isHidden = false
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewSize.height/10
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return name.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "mainCell"
        
        var cell = mainTable?.dequeueReusableCell(withIdentifier:identifier) as! BalanceTableViewCell?
        
        if cell == nil {
            cell = BalanceTableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "mainCell")
        }
        
        
        cell?.leftButtons = [MGSwipeButton(title: "默認", backgroundColor: .gray){
            (sender: MGSwipeTableCell!) -> Bool in
            print("Convenience callback for swipe buttons!")
            return true
            },MGSwipeButton(title: "默認2", backgroundColor: .red)]
        cell?.delegate = self
        cell?.leftSwipeSettings.transition = .border
        cell?.name?.text = (name[indexPath.row] )
        cell?.balance?.text = (balance[indexPath.row] )

        cell!.selectionStyle = UITableViewCellSelectionStyle.none

        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 取消 cell 的選取狀態
//        tableView.deselectRow(at: indexPath, animated: true)
        
//        let name = info[indexPath.section][indexPath.row]
//        let id = infoid[indexPath.section][indexPath.row] as! String
//
//        guard let list = APIData.instance.receipts?.list else {
//            return
//        }
        
//        for index in 0...(list.count-1){
//            if   (list[index].id) == id{
                let vc = BalanceDetailViewController()
                vc.strtitle = name[indexPath.row]
                self.navigationController?.pushViewController(vc, animated: true)
                self.navigationController?.navigationBar.isHidden = false
//            }
//        }
        
        }
    
}
