//
//  CLMeHeaderView.swift
//  SwiftDemo
//
//  Created by 炬盈科技 on 2017/9/14.
//  Copyright © 2017年 CJQ. All rights reserved.
//

import UIKit

class CLMeHeaderView: UIView {

    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var infoButton: UIButton!

    private var voidBlock: VoidBlock?
    
    /// MARK: - 初始化,绑定Xib,外部调用类方法
    class func loadXib() -> AnyObject {
        let className = NSStringFromClass(self).components(separatedBy: ".").last!
        return Bundle.main.loadNibNamed(className , owner: self, options: nil)!.first as AnyObject
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        avatar.layer.cornerRadius = 35.0
        avatar.layer.masksToBounds = true
    }
    
    func toPersonalInfoPage(block: @escaping VoidBlock) {
       self.voidBlock = block
    }    
    
    @IBAction func infoAction(_ sender: Any) {
        if voidBlock != nil {
            voidBlock!()
        }
    }
}

