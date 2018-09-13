//
//  HistoryViewController.swift
//  EmPrototype
//
//  Created by alan on 2018/8/20.
//  Copyright © 2018年 alan. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{

    
    var mainTable : UITableView?
    var info = [
        [],[],[],[]
    ]
    var infoid = [
        [],[],[],[]
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "历史交易"
        view.backgroundColor = UIColor.white
        loadDataSource()
        APIManager.getApi.getReceipts("1900-01-01T08:10:51.887519Z",completion:{
            result in
            APIData.instance.receipts = ReceiptsData(JSON: result!)
//            APIData.instance.receipts?.list
//            print(APIData.instance.receipts!.list![0].id)
//            print(APIData.instance.receipts!.list![0].txparams!.amount)
            
            guard let list = APIData.instance.receipts?.list else {
                return
            }
            
            for index in 0...(list.count-1){
                if   (list[index].currency) == "CNY"{
                    self.info[0].append(list[index].datetime!)
                    self.infoid[0].append(list[index].id!)
                }
                if   (list[index].currency) == "USD"{
                    self.info[1].append(list[index].datetime!)
                    self.infoid[1].append(list[index].id!)
                }
                if   (list[index].currency) == "BTC"{
                    self.info[2].append(list[index].datetime!)
                    self.infoid[2].append(list[index].id!)
                }
                if   (list[index].currency) == "ETH"{
                    self.info[3].append(list[index].datetime!)
                    self.infoid[3].append(list[index].id!)
                }
                
            }
            self.mainTable?.reloadData()
        })

        
    }
    func loadDataSource(){
        setUpTable()
        mainTable?.reloadData()
    }
    func setUpTable(){
        mainTable = UITableView.init(frame: CGRect(x: 0, y: 0, width: viewSize.width, height: viewSize.height), style: UITableViewStyle.grouped)
        mainTable!.delegate = self
        mainTable!.dataSource = self
        mainTable!.backgroundColor = UIColor.white
        mainTable!.tableFooterView = UIView()
//        mainTable!.separatorInset = UIEdgeInsetsMake(0, 20, 0, 20)
        mainTable!.separatorStyle = .singleLine
        mainTable!.tableFooterView?.isHidden = true

        self.view.addSubview(mainTable!)
        mainTable!.register(HistoryTableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    // 必須實作的方法：每一組有幾個 cell
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return info[section].count
    }
    // 有幾組 section
    func numberOfSections(in tableView: UITableView) -> Int {
        return info.count
    }
    // 每個 section 的標題

    func tableView(_ tableView: UITableView,
                   titleForHeaderInSection section: Int) -> String? {
//        let title = section == 0 ? "籃球" : "棒球"
        let str = ["CNY","USD","BTC","ETH"]
        return str[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 取得 tableView 目前使用的 cell
        let cell = mainTable?.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! HistoryTableViewCell
        // 設置 Accessory 按鈕樣式
//        if indexPath.section == 1 {
//            if indexPath.row == 0 {
//                cell.accessoryType = .checkmark
//            } else if indexPath.row == 1 {
//                cell.accessoryType = .detailButton
//            } else if indexPath.row == 2 {
//                cell.accessoryType = .detailDisclosureButton
//            } else if indexPath.row == 3 {
//                cell.accessoryType = .disclosureIndicator
//            }
//        }
        cell.accessoryType = .disclosureIndicator
        // 顯示的內容
        if let myLabel = cell.textLabel {
            myLabel.text = "\(info[indexPath.section][indexPath.row])"
        }
        
        return cell
    }
    
    // 點選 Accessory 按鈕後執行的動作
    // 必須設置 cell 的 accessoryType
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let name = info[indexPath.section][indexPath.row]
        print("按下的是 \(name) 的 detail")
    }
    // 點選 cell 後執行的動作
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 取消 cell 的選取狀態
        tableView.deselectRow(at: indexPath, animated: true)
        
        let name = info[indexPath.section][indexPath.row]
        let id = infoid[indexPath.section][indexPath.row] as! String

        guard let list = APIData.instance.receipts?.list else {
            return
        }
        
        for index in 0...(list.count-1){
            if   (list[index].id) == id{
                let vc = HistoryDetail()
                vc.detail = list[index]
                self.navigationController?.pushViewController(vc, animated: true)
                self.navigationController?.navigationBar.isHidden = false
            }
        }
        
        
        
        print("選擇的是 \(name)")
    }
    // 設置 cell 的高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    //返回分区头部高度
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    //返回分区头部视图
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.groupTableViewBackground
        let titleLabel = UILabel()
//        let title = section == 0 ? "籃球" : "棒球"
        let str = ["CNY","USD","BTC","ETH"]

        titleLabel.text = str[section]
        titleLabel.textColor = UIColor.black
        titleLabel.sizeToFit()
        titleLabel.center = CGPoint(x: self.view.frame.width/10, y: 20)
        headerView.addSubview(titleLabel)
        return headerView
    }
    // 每個 section 的 footer
//    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
//        return "footer"
//    }
    // 設置每個 section 的 footer 為一個 UIView
    // 如果實作了這個方法 會蓋過單純設置文字的 section footer
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    // 設置 section footer 的高度
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }

    
}
