//
//  SetupFontView.swift
//  ScrollLoop
//
//  Created by lalala on 2018/5/8.
//  Copyright © 2018年 LSH. All rights reserved.
//

import UIKit

@objc protocol ClickbuttonDelegate {
    @objc optional func clickButtonColor(color: UIColor) //可选方法
    @objc optional func clickButtonFont(index: Int) //可选方法
}
class SetupFontView: UIView {
    
    let colorArr:[UIColor] = [UIColor.red,UIColor.orange,UIColor.yellow,UIColor.blue,UIColor.purple]
    let fontArr:[String] = ["较小","适中","较大","特大"]
    var buttonArray = [UIButton]()
    var buttnFontArray = [UIButton]()
    var delegate: ClickbuttonDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubViews()
    }
    private func setupSubViews() {
        for item in 0..<5 {
            let selectButton = UIButton.init(frame: CGRect.init(x: (SCREEN_WIDTH / 5) * CGFloat(item), y: 10, width: SCREEN_WIDTH / 5, height: 30))
            selectButton.layer.cornerRadius = 5
            selectButton.layer.borderColor = UIColor.clear.cgColor
            selectButton.layer.borderWidth = 3
            selectButton.layer.masksToBounds = true
            selectButton.tag = 100 + item
            selectButton.backgroundColor = colorArr[item]
            selectButton.addTarget(self, action: #selector(clickButton(button:)), for: .touchUpInside)
            if selectButton.tag == 100 {
                selectButton.isSelected = true
                selectButton.layer.borderColor = UIColor.green.cgColor
            }
            buttonArray.append(selectButton)
            self.addSubview(selectButton)
        }
        for index in 0..<4 {
            let fontButton = UIButton.init(frame: CGRect.init(x: (SCREEN_WIDTH / 4) * CGFloat(index), y: 50, width: SCREEN_WIDTH / 4, height: 30))
            fontButton.layer.cornerRadius = 5
            fontButton.layer.borderColor = UIColor.clear.cgColor
            fontButton.layer.borderWidth = 3
            fontButton.layer.masksToBounds = true
            fontButton.tag = 300 + index
            fontButton.setTitle(fontArr[index], for: .normal)
            fontButton.setTitleColor(UIColor.white, for: .normal)
            fontButton.addTarget(self, action: #selector(clickFontButton(button:)), for: .touchUpInside)
            if fontButton.tag == 301 {
                fontButton.isSelected = true
                fontButton.layer.borderColor = UIColor.green.cgColor
            }
            buttnFontArray.append(fontButton)
            self.addSubview(fontButton)
        }
    }
    
    @objc func clickButton(button: UIButton) {
        for btn in buttonArray {
            if btn.tag == button.tag {
                btn.layer.borderColor = UIColor.green.cgColor
                btn.isSelected = true
            } else {
                btn.layer.borderColor = UIColor.clear.cgColor
                btn.isSelected = false
            }
        }
        delegate?.clickButtonColor!(color: button.backgroundColor!)
    }
    @objc func clickFontButton(button: UIButton) {
        for btn in buttnFontArray {
            if btn.tag == button.tag {
                btn.layer.borderColor = UIColor.green.cgColor
                btn.isSelected = true
            } else {
                btn.layer.borderColor = UIColor.clear.cgColor
                btn.isSelected = false
            }
        }
         delegate?.clickButtonFont!(index: button.tag - 300)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
