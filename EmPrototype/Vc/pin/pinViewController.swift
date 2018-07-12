//
//  pinViewController.swift
//  EmPrototype
//
//  Created by alan on 2018/7/12.
//  Copyright © 2018年 alan. All rights reserved.
//

import UIKit

class pinViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    var pinMain: pinLayoutView!
    
    static var pinCode = String()
    
    var dataArr = ["1","2","3","4","5","6","7","8","9","清除","0","⌫"]
    
    var Allcell = UICollectionViewCell()
    
    var colltionView : UICollectionView?
    
    var pinPassword = [String]()
    
    var labAry = [UILabel]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        navigationController?.navigationBar.isHidden = false
        
        self.title = ""
        let newBackButton = UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.done, target: self, action:#selector(self.back))
        self.navigationItem.leftBarButtonItem = newBackButton
        
        
        view.backgroundColor = UIColor.white
        
        //        view.layer.shouldRasterize=true
        
        pinMain = pinLayoutView (frame:self.view.frame, VC: self)
        
        view.addSubview(pinMain)
        
        initView()
        
        
        //        let btn = UIButton()
        //        btn.frame = CGRect(x: 10, y: 30, width: 40, height: 40)
        //        btn.addTarget(self, action: #selector(self.back), for: .touchUpInside)
        //        btn.backgroundColor  = UIColor.red
        //        view.addSubview(btn)
    }
    @objc func back(){
        self.navigationController?.popViewController(animated: true)
        
        if phoneNumberViewController.PinStatus == "1"{
            navigationController?.navigationBar.isHidden = true
        }else{
            navigationController?.navigationBar.isHidden = false
        }
        
        phoneNumberViewController.PinStatus = "1"
        
    }
    
    func initView(){
        let layout = UICollectionViewFlowLayout()
        colltionView = UICollectionView(frame: CGRect(x: 0, y: height/1.58, width: width, height: height), collectionViewLayout: layout)
        //注册一个cell
        colltionView! .register(pinCollectionViewCell.self, forCellWithReuseIdentifier:"cell")
        colltionView?.delegate = self;
        colltionView?.dataSource = self;
        colltionView?.backgroundColor = UIColor.white
        //设置每一个cell的宽高
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 1.0
        layout.sectionInset = .zero
        layout.itemSize = CGSize(width: width/3.18, height: height/12)
        self.view.addSubview(colltionView!)
        
    }
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        
        if pinPassword.count == 0{
            
            if dataArr[(indexPath.item)] == "清除" || dataArr[(indexPath.item)] == "⌫" {
                
            }else{
                pinPassword.append(dataArr[(indexPath.item)])
                //                pinMain.labArry[0].backgroundColor = UIColor.red
            }
            
        }else{
            switch dataArr[(indexPath.item)]{
            case "清除" :
                pinPassword.removeAll()
                
            case "⌫" :
                pinPassword.removeLast()
                
            default:
                
                if !(pinPassword.count == 6) {
                    pinPassword.append(dataArr[(indexPath.item)])
                    if pinPassword.count == 6{
                        
                        let str = "\(pinPassword[0])"+"\(pinPassword[1])"+"\(pinPassword[2])"+"\(pinPassword[3])"+"\(pinPassword[4])"+"\(pinPassword[5])"
                        
                        print("六位碼驗證:"+"\(str)")
                        
                        switch (phoneNumberViewController.PinStatus){
                            
                        case "1" :
                            pinViewController.pinCode = str
                            let vc = pinViewController()
                            self.navigationController?.pushViewController(vc, animated: true)
                            phoneNumberViewController.PinStatus = "2"
                        case "2" :
                            if str == pinViewController.pinCode{
                                print("驗證ok")
                                let alert = UIAlertController(title: "PinCode認證", message: nil, preferredStyle: .alert)
                                
                                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { action in
                                    let vc = setNameViewController()
                                    self.present(vc, animated: true, completion: nil)
                                    
                                }))
                                self.present(alert, animated: true)
                                
                                
                                
                            }else{
                                print("某愛了")
                                pinMain.pinLab.shake()
                                pinPassword.removeAll()
                                
                            }
                            
                        default: break
                            
                        }
                        
                        
                        
                    }
                }
                break
            }
        }
        for i in 0...5{
            pinMain.labArry[i].layer.cornerRadius = pinMain.labArry[i].bounds.width/2
            pinMain.labArry[i].isHidden = ((i >= pinPassword.count) ? true:false)
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        labAry[indexPath.row].backgroundColor = UIColor.groupTableViewBackground
        return true
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        labAry[indexPath.row].backgroundColor = UIColor.groupTableViewBackground
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        labAry[indexPath.row].backgroundColor = UIColor.white
        
    }
    
    
    
    
    
    
    
    //返回多少个组
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! pinCollectionViewCell
        
        var title = String()
        title = dataArr[indexPath.row]
        cell.titleLabel?.text = title
        if "清除" == cell.titleLabel?.text {
            cell.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        }
        if "⌫" == cell.titleLabel?.text {
            cell.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        }
        if labAry.count != 12 {
            labAry.append(cell.titleLabelbackground)
        }
        
        return cell
        
        
        
    }
    
}
