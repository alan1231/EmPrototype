//
//  BalanceHistoryViewController.swift
//  EmPrototype
//
//  Created by alan on 2018/9/25.
//  Copyright © 2018年 alan. All rights reserved.
//

import UIKit
import Kingfisher

class BalanceHistoryViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    var mainTable : UITableView?
    var name : String!
    var balance : String!
    var glist = [String]()
    var group = [String : [Receipts]]()
    var BalanceMain : BalanceHistoryLayoutView!
    var total : String?
    var exstring : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = name + "餘額"
        self.view.backgroundColor = UIColor.groupTableViewBackground
       
        BalanceMain = BalanceHistoryLayoutView(frame: self.view.frame, VC: self)
        view.addSubview(BalanceMain)
        BalanceMain.Balancelab.text = balance
        BalanceMain.BalanceImgview.image = UIImage(named:CurrencyiCon[name]!)
        
        
        
        if total == nil {
            BalanceMain.Balanceimage.isHidden = true
        }else{
            print("1111111111")
            BalanceMain.exstrlab.text = exstring!
            BalanceMain.totallab.text = total!
            BalanceMain.BalanceActBtn.addTarget(self, action: #selector(self._Exchange), for: .touchUpInside)
//            BalanceMain.Balanceimage.isHidden = false
        }

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
                //過濾家出帳
                if rec.currency != self.name  {
                    return
                }
                if rec.txType == 4 && ((rec.txresult?.outflow)!){
                    return
                }
                let g = self.group[self.name]
                if g == nil{
                    self.glist.append(self.name)
                    self.group[self.name] = [Receipts]()
                }
                self.group[self.name]?.append(rec)

            })
            self.mainTable?.reloadData()
        }

        )
        
    }
    
    
    @objc func _Exchange (){
        let vc = ExchangeViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    
    func loadDataSource(){
        setUpTable()
        mainTable?.reloadData()
    }
    func setUpTable(){
        mainTable = UITableView.init(frame: CGRect(x: 10, y: viewSize.height/2 , width: viewSize.width - 20
            , height: viewSize.height/2), style: UITableView.Style.grouped)
        mainTable!.delegate = self
        mainTable!.dataSource = self
        mainTable!.backgroundColor = UIColor.white
        mainTable!.tableFooterView = UIView()
        mainTable?.layer.cornerRadius = 10

        //        mainTable!.separatorInset = UIEdgeInsetsMake(0, 20, 0, 20)
        mainTable!.separatorStyle = .singleLine
        mainTable!.tableFooterView?.isHidden = true
        
        self.view.addSubview(mainTable!)
        mainTable!.register(HistoryTableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return glist.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return group[glist[0]]!.count
//        return glist.count
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
        headerView.backgroundColor = UIColor.white
        let titleLabel = UILabel()
        titleLabel.text = "歷史交易"
        titleLabel.backgroundColor = UIColor.white
        titleLabel.textColor = UIColor(red: 53/255.0, green: 78/255.0, blue: 81/255.0, alpha: 1)
        titleLabel.sizeToFit()
        titleLabel.center = CGPoint(x: self.view.frame.width/6, y: 20)
        headerView.addSubview(titleLabel)
        return headerView
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 取得 tableView 目前使用的 cell
        let cell = mainTable?.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! HistoryTableViewCell
        cell.accessoryType = .disclosureIndicator
        let dic = group[glist[0]]![indexPath.row]

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
}
