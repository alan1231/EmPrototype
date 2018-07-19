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
    
    
    var dataArr = ["1","2","3","4","5","6","7","8","9","清除","0","⌫"]
    
    var Allcell = UICollectionViewCell()
    
    var colltionView : UICollectionView?
    
    var pinPassword = [String]()
    
    var labAry = [UILabel]()
    
    var pinLab = UILabel()
    
    var labArry = [UILabel]()
    var labArry2 = [UILabel]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        pinLab.frame = CGRect(x: 0, y: Int(viewSize.height/2.8), width: Int(viewSize.width), height: Int(viewSize.width/20))
        self.view.addSubview(pinLab)
        //        navigationController?.navigationBar.isHidden = false
        
        self.title = ""
        let newBackButton = UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.done, target: self, action:#selector(self.back))
        self.navigationItem.leftBarButtonItem = newBackButton
        
        
        view.backgroundColor = UIColor.white
        
        //        view.layer.shouldRasterize=true
        
        pinMain = pinLayoutView (frame:self.view.frame, VC: self)
        
        view.addSubview(pinMain)
        
        pinMain.nextBtn.frame = CGRect(x: viewSize.width/2 - viewSize.width/10 , y: pinLab.frame.origin.y + pinLab.frame.size.height + viewSize.height/5.5, width: viewSize.width/5, height: 40)
        
        initView()
        pinMain.nextBtn.addTarget(self, action:#selector(self.pinchange), for: .touchUpInside)
        
        
        //        let btn = UIButton()
        //        btn.frame = CGRect(x: 10, y: 30, width: 40, height: 40)
        //        btn.addTarget(self, action: #selector(self.back), for: .touchUpInside)
        //        btn.backgroundColor  = UIColor.red
        //        view.addSubview(btn)
        
        switch user.get("PinNumber"){
        case "3":
            addCode(Int(user.get("PinNumber"))!, nb: 2.7)
        case "5":
            addCode(Int(user.get("PinNumber"))!, nb: 3.6)
        default:break
        }
        
    }
    @objc func pinchange(){
        
        if pinMain.pinBool {
            pinMain.pinBool = false
            pinPassword.removeAll()
            pinLab.removeFromSuperview()
            pinLab = UILabel()
            pinLab.frame = CGRect(x: 0, y: Int(viewSize.height/2.8), width: Int(viewSize.width), height: Int(viewSize.width/20))
            view.addSubview(pinLab)
            addCode(3, nb: 2.7)
            pinMain.nextBtn.setTitle("PIN选项4", for: .normal)
            

            user.save("PinNumber", "3")
            
        }else{
            pinMain.pinBool = true
            pinPassword.removeAll()
            pinLab.removeFromSuperview()
            pinLab = UILabel()
            pinLab.frame = CGRect(x: 0, y: Int(viewSize.height/2.8), width: Int(viewSize.width), height: Int(viewSize.width/20))
            view.addSubview(pinLab)
            addCode(5, nb: 3.6)
            pinMain.nextBtn.setTitle("PIN选项6", for: .normal)
            
            user.save("PinNumber", "5")

        }
        
        
        
    }
    @objc func addCode (_ int:Int ,nb:CGFloat){
        labArry.removeAll()
        for i in 0...int{
            let lab = UILabel()
            lab.frame = CGRect(x: (Int(viewSize.width/12)*i)+Int(viewSize.width/nb), y: 0, width: Int(viewSize.width/20), height: Int(viewSize.width/20))
            lab.backgroundColor = systemBuleColor
            lab.layer.cornerRadius=lab.bounds.width/2
            lab.layer.masksToBounds=true
            lab.isHidden = true
            pinLab.addSubview(lab)
            labArry.append(lab)
        }
        
        labArry2.removeAll()
        for i in 0...int{
            let lab = UILabel()
            lab.frame = CGRect(x: (Int(viewSize.width/12)*i)+Int(viewSize.width/nb)
                , y: 0 + Int((viewSize.width/20)/2)-1, width: Int(viewSize.width/20), height: 3)
            lab.backgroundColor = systemBuleColor
            pinLab.addSubview(lab)
            labArry2.append(lab)
        }
    }
    
    @objc func back(){
        self.navigationController?.popViewController(animated: true)
        
        if user.get("PinStatus") == "1"{
            navigationController?.navigationBar.isHidden = true
            print("bbb")
        }else{
            navigationController?.navigationBar.isHidden = false
            print("aaaa")
        }
        
        
        user.save("PinStatus", "1")

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
        colltionView!.delaysContentTouches = false
        
        
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
                let count = Int(user.get("PinNumber"))! + 1
                
                if !(pinPassword.count == count) {
                    pinPassword.append(dataArr[(indexPath.item)])
                    if pinPassword.count == count{
                        
                        var str = String()
                        if count == 6 {
                            str = "\(pinPassword[0])"+"\(pinPassword[1])"+"\(pinPassword[2])"+"\(pinPassword[3])"+"\(pinPassword[4])"+"\(pinPassword[5])"
                            print("六位碼驗證:"+"\(str)")
                        }else{
                            str = "\(pinPassword[0])"+"\(pinPassword[1])"+"\(pinPassword[2])"+"\(pinPassword[3])"
                            print("四位碼驗證:"+"\(str)")
                        }
                        
                        
                        
                        switch (user.get("PinStatus")){
                        case "1" :
                            user.save("PinCode",str)
                            user.save("PinStatus", "2")

                            let vc = pinViewController()
                            self.navigationController?.pushViewController(vc, animated: true)
                            self.navigationController?.navigationBar.isHidden = false

                            
                        case "2" :
                            if str == user.get("PinCode"){
                                let vc = setNameViewController()
                                self.navigationController?.pushViewController(vc, animated: true)
                                
                                user.save("PinStatus", "3")

                            }else{
                                print("某愛了")
                                pinLab.shake()
                                pinPassword.removeAll()
                                
                            }
                        case "3" :
                            if str == user.get("PinCode"){
                                let vc = tabbar()
                                self.navigationController?.pushViewController(vc, animated: false)
                                
                            }else{
                                print("某愛了")
                                pinLab.shake()
                                pinPassword.removeAll()
                                
                            }
                            
                        default:
                            print("NNNNNN")
                        }
                        
                        
                        
                    }
                }
                break
            }
        }
        for i in 0...Int(user.get("PinNumber"))!{
            print(i)
            labArry[i].layer.cornerRadius = labArry[i].bounds.width/2
            labArry[i].isHidden = ((i >= pinPassword.count) ? true:false)
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        labAry[indexPath.row].backgroundColor = UIColor.groupTableViewBackground
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.1) {
            self.labAry[indexPath.row].backgroundColor = UIColor.white
        }
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
