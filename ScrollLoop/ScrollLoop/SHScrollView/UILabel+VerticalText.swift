//
//  UILabel+VerticalText.swift
//  ScrollLoop
//
//  Created by lalala on 2018/5/7.
//  Copyright © 2018年 LSH. All rights reserved.
//

import UIKit

extension UILabel {
    func configVerticalText(verticalText: String) {
        var tempString = verticalText
        for index in 1..<verticalText.count {
            tempString.insert("\n", at: tempString.index(tempString.startIndex, offsetBy: (index*2 - 1)))
        }
        self.text = tempString
        self.numberOfLines = 0
    }
}
