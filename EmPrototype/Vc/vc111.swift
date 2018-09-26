//
//  ViewController.swift
//  EmPrototype
//
//  Created by alan on 2018/6/28.
//  Copyright © 2018年 alan. All rights reserved.
//

import UIKit
import Alamofire
import MGSwipeTableCell

class vc111: UIViewController,UITableViewDelegate,UITableViewDataSource,MGSwipeTableCellDelegate{
    
    var tab = UITableView()
    //frined tab data
    var listAry : FriendData? {
        didSet{
            self.tab.reloadData()
        }
    }
    // addfriend tab data
    var addAry : FriendData?
    var selectlisttb = UITableView()
    fileprivate var id = [String]()
    fileprivate var name = [String]()
    fileprivate var phone = [String]()
    fileprivate var avatar = [String]()
    fileprivate var snapshot: UIView?
    fileprivate var sourceIndexPath: IndexPath?
    
    var selectedIndexs = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.title = "聯絡人"
        let settingButton = UIBarButtonItem(title:"Add+", style: UIBarButtonItem.Style.done, target: self, action:#selector(self.selectlist))
        
        self.navigationItem.rightBarButtonItem = settingButton
        
        
        
        APIManager.getApi.getContacts(completion:{
            err, res in
            self.listAry = res
            DispatchQueue.main.async{
                self.tab.reloadData()
                
                APIManager.getApi.getUserList(completion:{
                    err,result in
                    self.addAry = result

                    DispatchQueue.main.async{
                        
                        
                         let list = self.addAry!.list?.filter({ (c1) -> Bool in
                            let found = self.listAry!.list?.first(where: { (c2) -> Bool in
                                c1.userId == c2.userId
                            })
                            // 留下沒找到的 且 不等於自己的
                            return found==nil && (c1.userId != user.get("userid"))
                        })
                        self.addAry?.list = list!

//                        for (_,value) in self.listAry!.list!.enumerated(){
//
//                            for (indexs,values) in self.addAry!.list!.enumerated(){
//                                if value.name == values.name{
//                                self.addAry!.list!.remove(at: indexs)
//                                }
//                            }
//
//                        }
                        
                        self.selectlisttb.reloadData()
                    }
                    
                })
                
            }
        })
        
        
        
        


        //加入手勢
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(self.longPressGestureRecongnized(longPress:)))
        tab.addGestureRecognizer(longPress)
        
        
        
        tab.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        tab.delegate = self
        tab.dataSource = self
        tab.backgroundColor = UIColor.groupTableViewBackground
        view.addSubview(tab)
        tab.tableFooterView = UIView()
        
        
       
    
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tab.reloadData()
    }
    //長壓cell 移動
    @objc func longPressGestureRecongnized(longPress: UILongPressGestureRecognizer){
        let state = longPress.state
        let location = longPress.location(in: self.tab)
        guard let indexPath = self.tab.indexPathForRow(at: location)else{
            self.cleanup()
            return
        }
        switch state {
        case .began:
            sourceIndexPath = indexPath
            guard let cell = self.tab.cellForRow(at: indexPath) else{ return }
            snapshot = self.customSnapshotFromView(inputView: cell)
            guard  let snapshot = self.snapshot else { return }
            var center = cell.center
            snapshot.center = center
            snapshot.alpha = 0.0
            tab.addSubview(snapshot)
            
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

                swap(&listAry!.list![indexPath.row].userId!, &listAry!.list![sourceIndexPath.row].userId!)
                swap(&listAry!.list![indexPath.row].name!, &listAry!.list![sourceIndexPath.row].name!)
                swap(&listAry!.list![indexPath.row].avatar!, &listAry!.list![sourceIndexPath.row].avatar!)
                self.tab.moveRow(at: sourceIndexPath, to: indexPath)
                self.sourceIndexPath = indexPath
            }
            break
        default:
            guard let cell = self.tab.cellForRow(at: indexPath) else {
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
        self.tab.reloadData()
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
    func tableView(_ tableView: UITableView,didSelectRowAt indexPath: IndexPath) {
        if tableView == tab{
            print(indexPath.row)
            let vc = vc222()
            vc.userid = listAry!.list![indexPath.row].userId!
            vc.username = listAry!.list![indexPath.row].name!
            //                    self.navigationController?.pushViewController(vc, animated: true)
            self.navigationController?.pushViewController(vc, animated: true)
            self.navigationController?.navigationBar.isHidden = false
        }else{
            if let index = selectedIndexs.index(of: indexPath.row){
                selectedIndexs.remove(at: index) //原来选中的取消选中
            }else{
                selectedIndexs.append(indexPath.row) //原来没选中的就选中
            }
            selectlisttb.reloadRows(at: [indexPath], with: .automatic)
        }
        
        
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == tab {
            if listAry?.list?.count == nil{
                return 0
            }else{
                return (listAry!.list!.count)
            }
        }else{
            if addAry?.list?.count == nil{
                return 0
            }
            return (addAry!.list!.count)
        }
        
     
    }
    
 
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == tab{
            var cell = tab.dequeueReusableCell(withIdentifier: "cellID") as! MGSwipeTableCell?
            
            if cell == nil {
                cell = MGSwipeTableCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "cellID")
            }
            
            
//            cell?.leftButtons = [MGSwipeButton(title: "默認", backgroundColor: .gray){
//                (sender: MGSwipeTableCell!) -> Bool in
//                print("Convenience callback for swipe buttons!")
//                return true
//                },MGSwipeButton(title: "默認2", backgroundColor: .red)]
//            cell?.leftSwipeSettings.transition = .border
            
            cell?.rightButtons = [MGSwipeButton(title: "Delete", backgroundColor: .red){
                (sender: MGSwipeTableCell!) -> Bool in
                print("Convenience callback for swipe buttons!")
                var dicAry = [String]()
                dicAry.append(self.listAry!.list![indexPath.row].userId!)
                self.listAry!.list!.remove(at: indexPath.row)
                APIManager.getApi.delFriends(dicAry, completion: { err,ruslt in
                    
                })
                self.cheackdata()
                self.tab.reloadData()
                return true
                }]
            cell?.rightSwipeSettings.transition = .border
            
            cell?.delegate = self
            cell?.selectionStyle = UITableViewCell.SelectionStyle.none
            cell?.textLabel?.text = "用戶 : \(listAry!.list![indexPath.row].name!)"
            
            return cell!
        }else{
            let cell =
                selectlisttb.dequeueReusableCell(
                    withIdentifier: "Cell2", for: indexPath) as
            UITableViewCell
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            cell.textLabel?.text = "用戶 : \(addAry!.list![indexPath.row].name!)"
            if selectedIndexs.contains(indexPath.row) {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }

            return cell
        }
        

        
        
    }
    
    func cheackdata(){
        APIManager.getApi.getContacts(completion:{
            err, res in
            self.listAry = res
            DispatchQueue.main.async{
                self.tab.reloadData()
                
                APIManager.getApi.getUserList(completion:{
                    err,result in
                    self.addAry = result
                    
                    DispatchQueue.main.async{
                        
                        let list = self.addAry!.list?.filter({ (c1) -> Bool in
                            let found = self.listAry!.list?.first(where: { (c2) -> Bool in
                                c1.userId == c2.userId
                            })
                            // 留下沒找到的 且 不等於自己的
                            return found==nil && (c1.userId != user.get("userid"))
                        })
                        self.addAry?.list = list!
                        
                        self.selectlisttb.reloadData()
                    }
                    
                })
                
            }
        })
        
    }

    
    @objc func selectlist(){
        let alertController = UIAlertController(
            title: "提示",
            message: "新增名單",
            preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(
            title: "取消",
            style: .cancel,
            handler: {
                (action: UIAlertAction!) -> Void in
                self.selectedIndexs.removeAll()
        })
        alertController.addAction(cancelAction)
        // 建立[確認]按鈕
        let okAction = UIAlertAction(
            title: "確認",
            style: .default,
            handler: {
                (action: UIAlertAction!) -> Void in
                
                print("选中项的索引为：", self.selectedIndexs)
                print("选中项的值为：")
                var dicAry = [String]()
                for index in self.selectedIndexs {
                    dicAry.append(self.addAry!.list![index].userId!)
//                    self.selectedIndexs.remove(at: index) //原来选中的取消选中
                }
                self.selectedIndexs.removeAll()
                APIManager.getApi.addFriends(dicAry, completion:{
                    result in
                    
                    
                    
                    DispatchQueue.main.async{
                        
                        APIManager.getApi.getContacts(completion:{
                            err, res in
                            self.listAry = res
                            DispatchQueue.main.async{
                                
                                let list = self.addAry!.list?.filter({ (c1) -> Bool in
                                    let found = self.listAry!.list?.first(where: { (c2) -> Bool in
                                        c1.userId == c2.userId
                                    })
                                    // 留下沒找到的 且 不等於自己的
                                    return found==nil && (c1.userId != user.get("userid"))
                                })
                                self.addAry?.list = list!
                                
                                self.selectlisttb.reloadData()
                                self.tab.reloadData()

                            }
                        })
                    }
                    
                })
                
        })
        alertController.addAction(okAction)
        let vc = UIViewController()
        selectlisttb = UITableView()
        selectlisttb.frame = CGRect(x: 0, y: 0, width: 272, height: 300)
        selectlisttb.delegate = self
        selectlisttb.dataSource = self
        selectlisttb.register(UITableViewCell.self, forCellReuseIdentifier: "Cell2")

        selectlisttb.backgroundColor = UIColor.groupTableViewBackground
        vc.view.addSubview(selectlisttb)
        selectlisttb.tableFooterView = UIView()
        
        vc.preferredContentSize = CGSize(width: 272, height: 300)
        //        tableViewController.tableView.backgroundColor=UIColor.red
        alertController.setValue(vc, forKey: "contentViewController")
        // 顯示提示框
        self.present(alertController,
                     animated: true, completion: nil)    }
    
}

