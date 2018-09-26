//
//  BalanceSettingViewController.swift
//  EmPrototype
//
//  Created by alan on 2018/8/21.
//  Copyright © 2018年 alan. All rights reserved.
//

import UIKit

class BalanceSettingViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var mainTable : UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
         self.title = "币别设定"
        setUpTable()
    }

    func setUpTable(){
        mainTable = UITableView.init(frame: CGRect(x: 0, y: 0, width: viewSize.width, height: viewSize.height), style: UITableView.Style.plain)
        mainTable!.delegate = self
        mainTable!.dataSource = self
        mainTable!.backgroundColor = UIColor.white
        mainTable!.tableFooterView = UIView()
        mainTable!.separatorStyle = .singleLine
        mainTable!.tableFooterView?.isHidden = true
        mainTable.isEditing = true
        self.view.addSubview(mainTable!)
        mainTable!.register(BalanceSettingTableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return viewSize.height/8
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 取得 tableView 目前使用的 cell
        let cell = mainTable?.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! BalanceSettingTableViewCell
        cell.accessoryType = .disclosureIndicator
        // 顯示的內容
        
        switch CurrencyName[indexPath.row] {
        case "CNY":
            cell.nameLab.text = CurrencyBalance[indexPath.row] + "  人民幣"
            cell.imgView.image = UIImage(named: "cnycoin.png")
        case "USD":
            cell.nameLab.text = CurrencyBalance[indexPath.row] + "  美 金"
            cell.imgView.image = UIImage(named: "usdcoin.png")
        case "BTC":
            cell.nameLab.text = CurrencyBalance[indexPath.row] + "  比特幣"
            cell.imgView.image = UIImage(named: "btccoin.png")
        case "ETH":
            cell.nameLab.text = CurrencyBalance[indexPath.row] + "  以太幣"
            cell.imgView.image = UIImage(named: "ethcoin.png")
        default:
            break
        }
        
        return cell
    }
    
    //在编辑状态，可以拖动设置cell位置
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //編輯模式設定
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath)
        -> UITableViewCell.EditingStyle
    {
        if(mainTable!.isEditing != false){
            return UITableViewCell.EditingStyle.none
        }else{
            return UITableViewCell.EditingStyle.delete
        }
        
    }
    //移动cell事件
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath,
                   to destinationIndexPath: IndexPath) {
        if sourceIndexPath != destinationIndexPath{
            //获取移动行对应的值
            let itemValue:String = CurrencyName[sourceIndexPath.row]
            let itemValue2:String = CurrencyBalance[sourceIndexPath.row]

            //删除移动的值
            CurrencyName.remove(at: sourceIndexPath.row)
            CurrencyBalance.remove(at: sourceIndexPath.row)
            //如果移动区域大于现有行数，直接在最后添加移动的值
            if destinationIndexPath.row > CurrencyName.count{
                CurrencyName.append(itemValue)
                CurrencyBalance.append(itemValue2)
            }else{
                //没有超过最大行数，则在目标位置添加刚才删除的值
                CurrencyName.insert(itemValue, at:destinationIndexPath.row)
                CurrencyBalance.insert(itemValue2, at:destinationIndexPath.row)

            }
        }
    }

}
