//
//  FYLoginCodeBtn.swift
//  FYLoginDemo_Example
//
//  Created by 付野 on 2021/4/17.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

public class FYLoginCodeBtn: UIView {

    var timer: DispatchSourceTimer?
    var flag = false
    var requestBlock: ((_ btn: FYLoginCodeBtn)->())?
    ///按钮开放，自定义样式，暂时不封装appearance
    @objc public var button: UIButton!
    var count = 0
    ///总时长，可以自定义
    @objc public var totalCount = 10
    weak var target: NSObjectProtocol? //中间者模式在回调中监听target的生命周期，处理计时器
    @objc public var sendingBackgroundColor: UIColor = .lightGray
    @objc public var defaultBackgroundColor: UIColor = .white {
        willSet {
            button.backgroundColor = newValue
        }
    }
    @objc public var sendingTitleColor: UIColor = .magenta
    @objc public var defaultTitleColor: UIColor = .black {
        willSet {
            button.setTitleColor(newValue, for: .normal)
        }
    }
    @objc public var font: UIFont = .systemFont(ofSize: 16)
    @objc public var defaultTitle: String = "" {
        willSet {
            self.button.setTitle(newValue, for: .normal)
        }
    }
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    };
    
    func setupUI() {
        button = UIButton(type: .custom)
        button.backgroundColor = defaultBackgroundColor
        button.frame = self.bounds
        button.setTitle("发送验证码", for: .normal)
        button.setTitleColor(defaultTitleColor, for: .normal)
        button.titleLabel?.font = font
        button.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
        self.addSubview(button)
    }
    
    @objc func btnClick() {
        self.requestBlock?(self)
    }
    
    ///订阅按钮点击
    @objc public func subscribeTap(target: NSObjectProtocol,request: @escaping ((_ btn: FYLoginCodeBtn)->())) {
        self.target = target
        self.requestBlock = request
    }
 
    @objc public func sendRequest() {
        count = totalCount
        timer = DispatchSource.makeTimerSource(queue: DispatchQueue.global())
        timer?.schedule(deadline: .now(), repeating: .seconds(1))
        // 设定时间源的触发事件
        timer?.setEventHandler(handler: { [self] in
            if self.target == nil {
                self.timer?.cancel()
            }
            self.count -= 1
            print(self.count)
            DispatchQueue.main.async {
                if count == 0 {
                    flag = true
                    button.isUserInteractionEnabled = self.flag
                    button.setTitle("发送验证码", for: .normal)
                    button.backgroundColor = .white
                    button.setTitleColor(.black, for: .normal)
                    timer?.cancel()
                    count = totalCount
                } else {
                    flag = false
                    button.isUserInteractionEnabled = flag
                    button.setTitle("\(self.count)秒", for: .normal)
                    
                }
                button.backgroundColor = flag ? defaultBackgroundColor : sendingBackgroundColor
                button.setTitleColor(flag ? defaultTitleColor : sendingTitleColor, for: .normal)
            }
        })
        // 启动时间源
        timer?.resume()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
