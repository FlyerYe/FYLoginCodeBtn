//
//  FYLoginVC.swift
//  FYLoginDemo_Example
//
//  Created by 付野 on 2021/4/17.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import FYLoginDemo
class FYLoginVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .magenta
        let codeBtn = FYLoginCodeBtn(frame: CGRect(x: 100, y: 200, width: 100, height: 30))
        codeBtn.defaultTitleColor = .blue
        codeBtn.defaultTitle = "获取验证码"
        codeBtn.sendingBackgroundColor = .white
        self.view.addSubview(codeBtn)
        
        codeBtn.subscribeTap(target: self) { (btn) in
            //模拟网络请求
            DispatchQueue.global().async {
                sleep(1)
                btn.sendRequest()
            }
        }
    }
    deinit {
        print("dealloc")
    }
}

