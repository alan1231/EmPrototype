//
//  home.swift
//  EmPrototype
//
//  Created by alan on 2018/7/13.
//  Copyright © 2018年 alan. All rights reserved.
//

import UIKit

class home: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let lab = UILabel()
        lab.frame = view.frame
        lab.text = "首页"
        lab.textAlignment = .center
        lab.font = UIFont.boldSystemFont(ofSize: 20)
        view.addSubview(lab)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
}
