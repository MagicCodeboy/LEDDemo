//
//  ScrollViewController.swift
//  ScrollLoop
//
//  Created by lalala on 2018/5/7.
//  Copyright © 2018年 LSH. All rights reserved.
//

import UIKit

class ScrollViewController: UIViewController {
    var scrollType: SHScrollDirction?
    var snowView: SnowView?
    var theTextString : NSString?
    var fontColor: UIColor = UIColor.red //字体的颜色
    var scorllSpeed: CGFloat = 3 //每次回调移动多少点
    var fontSize: CGFloat = 300 //滚动的速度
    var showTheSnow: Bool = true
    let kAppdelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
    private let scrollView = SHScrolIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        kAppdelegate?.blockRotation = .portrait
        navigationController?.popViewController(animated: true)
        self.dismiss(animated: false) {
            
        }
    }
    private func setUpUI() {
        self.view.backgroundColor = UIColor.black
        
        let label = UILabel()
        label.textColor = fontColor
        label.font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
        label.font = UIFont.init(name: "DBLCDTempBlack", size: fontSize)
        label.textAlignment = .center
        label.text = theTextString! as String
        
        scrollView.contentView = label
        scrollView.backgroundColor = UIColor.clear
        scrollView.contentMargin = 100
        scrollView.pointsPerFrame = scorllSpeed
        scrollView.scrollType = scrollType!
        self.view.addSubview(scrollView)
        
        if showTheSnow {
            snowView = SnowView.init(frame: self.view.bounds)
            snowView?.show(UIImage.init(named: "1"), in: self.view)
        }
    }

    override func viewDidLayoutSubviews() {
         super.viewDidLayoutSubviews()
        scrollView.bounds = self.view.bounds
        scrollView.center = self.view.center
        
    }
    override var prefersStatusBarHidden: Bool{
        return true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ScrollViewController {
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //设置原因： 手机竖屏进入横屏，状态栏默认隐藏；iPad显示异常
       
    }
 
}
