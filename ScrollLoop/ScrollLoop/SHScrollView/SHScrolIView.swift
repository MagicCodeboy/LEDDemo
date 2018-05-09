//
//  SHScrolIView.swift
//  ScrollLoop
//
//  Created by lalala on 2018/5/7.
//  Copyright © 2018年 LSH. All rights reserved.
//

import UIKit

enum SHScrollDirction {
    case fromLeft
    case fromRight
    case fromTop
    case fromBottom
    case reverse
}

class SHScrolIView: UIView {
    var scrollType: SHScrollDirction = .fromLeft
    var contentMargin: CGFloat = 12  //两个视图之间的间隔
    var fromInterval: Int = 1  //回调次数
    var pointsPerFrame: CGFloat = 3 //移动的速度
    var fontColor: UIColor = UIColor.red //字体的颜色
    var contentView: UIView? {
        didSet {
            self.setNeedsLayout()
        }
    }
    private let containerView = UIView()
    private var marqueeDisplayLink: CADisplayLink?
    private var isReversing = false
    
    override func willMove(toSuperview newSuperview: UIView?) {
        if newSuperview == nil {
            stopMarquee()
        }
    }
    
    init() {
        super.init(frame: CGRect.zero)
        
        self.initialzeViews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.initialzeViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initialzeViews() {
        self.backgroundColor = UIColor.clear
        self.clipsToBounds = true
        
        containerView.backgroundColor = UIColor.clear
        self.addSubview(containerView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard let validContentView = contentView else {
             return
        }
        for view in containerView.subviews {
            view.removeFromSuperview()
        }
        validContentView.sizeToFit()
        validContentView.frame = CGRect(x: 0, y: 0, width: validContentView.bounds.size.width, height: self.bounds.size.height)
        containerView.addSubview(validContentView)
        
        if scrollType == .reverse {
            containerView.frame = CGRect(x: 0, y: 0, width: validContentView.bounds.size.width, height: self.bounds.size.height)
        } else {
             containerView.frame = CGRect(x: 0, y: 0, width: validContentView.bounds.size.width * 2 + contentMargin, height: self.bounds.size.height)
        }
        
        if validContentView.bounds.size.width > self.bounds.size.width {
            if scrollType != .reverse {
                let otherContentViewData = NSKeyedArchiver.archivedData(withRootObject: validContentView)
                let otherContentView = NSKeyedUnarchiver.unarchiveObject(with: otherContentViewData) as! UIView
                otherContentView.frame = CGRect(x: validContentView.bounds.size.width + contentMargin, y: 0, width: validContentView.bounds.size.width, height: self.bounds.size.height)
                containerView.addSubview(otherContentView)
            }
            
            self.startMarquee()
        }
    }
    
    func reloadData() {
         setNeedsLayout()
    }
    
    func startMarquee() {
        stopMarquee()
        
        if scrollType == .fromRight {
            var frame = containerView.frame
            frame.origin.x = self.bounds.size.width - frame.size.width
            containerView.frame = frame
        }
        
        marqueeDisplayLink = CADisplayLink.init(target: self, selector: #selector(processMarquee))
        marqueeDisplayLink?.frameInterval = fromInterval
        marqueeDisplayLink?.add(to: RunLoop.main, forMode: .commonModes)
    }
    func stopMarquee() {
        marqueeDisplayLink?.invalidate()
        marqueeDisplayLink = nil
    }
    
}

extension SHScrolIView {
    @objc private func processMarquee() {
        var frame = containerView.frame
        
        switch scrollType {
        case .fromLeft:
            let targetX = -(contentView!.bounds.size.width + contentMargin)
            
            if frame.origin.x <= targetX {
                frame.origin.x = 0
                containerView.frame = frame
            } else {
                frame.origin.x -= pointsPerFrame
                if frame.origin.x < targetX {
                    frame.origin.x = targetX
                }
                containerView.frame = frame
            }
        case .fromRight:
            let targetX = self.bounds.size.width - self.contentView!.bounds.size.width
            if frame.origin.x >= targetX {
                frame.origin.x = self.bounds.size.width - self.containerView.bounds.size.width
                self.containerView.frame = frame
            }else {
                frame.origin.x += pointsPerFrame
                if frame.origin.x > targetX {
                    frame.origin.x = targetX
                }
                self.containerView.frame = frame
            }
        case .reverse:
            if isReversing {
                let targetX: CGFloat = 0
                if frame.origin.x > targetX {
                    frame.origin.x = 0
                    self.containerView.frame = frame
                    isReversing = false
                }else {
                    frame.origin.x += pointsPerFrame
                    if frame.origin.x > 0 {
                        frame.origin.x = 0
                        isReversing = false
                    }
                    self.containerView.frame = frame
                }
            }else {
                let targetX = self.bounds.size.width - self.containerView.bounds.size.width
                if frame.origin.x <= targetX {
                    isReversing = true
                }else {
                    frame.origin.x -= pointsPerFrame
                    if frame.origin.x < targetX {
                        frame.origin.x = targetX
                        isReversing = true
                    }
                    self.containerView.frame = frame
                }
            }
        case .fromTop: break
            
        case .fromBottom: break
            
        }
    }
}








