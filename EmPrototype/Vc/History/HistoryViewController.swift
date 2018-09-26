//
//  HistoryViewController.swift
//  EmPrototype
//
//  Created by alan on 2018/8/20.
//  Copyright © 2018年 alan. All rights reserved.
//

import UIKit
import Kingfisher

class HistoryViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{

    
    var mainTable : UITableView?

    var glist = [String]()
    var group = [String : [Receipts]]()
    
    var name : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "历史交易"
        view.backgroundColor = UIColor.white
        

        let settingButton = UIBarButtonItem(title:"筛选", style: UIBarButtonItem.Style.done, target: self, action:#selector(self._filter))
        self.navigationItem.rightBarButtonItem = settingButton
        
        
        
        loadDataSource()
        APIManager.getApi.getReceipts("1900-01-01T08:10:51.887519Z",completion:{
            result in
            APIData.instance.receipts = ReceiptsData(JSON: result!)
            
            guard var list = APIData.instance.receipts?.list else {
                return
            }
            
            //sorting
            
            
            list.sort { $0.datetime_! > $1.datetime_! }
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy年MM月"
            dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
            list.forEach({ (rec) in
                let yyyymm = dateFormatter.string(from: rec.datetime_!)
                //過濾家出帳
                if rec.txType == 4 && ((rec.txresult?.outflow)!){
                    return
                }
                let g = self.group[yyyymm]
                if g == nil{
                    self.glist.append(yyyymm)
                    self.group[yyyymm] = [Receipts]()
                }
                self.group[yyyymm]?.append(rec)
//                print("yyyymm " + yyyymm + " cnt \(self.group[yyyymm]?.count)")
            })
            self.mainTable?.reloadData()
        })

        
    }
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    @objc func _filter (){
        let vc = HistoryfilterViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        self.navigationController?.navigationBar.isHidden = false
    }
    func loadDataSource(){
        setUpTable()
        mainTable?.reloadData()
    }
    func setUpTable(){
        mainTable = UITableView.init(frame: CGRect(x: 0, y: 0, width: viewSize.width, height: viewSize.height), style: UITableView.Style.grouped)
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
        return group[glist[section]]!.count
    }
    // 有幾組 section
    func numberOfSections(in tableView: UITableView) -> Int {
        return glist.count
    }
    // 每個 section 的標題

    func tableView(_ tableView: UITableView,
                   titleForHeaderInSection section: Int) -> String? {
        return glist[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 取得 tableView 目前使用的 cell
        let cell = mainTable?.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! HistoryTableViewCell
        cell.accessoryType = .disclosureIndicator
            let dic = group[glist[indexPath.section]]![indexPath.row]

            let toUserId = dic.txresult!.outflow!  ? dic.txparams?.receiver:dic.txparams?.sender
        
        UserBank.get(userId: toUserId!){user in
                switch (dic.txType!)
                {
                case 1:
                    print(1)
//                    txType.text = " 此筆紀錄 : " + "存款"
                case 2:
                    print(2)
//                    txType.text = " 此筆紀錄 : " + "提款"
                case 3:
                    let b = dic.txresult!.outflow!  ? "付款":"收款"
                    var str = "-"
                    if let url = URL(string:(user?.avatar)!) {
                        let imageResource = ImageResource(downloadURL: url, cacheKey:user?.avatar)
                        cell.imgView.kf.setImage(with: imageResource)
                    }
                    if dic.txresult!.outflow!{
                        cell.nameLab.text = b+"-"+(user?.name)!
                    }else{
                        cell.amount.textColor = UIColor.red
                        str = "+"
                    }
                    
                    let sign = CurrencySign[dic.txparams!.currency!]!
                    cell.amount.text = str+sign+" "+"\(dic.txresult!.amount!)"
                    cell.nameLab.text = b+"-"+(user?.name)!

              
                case 4:
                    let signForm = CurrencySign[dic.txparams!.currency!]!
                    let signTo = CurrencySign[dic.txparams!.toCurrency!]!
                    let str = "換匯-"+(dic.txparams?.currency)!+"→"+(dic.txparams?.toCurrency)!
                    cell.nameLab.text = str
                    cell.imgView.image = UIImage(named: "ExchangeIcon")
                    cell.imgView.clipsToBounds = false
                    cell.imgView.contentMode = UIView.ContentMode.scaleAspectFit
                    cell.examount.text = signForm + " \(dic.txparams!.amount!) → " + signTo + " \(dic.txresult!.amount!)"
                    cell.exchange.text = "1 " + "\(dic.currency!)" + " = " + "\(dic.txresult!.amount! / dic.txparams!.amount! )"
                default:
                    break
                }
            }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy年MM月HH:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        let yyyymm = dateFormatter.string(from:dic.datetime_!)
        cell.time.text = yyyymm
        


        
        
        
        
        
        
        return cell
    }
    
    // 點選 Accessory 按鈕後執行的動作
    // 必須設置 cell 的 accessoryType
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let name = group[glist[indexPath.section]]![indexPath.row].id!
        print("按下的是 \(name) 的 detail")
 
    }
    // 點選 cell 後執行的動作
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 取消 cell 的選取狀態
        tableView.deselectRow(at: indexPath, animated: true)
        
        let name = group[glist[indexPath.section]]![indexPath.row].id

                let vc = HistoryDetail()
                vc.detail = group[glist[indexPath.section]]![indexPath.row]
                self.navigationController?.pushViewController(vc, animated: true)
                self.navigationController?.navigationBar.isHidden = false

        print("選擇的是 \(String(describing: name!))")
    }
    // 設置 cell 的高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewSize.height/10
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
        titleLabel.text = glist[section]
        titleLabel.textColor = UIColor.black
        titleLabel.sizeToFit()
        titleLabel.center = CGPoint(x: self.view.frame.width/6, y: 20)
        headerView.addSubview(titleLabel)
        return headerView
    }

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
