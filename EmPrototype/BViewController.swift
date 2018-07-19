//
//  BViewController.swift
//  EmPrototype
//
//  Created by alan on 2018/7/12.
//  Copyright © 2018年 alan. All rights reserved.
//

import UIKit

class BViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.orange
        
        let btn = UIButton()
        btn.setTitle("清除", for: .normal)
        btn.frame = CGRect(x: (view.frame.size.width/2) - 25, y: (view.frame.size.height/2) - 25, width: 50, height: 50)
        btn.backgroundColor = UIColor.groupTableViewBackground
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.addTarget(self, action: #selector(self.dddd), for: .touchUpInside)
        
        self.view.addSubview(btn)
    }
    @objc func dddd(){
        user.remove("PinCode")
        user.remove("PinStatus")
        user.remove("Token")
        user.remove("PinNumber")
        let vc = phoneNumberViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        self.navigationController?.navigationBar.isHidden = true
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
