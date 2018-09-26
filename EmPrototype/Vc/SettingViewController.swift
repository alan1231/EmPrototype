//
//  SettingViewController.swift
//  EmPrototype
//
//  Created by alan on 2018/8/21.
//  Copyright © 2018年 alan. All rights reserved.
//

import UIKit
import Alamofire
import Photos


protocol callBackProtocol {
    func callback(img:UIImage)
}

class SettingViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    let firendBtn = UIButton()
    var delegate:callBackProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        self.title = "设定"
        firendBtn.frame = CGRect(x: viewSize.width/20, y: viewSize.height/10 + (viewSize.width/17), width: viewSize.width/1.9 - (viewSize.width/20*2), height: viewSize.height/8)
        firendBtn.backgroundColor = UIColor.groupTableViewBackground
        firendBtn.addTarget(self, action: #selector(self._firend), for: .touchUpInside)
        firendBtn.setTitle("聯絡人", for: .normal)
        firendBtn.setTitleColor(UIColor.black, for: .normal)
        firendBtn.layer.cornerRadius = 5
        view.addSubview(firendBtn)
        
        let btn = UIButton()
        btn.setTitle("清除设定", for: .normal)
        btn.frame = CGRect(x:viewSize.width/1.9, y:firendBtn.frame.origin.y, width: firendBtn.frame.width  , height: firendBtn.frame.height)
        btn.backgroundColor = UIColor.groupTableViewBackground
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.addTarget(self, action: #selector(self.dddd), for: .touchUpInside)
        btn.layer.cornerRadius = 5
        self.view.addSubview(btn)
        
        
        let updataimage = UIButton()
        updataimage.frame = firendBtn.frame
        updataimage.frame.origin.y = (firendBtn.frame.height)*2 + viewSize.width/20
        updataimage.backgroundColor = UIColor.groupTableViewBackground
        updataimage.addTarget(self, action: #selector(self.upup), for: .touchUpInside)
        updataimage.setTitle("上傳頭照", for: .normal)
        updataimage.setTitleColor(UIColor.black, for: .normal)
        updataimage.layer.cornerRadius = 5
        view.addSubview(updataimage)
        
        let vers = UIButton()
        vers.frame = firendBtn.frame
        vers.frame = CGRect(x:viewSize.width/1.9, y:firendBtn.frame.origin.y, width: firendBtn.frame.width  , height: firendBtn.frame.height)
        vers.frame.origin.y = (firendBtn.frame.height)*2 + viewSize.width/20
        vers.backgroundColor = UIColor.groupTableViewBackground
        vers.addTarget(self, action: #selector(self.vers), for: .touchUpInside)
        vers.setTitle("版本別", for: .normal)
        vers.setTitleColor(UIColor.black, for: .normal)
        vers.layer.cornerRadius = 5
        view.addSubview(vers)
        
    }
    @objc func vers(){
        let vcs = versViewController()
        self.navigationController?.pushViewController(vcs, animated: true)
    }
    
    @objc func upup(){

        let actionSheet = UIAlertController(title: "上传头像", message: nil, preferredStyle: .actionSheet)
        let cancelBtn = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let takePhotos = UIAlertAction(title: "拍照", style: .destructive, handler: {
            (action: UIAlertAction) -> Void in
            //判断是否能进行拍照，可以的话打开相机
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                let picker = UIImagePickerController()
                picker.sourceType = .camera
                picker.delegate = self
                picker.allowsEditing = true
                self.present(picker, animated: true, completion: nil)
                
            }
            else
            {
                print("模拟其中无法打开照相机,请在真机中使用");
            }
            
        })
        let selectPhotos = UIAlertAction(title: "相册选取", style: .default, handler: {
            (action:UIAlertAction)
            -> Void in
            //调用相册功能，打开相册
            let picker = UIImagePickerController()
            picker.sourceType = .photoLibrary
            picker.delegate = self
            picker.allowsEditing = true
            self.present(picker, animated: true, completion: nil)
            
        })
        actionSheet.addAction(cancelBtn)
        actionSheet.addAction(takePhotos)
        actionSheet.addAction(selectPhotos)
        self.present(actionSheet, animated: true, completion: nil)


    }
    //选择成功后代理
    func imagePickerController(_ picker: UIImagePickerController,didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
// Local variable inserted by Swift 4.2 migrator.
let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)


            //flag = "图片"
            
            //获取选取后的图片
            let pickedImage = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.editedImage)] as! UIImage
            //转成jpg格式图片
            guard let jpegData = pickedImage.jpegData(compressionQuality: 0.5) else {
                return
            }
            //上传
            self.uploadImage(imageData: jpegData)
            //图片控制器退出
            self.dismiss(animated: true, completion:{
                setupView((self.navigationController?.view)!)
            })

    }
    
    //上传图片到服务器
    func uploadImage(imageData : Data){
        
        
        
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                //采用post表单上传
                // 参数解释：
                //withName:和后台服务器的name要一致 ；fileName:可以充分利用写成用户的id，但是格式要写对； mimeType：规定的，要上传其他格式可以自行百度查一下
                multipartFormData.append(imageData, withName: "file", fileName: "123456.jpg", mimeType: "image/jpeg")
                //如果需要上传多个文件,就多添加几个
                //multipartFormData.append(imageData, withName: "file", fileName: "123456.jpg", mimeType: "image/jpeg")
                //......
                
        },to: API_UPPHOTO,headers: ["Authorization": " Bearer \(user.get("Token"))"],encodingCompletion: { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                //连接服务器成功后，对json的处理
                upload.responseJSON { response in
                    //解包
                    guard let result = response.result.value else { return }
                    print("json:\(result)")
                    stoploadingView()
                    self.delegate?.callback(img:UIImage(data:imageData)!)
                }
                //获取上传进度
                upload.uploadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
                    print("图片上传进度: \(progress.fractionCompleted)")
                }
            case .failure(let encodingError):
                //打印连接失败原因
                print(encodingError)
            }

         })
     

    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    
    @objc func dddd(){
        
        
        let alertController = UIAlertController(
            title: "清除設定",
            message: "初始化唷",
            preferredStyle: .alert)
        
        let clear = UIAlertAction(title: "確定", style: .destructive, handler: {
            (action:UIAlertAction)
            -> Void in
            
//            APIManager.getApi.sendDevicetoken("22345678", completion:{
//                result in
//                
//                if result! {
//                    print("device token push ok")
//                }
//                
//            })
            
            
            user.remove("PinCode")
            user.remove("PinStatus")
            user.remove("Token")
            user.remove("PinNumber")
            user.remove("PhoneNumber")
            user.remove("username")
            let vc = phoneNumberViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            self.navigationController?.navigationBar.isHidden = true
        })
        let cancelBtn = UIAlertAction(title: "取消", style: .default, handler: nil)

        alertController.addAction(cancelBtn)
        alertController.addAction(clear)
        self.present(alertController, animated: true, completion: nil)
        
        
        
        
        

    }

    @objc func _firend(){
        let vc = vc111()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    


}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
	return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
	return input.rawValue
}
