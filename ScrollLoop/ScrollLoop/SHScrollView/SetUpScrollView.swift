//
//  SetUpScrollView.swift
//  ScrollLoop
//
//  Created by lalala on 2018/5/8.
//  Copyright © 2018年 LSH. All rights reserved.
//

import UIKit

@objc protocol ClickSpeedDelegate {
    @objc optional func clickButtonSpeed(index: Int) //可选方法
    @objc optional func clickDirectionButton(index: Int)
}

class SetUpScrollView: UIView {

    let directionArr:[String] = ["向左","向右","往返"]
    let textArr:[String] = ["较慢","慢","中","快","较快"]
    var buttonArray = [UIButton]()
    var directionButtonArray = [UIButton]()
    var delegate: ClickSpeedDelegate?
    
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
            selectButton.tag = 200 + item
            selectButton.setTitle(textArr[item], for: .normal)
            selectButton.setTitleColor(UIColor.white, for: .normal)
            selectButton.addTarget(self, action: #selector(clickButton(button:)), for: .touchUpInside)
            if selectButton.tag == 202 {
                selectButton.isSelected = true
                selectButton.layer.borderColor = UIColor.green.cgColor
            }
            buttonArray.append(selectButton)
            self.addSubview(selectButton)
        }
        for index in 0..<3 {
            let directionButton = UIButton.init(frame: CGRect.init(x: (SCREEN_WIDTH / 3) * CGFloat(index), y: 50, width: SCREEN_WIDTH / 3, height: 30))
            directionButton.layer.cornerRadius = 5
            directionButton.layer.borderColor = UIColor.clear.cgColor
            directionButton.layer.borderWidth = 3
            directionButton.layer.masksToBounds = true
            directionButton.tag = 400 + index
            directionButton.setTitle(directionArr[index], for: .normal)
            directionButton.setTitleColor(UIColor.white, for: .normal)
            directionButton.addTarget(self, action: #selector(clickDirectionButton(button:)), for: .touchUpInside)
            if directionButton.tag == 400 {
                directionButton.isSelected = true
                directionButton.layer.borderColor = UIColor.green.cgColor
            }
            directionButtonArray.append(directionButton)
            self.addSubview(directionButton)
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
        delegate?.clickButtonSpeed!(index: button.tag - 200)
    }
    @objc func clickDirectionButton(button: UIButton) {
        for btn in directionButtonArray {
            if btn.tag == button.tag {
                btn.layer.borderColor = UIColor.green.cgColor
                btn.isSelected = true
            } else {
                btn.layer.borderColor = UIColor.clear.cgColor
                btn.isSelected = false
            }
        }
        delegate?.clickDirectionButton!(index: button.tag - 400)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
