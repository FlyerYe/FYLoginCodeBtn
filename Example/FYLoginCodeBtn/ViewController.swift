//
//  ViewController.swift
//  FYLoginCodeBtn
//
//  Created by 834225691@qq.com on 04/18/2021.
//  Copyright (c) 2021 834225691@qq.com. All rights reserved.
//

import UIKit

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        let btn = UIButton.init(frame: CGRect(x: 100, y: 200, width: 100, height: 50))
        btn.setTitle("跳转登录", for: .normal)
        btn.backgroundColor = .magenta
        btn.addTarget(self, action: #selector(click), for: .touchUpInside)
        view.addSubview(btn)
    }
    
    @objc func click() {
        navigationController?.pushViewController(FYLoginVC(), animated: true)
    }
    
}

