//
//  ViewController.swift
//  FFHudDemo
//
//  Created by 王欣 on 4/12/20.
//  Copyright © 2020 QFPay. All rights reserved.
//

import UIKit
import FFHud
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        displayLoading(text:"加载中...")
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2 ) {
            self.hideLoading()
        }
    }

}

