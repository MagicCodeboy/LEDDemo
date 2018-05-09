

//
//  Const.swift
//  WanAndorid
//
//  Created by lalala on 2018/2/26.
//  Copyright © 2018年 LSH. All rights reserved.
//

import UIKit


//屏幕的宽度和高度
let SCREEN_WIDTH = UIScreen.main.bounds.width
let SCREEN_HEIGHT = UIScreen.main.bounds.height

let isIPoneX: Bool = SCREEN_HEIGHT == 812 ? true : false
let topSpace = SCREEN_HEIGHT == 812 ? 84 : 64

//左右间距
let kMargin: CGFloat = 15.0
//按钮的高度
let buttonHeight : CGFloat = 30
//默认字体大小
let buttonTextSize : CGFloat = 50
//默认字体颜色
let buttonTextColor : UIColor = UIColor.red
