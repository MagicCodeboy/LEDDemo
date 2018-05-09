
//
//  UIView+Extension.swift
//  TodayNewsFirst
//
//  Created by lalala on 2017/10/24.
//  Copyright © 2017年 吕山虎. All rights reserved.
//

import UIKit

protocol StoryboardLoadable {}

extension StoryboardLoadable where Self: UIViewController {
    //提供加载方法
    static func loadStoryboard(name: String? = nil) -> Self {
        let storyboard = UIStoryboard(name: "\(self)",bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "\(self)") as! Self
    }
}

protocol LoadNibProtocal {}
//----------UIView extension--------------
extension LoadNibProtocal where Self: UIView {
    //提供加载xib 的方法
    static func loadViewFromNib(name: String? = nil) -> Self {
        return Bundle.main.loadNibNamed(name ?? "\(self)", owner: nil, options: nil)?.last as! Self
    }
}

protocol RegisterCellOrNib {}
extension RegisterCellOrNib {
    static var identifier: String {
        return "\(self)"
    }
    static var xib: UINib? {
        return UINib(nibName: "\(self)",bundle: nil)
    }
}
extension UIView {
    var x: CGFloat {
        get {
            return frame.origin.x
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.origin.x = newValue
            frame              = tempFrame
        }
    }
    var y: CGFloat {
        get {
            return frame.origin.y
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.origin.y = newValue
            frame = tempFrame
        }
    }
    var width: CGFloat {
        get {
            return frame.size.width
        }
        set (newValue){
            var tempFrame: CGRect = frame
            tempFrame.size.width = newValue
            frame = tempFrame
        }
    }
    var height: CGFloat {
        get {
            return frame.size.height
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size.height = newValue
            frame = tempFrame
        }
    }
    var size: CGSize {
        get {
            return frame.size
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size = newValue
            frame = tempFrame
        }
    }
    var centerX: CGFloat {
        get {
            return center.x
        }
        set(newValue) {
            var tempCenter: CGPoint = center
            tempCenter.x = newValue
            center = tempCenter
        }
    }
    var centerY: CGFloat {
        get {
            return center.y
        }
        set(newValue) {
            var tempCenter: CGPoint = center
            tempCenter.y = newValue
            center = tempCenter;
        }
    }
}
