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
    
    var total : String?
    var exstr : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "余额"
        view.backgroundColor = UIColor.white
        
        let settingButton = UIBarButtonItem(title:"币别设定", style: UIBarButtonItem.Style.done, target: self, action:#selector(self._setting))
        self.navigationItem.rightBarButtonItem = settingButton
        
        self.loadDataSource()

    
        
    }
    override func viewWillAppear(_ animated: Bool) {
        mainTable?.reloadData()
    }
    func loadDataSource() {
        
        APIManager.getApi.getBalances(completion:{
            balances in
            let list  = balances!["list"] as! [String:AnyObject]
//            print(balances)
        
            list.forEach({ (key, value) in
                CurrencyName.append(key)
                CurrencyBalance.append("\(value)")
            })

            DispatchQueue.main.async{
                self.setUpTable()

                self.mainTable?.reloadData()
            }
        })

    }
    
    func setUpTable(){
        mainTable = UITableView.init(frame: CGRect(x: 0, y: 0, width: viewSize.width, height: viewSize.height), style: UITableView.Style.plain)
        mainTable!.delegate = self
        mainTable!.dataSource = self
        mainTable!.backgroundColor = tabcellGray
        mainTable!.tableFooterView = UIView()
        mainTable!.separatorStyle = .none

        self.view.addSubview(mainTable!)
        //加入手勢
//        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(self.longPressGestureRecongnized(longPress:)))
//        mainTable?.addGestureRecognizer(longPress)
//
//        mainTable!.register(BalanceTableViewCell.self, forCellReuseIdentifier: "mainCell")

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
                mainTable?.reloadData()
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
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0{
            return viewSize.height/5
        }else{
            return viewSize.height/6
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "mainCell"
        
        var cell = mainTable?.dequeueReusableCell(withIdentifier:identifier) as! BalanceTableViewCell?
        if cell == nil {
            cell = BalanceTableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "mainCell")
        }
        total = cell?.total.text
        exstr = cell?.rise.text
        switch indexPath.row {
        case 0:
            cell?.lineView.isHidden = true
            cell?.titlelab.text = "预设币别"
        case 1:
            cell?.lineView.isHidden = false
            cell?.titlelab.text = "其他币别"
        default:
            cell?.lineView.isHidden = true
            cell?.titlelab.text = ""
        }
        
        
//        if indexPath.row == 0{
//            cell?.titlelab.text = "预设币别"
//        }
//        if indexPath.row == 1{
//            cell?.lineView.isHidden = false
//            cell?.titlelab.text = "其他币别"
//        }
        cell?.backgroundColor = tabcellGray

        
//        cell?.leftButtons = [MGSwipeButton(title: "預設", backgroundColor: .red){
//            (sender: MGSwipeTableCell!) -> Bool in
//            print("Convenience callback for swipe buttons!")
//            return true
//            }]
//        cell?.layer.contents = 8
//        cell?.clipsToBounds = true
//        
        cell?.delegate = self
        cell?.leftSwipeSettings.transition = .border
        
        cell?.name.text = (CurrencyName[indexPath.row] )
        switch CurrencyName[indexPath.row] {
        case "CNY":
            cell?.balance.text = "¥"+CurrencyBalance[indexPath.row]
            cell?.showImage.image = UIImage(named: "cnycoin.png")
        case "USD":
            cell?.balance.text = "$"+CurrencyBalance[indexPath.row]
            cell?.showImage.image = UIImage(named: "usdcoin.png")
        case "BTC":
            cell?.balance.text = "₿"+CurrencyBalance[indexPath.row]
            cell?.showImage.image = UIImage(named: "btccoin.png")
        case "ETH":
            cell?.balance.text = "Ξ"+CurrencyBalance[indexPath.row]
            cell?.showImage.image = UIImage(named: "ethcoin.png")
        default:
            break
        }

        cell!.selectionStyle = UITableViewCell.SelectionStyle.none

        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return viewSize.height/30
    }
    private func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UILabel? {
        let footerView = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 40))
        footerView.backgroundColor = UIColor.blue
        return footerView
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
                let vc = BalanceHistoryViewController()
                vc.name = CurrencyName[indexPath.row]
                vc.balance = CurrencyBalance[indexPath.row]
        if indexPath.row == 0 {
            vc.total = nil
            vc.exstring = nil
           
        }else{
            vc.total = total
            vc.exstring = exstr
        }
                self.navigationController?.pushViewController(vc, animated: true)
                self.navigationController?.navigationBar.isHidden = false
//            }
//        }
        
        }
    
}
