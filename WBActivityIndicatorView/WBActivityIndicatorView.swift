//
//  WBActivityIndicatorView.swift
//  WBActivityIndicatorView
//
//  Created by Zwb on 16/4/6.
//  Copyright © 2016年 zwb. All rights reserved.
//

import UIKit

class WBActivityIndicatorView: UIView {
    
    let viewLayer   = CALayer()
    let maskLayer   = CAShapeLayer()
    var linewidth   = CGFloat()
    var topcolor    = UIColor()
    var bottomcolor = UIColor()
    var warnlabel   = UILabel()
    
    /**
     传递四个参数进入
     
     - parameter frame:       view  frame
     - parameter lineWidth:   圆环宽度
     - parameter topColor:    上部颜色
     - parameter bottomColor: 下部颜色
     
     - returns:
     */
    init(frame: CGRect, lineWidth:CGFloat, topColor:UIColor, bottomColor:UIColor) {
        super.init(frame:frame)
        self.backgroundColor = UIColor.clearColor()
        
        linewidth = lineWidth
        topcolor = topColor
        bottomcolor = bottomColor
        
        initView()
    }
    
    /*
    override func drawRect(rect: CGRect) {
        // 绘制渐变色
        let startComponents = CGColorGetComponents(topcolor.CGColor)
        let endComponents = CGColorGetComponents(bottomcolor.CGColor)
        let colorComponents = [startComponents[0], startComponents[1], startComponents[2], startComponents[3], endComponents[0], endComponents[1], endComponents[2], endComponents[3]]
        let colorLocations:[CGFloat] = [0.0, 1.0]
        let startPoint = CGPointMake(getViewWidth()/2, 0)
        let endPoint = CGPointMake(getViewWidth()/2, getViewHeight())
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let gradientRef = CGGradientCreateWithColorComponents(colorSpace, colorComponents, colorLocations, 2)
        let context = UIGraphicsGetCurrentContext()
        CGContextDrawLinearGradient(context, gradientRef, startPoint, endPoint, CGGradientDrawingOptions.DrawsBeforeStartLocation)
    }
    */
    
    func showActivityViw(view: UIView) ->  Void{
        self.center = view.center;
        view.addSubview(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func initView() -> Void {
        setLayer()
        // 设置渐变色
        let gradient = CAGradientLayer.init()
        gradient.bounds = self.bounds
        gradient.position = self.center
        gradient.colors = [topcolor.CGColor, bottomcolor.CGColor]
        gradient.startPoint = CGPointMake(0, 1);
        gradient.endPoint = CGPointMake(0, 0);
        viewLayer.addSublayer(gradient)
        
        viewLayer.mask = maskLayer
        let path = UIBezierPath.init(arcCenter: self.center, radius: getViewWidth()/2-linewidth/2, startAngle:CGFloat(-M_PI_2), endAngle: CGFloat(M_PI*2+M_PI_2*3), clockwise: true)
        maskLayer.path = path.CGPath
        maskLayer.strokeStart = 0.0
        maskLayer.strokeEnd = 0.25
    }
    
    func setProgress(progress: CGFloat) -> Void {
        warnlabel.text = (NSString.init(format: "%0.0f", (progress * 100)) as String).stringByAppendingString("%")
    }
    
    func setLayer() -> Void {
        viewLayer.bounds = self.bounds
        viewLayer.position = self.center
        self.layer.addSublayer(viewLayer)
        
        maskLayer.bounds = self.bounds
        maskLayer.position = self.center
        maskLayer.lineWidth = linewidth
        maskLayer.strokeColor = topcolor.CGColor
        maskLayer.fillColor = UIColor.clearColor().CGColor
        
        warnlabel.backgroundColor = UIColor.redColor()
        warnlabel = UILabel.init()
        warnlabel.bounds = CGRectMake(0, 0, getViewWidth()-linewidth*2, 20)
        warnlabel.center = self.center
        warnlabel.text = "0%"
        warnlabel.textAlignment = NSTextAlignment.Center
        warnlabel.font = UIFont.systemFontOfSize(15*getViewWidth()/60)
        warnlabel.textColor = UIColor.blackColor()
        self.addSubview(warnlabel)
    }
    
    func getViewWidth() -> CGFloat {
        return self.bounds.size.width
    }
    
    func getViewHeight() -> CGFloat {
        return self.bounds.size.height
    }
    
    /**
     开始执行动画
     */
    func start() -> Void {
        let animation = CABasicAnimation.init(keyPath: "transform.rotation.z")
        animation.toValue = M_PI*2
        animation.duration = 0.5
        animation.cumulative = true
        animation.repeatCount = Float(NSIntegerMax)
        maskLayer.addAnimation(animation, forKey: nil)
    }
    
    /**
     结束动画
     */
    func stop() -> Void {
        maskLayer.removeAllAnimations()
//        self.removeFromSuperview()
        
        // 动画式缩小隐藏
        UIView.animateWithDuration(0.25, animations: {
                self.transform = CGAffineTransformMakeScale(0.0001, 0.0001)
            }) { (true) in
                self.removeFromSuperview()
        }
    }
}