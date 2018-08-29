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
    fileprivate var id = [String]()
    fileprivate var name = [String]()
    fileprivate var phone = [String]()
    fileprivate var avatar = [String]()

    fileprivate var snapshot: UIView?
    fileprivate var sourceIndexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "聯絡人"
        
        APIManager.getApi.getUserList(99, completion:{
            result,err in
            if err != "err" {
                
                for ffx in (result!["result"] as? [AnyObject])!{
                    self.id.append(ffx["id"] as! String)
                    self.name.append(ffx["name"] as! String)
                    self.avatar.append(ffx["avatar"] as! String)

                }
                DispatchQueue.main.async{
                    
                    self.tab.reloadData()
                }
                
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
                swap(&id[indexPath.row], &id[sourceIndexPath.row])
                swap(&name[indexPath.row], &name[sourceIndexPath.row])
                swap(&phone[indexPath.row], &phone[sourceIndexPath.row])
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

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return id.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tab.dequeueReusableCell(withIdentifier: "cellID") as! MGSwipeTableCell?
        
        if cell == nil {
            cell = MGSwipeTableCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "cellID")
        }
        
        
        cell?.leftButtons = [MGSwipeButton(title: "默認", backgroundColor: .gray){
            (sender: MGSwipeTableCell!) -> Bool in
            print("Convenience callback for swipe buttons!")
            return true
            },MGSwipeButton(title: "默認2", backgroundColor: .red)]
        cell?.leftSwipeSettings.transition = .border

        cell?.rightButtons = [MGSwipeButton(title: "Delete", backgroundColor: .red){
            (sender: MGSwipeTableCell!) -> Bool in
            print("Convenience callback for swipe buttons!")
            return true
            }]
        cell?.rightSwipeSettings.transition = .border
        
        cell?.delegate = self
        cell?.selectionStyle = UITableViewCellSelectionStyle.none
        cell?.textLabel?.text = "用戶 : \(name[indexPath.row])"
        
        return cell!
        
    }
    
    
    func tableView(_ tableView: UITableView,didSelectRowAt indexPath: IndexPath) {
        // 取消 cell 的選取狀態
        
        let vc = vc222()
        vc.userid = id[indexPath.row]
        vc.username = name[indexPath.row]
        //        self.navigationController?.pushViewController(vc, animated: true)
        self.present(vc, animated: true, completion: nil)
    }
    
    
    
}

