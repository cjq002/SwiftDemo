//
//  CLBaseViewController.swift
//  SwiftDemo
//
//  Created by CL on 2019/4/1.
//  Copyright © 2019 cl. All rights reserved.
//

import UIKit

class CLBaseViewController: UIViewController, UIGestureRecognizerDelegate {
	
	/// 状态栏文字颜色设置，见CLNavigationController.swift
	override var preferredStatusBarStyle: UIStatusBarStyle {
		return .default
	}
	var routerParameters = Dictionary<String, Any>()
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		
		/// 视图背景颜色
		self.view.backgroundColor = CLColor.viewColor
		/// 隐藏导航栏的返回按钮
		self.navigationItem.hidesBackButton = true
		/// 导航栏返回按钮设置，自定义返回按钮将失去边沿左滑返回功能
		if (self.navigationController?.viewControllers.count == 0) {
			self.navigationItem.leftBarButtonItem = nil
		}else{
			let leftBarItem = UIBarButtonItem.init(image: UIImage.init(named: "navigation_back"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(customBack))
			leftBarItem.imageInsets = UIEdgeInsets.init(top: 0, left: -5, bottom: 0, right: 0)
			self.navigationItem.leftBarButtonItem = leftBarItem
		}
    }
	
	/// 视图将要展现
	///
	/// - Parameter animated: 是否有动画
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		// 导航栏设置隐藏
		self.navigationController?.navigationBar.isHidden = false
		// 导航栏设置透明
		self.navigationController?.navigationBar.isTranslucent = false
		// 导航栏显示阴影分割线
		self.navigationController?.navigationBar.shadowImage = nil
		// 导航栏背景图片：可设置纯色背景和其他样式背景
		self.navigationController?.navigationBar.setBackgroundImage(UIImage.navigationImage(), for: UIBarMetrics.default)
		// 导航栏tint着色（上面的控件渲染色）
		self.navigationController?.navigationBar.tintColor = CLColor.title
		// 导航栏标题属性设置：字体、颜色、大小等
		self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:CLColor.title ,NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 20)]
		
		// 设置系统返回手势的代理为当前控制器
		self.navigationController?.interactivePopGestureRecognizer!.delegate = self
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		
		// 设置系统返回手势的代理为nil
		self.navigationController?.interactivePopGestureRecognizer!.delegate = nil
		self.view.endEditing(true)
	}
	
	override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
		super.dismiss(animated: flag) {
			// self.view = nil,有效销毁present的视图控制器，不然容易内存泄露
			self.view.removeFromSuperview()
			self.view = nil
			if completion != nil {
				completion!()
			}
		}
	}
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		super.touchesBegan(touches, with: event)
		
		self.view.endEditing(true)
	}
	
	/// 自定义返回事件
	@objc func customBack() {
		if self.navigationController != nil && (self.navigationController?.viewControllers.count)! > 1 {
			self.navigationController?.popViewController(animated: true)
		} else {
			self.dismiss(animated: true) {}
		}
	}

	
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
