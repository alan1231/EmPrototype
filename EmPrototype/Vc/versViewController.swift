//
//  versViewController.swift
//  EmPrototype
//
//  Created by alan on 2018/9/13.
//  Copyright © 2018年 alan. All rights reserved.
//

import UIKit

class versViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        let lab = UILabel()
        lab.frame = CGRect(x: 0, y: 80, width:view.frame.width, height: 50)
        lab.textColor = UIColor.black
        view.addSubview(lab)
        if API_URL == "https://uwbackend-rel.azurewebsites.net/api/"{
            lab.text = "線上測試"
        }else{
            lab.text = "開發測試"
        }
        
        
        let text = UITextView()
        text.frame = CGRect(x: 0, y: 130, width:view.frame.width, height: 200)
        text.text = "\(API_URL)\n\(API_NUMBER)\n\(API_UPPHOTO)"
        view.addSubview(text)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
