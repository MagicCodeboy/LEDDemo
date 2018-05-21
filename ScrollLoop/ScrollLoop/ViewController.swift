//
//  ViewController.swift
//  ScrollLoop
//
//  Created by lalala on 2018/5/7.
//  Copyright © 2018年 LSH. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate,ClickbuttonDelegate,ClickSpeedDelegate {

    let kAppdelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
    var inputTextField: UITextField?
    var fontCustomButton: UIButton?
    var scrollCustomButton: UIButton?
    var doneButton : UIButton?
    var setupFontView: SetupFontView?
    var setupScrollView : SetUpScrollView?
    var scorllSpeed: CGFloat = 3 //滚动的速度
    var fontSize: CGFloat = 300 //滚动的速度
    var scrollType: SHScrollDirction = .fromLeft
    var fontColor: UIColor = UIColor.red
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.lightGray
        
        setUpSubViews()
    }
    
    private func setUpSubViews() {
        
        inputTextField = UITextField.init(frame: CGRect.init(x: 15, y: topSpace, width: Int(SCREEN_WIDTH - kMargin * 2), height: Int(50)))
        inputTextField?.borderStyle = .roundedRect
        inputTextField?.textColor = UIColor.black
        inputTextField?.textAlignment = .left
        inputTextField?.clearButtonMode = .whileEditing
        inputTextField?.returnKeyType = .done
        inputTextField?.placeholder = "请您输入内容"
        inputTextField?.delegate = self
        self.view.addSubview(inputTextField!)
        
        fontCustomButton = UIButton.init()
        fontCustomButton?.frame =  CGRect.init(x: kMargin, y: inputTextField!.y + 90, width: SCREEN_WIDTH - kMargin * 2, height: buttonHeight)
//        fontCustomButton?.backgroundColor = .red
        fontCustomButton?.titleLabel?.textAlignment = .left
        fontCustomButton?.setTitle("设置字体颜色和大小", for: .normal)
        fontCustomButton?.setTitleColor(UIColor.black, for: .normal)
        self.view.addSubview(fontCustomButton!)
        
        setupFontView = SetupFontView.init(frame: CGRect.init(x: 0, y: fontCustomButton!.y + 30, width: SCREEN_WIDTH, height: 90))
        setupFontView?.backgroundColor = UIColor.lightGray
        setupFontView?.delegate = self
        self.view.addSubview(setupFontView!)
        
        scrollCustomButton = UIButton.init()
        scrollCustomButton?.frame = CGRect.init(x: kMargin, y: setupFontView!.y + 100, width: SCREEN_WIDTH - kMargin * 2, height: buttonHeight)
//        scrollCustomButton?.backgroundColor = .red
        scrollCustomButton?.titleLabel?.textAlignment = .left
        scrollCustomButton?.setTitle("设置滚动速度和方向", for: .normal)
        scrollCustomButton?.setTitleColor(UIColor.black, for: .normal)
        self.view.addSubview(scrollCustomButton!)
        
        setupScrollView = SetUpScrollView.init(frame: CGRect.init(x: 0, y: scrollCustomButton!.y + 30, width: SCREEN_WIDTH, height: 90))
        setupScrollView?.backgroundColor = UIColor.lightGray
        setupScrollView?.delegate = self
        self.view.addSubview(setupScrollView!)
        
        doneButton = UIButton.init()
        doneButton?.frame = CGRect.init(x: kMargin, y: setupScrollView!.y + 100, width: SCREEN_WIDTH - kMargin * 2, height: 50)
        doneButton?.addTarget(self, action: #selector(clickDoneButton), for: .touchUpInside)
        doneButton?.backgroundColor = .green
        doneButton?.titleLabel?.textAlignment = .center
        doneButton?.setTitle("Show", for: .normal)
        doneButton?.setTitleColor(buttonTextColor, for: .normal)
        doneButton?.layer.masksToBounds = true
        doneButton?.layer.cornerRadius = 5
        self.view.addSubview(doneButton!)
        
    }
    @objc func clickDoneButton() {
        self.view.endEditing(true)
        if inputTextField?.text == "" {
            return
        } else {
            let scrollView = ScrollViewController()
            scrollView.scrollType = .fromLeft
            scrollView.theTextString = inputTextField?.text as NSString?
            scrollView.fontColor = fontColor
            scrollView.scorllSpeed = scorllSpeed
            scrollView.fontSize = fontSize
            scrollView.scrollType = scrollType
            scrollView.title = "往左"
            
            let rotation : UIInterfaceOrientationMask = .landscapeLeft
            kAppdelegate?.blockRotation = rotation
            
            self.present(scrollView, animated: true) {
                
            }
        }
    }
    
    func clickButtonColor(color: UIColor) {
        fontColor = color
    }
    func clickButtonFont(index: Int) {
        switch index {
        case 0:
            fontSize = 60
        case 1:
            fontSize = 260
        case 2:
            fontSize = 320
        case 3:
            fontSize = 360
        default:
            fontSize = 300
        }
    }
    func clickDirectionButton(index: Int) {
        switch index {
        case 0:
            scrollType = .fromLeft
        case 1:
            scrollType = .fromRight
        case 2:
            scrollType = .reverse
        default:
            scrollType = .fromLeft
        }
    }
    func clickButtonSpeed(index: Int) {
        switch index {
        case 0:
            scorllSpeed = 0.5
        case 1:
            scorllSpeed = 1
        case 2:
            scorllSpeed = 2.5
        case 3:
            scorllSpeed = 6
        case 4:
            scorllSpeed = 9
        default:
            scorllSpeed = 3
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
         self.view.endEditing(true)
    }
    override var prefersStatusBarHidden: Bool{
        return false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //如果不设置该页面的竖屏， 在屏幕锁定打开的情况下，竖屏First -> 横屏Second -> 切换到后台 -> 进入前台 -> 返回竖屏First 会出现状态栏已竖屏，其他内容仍然横屏切换的问题
        UIViewController.attemptRotationToDeviceOrientation()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //收起键盘
        textField.resignFirstResponder()
        //打印出文本框中的值
        print(textField.text ?? "")
        return true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
}


