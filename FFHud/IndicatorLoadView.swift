//
//  IndicatorLoadView.swift
//  Cash App
//
//  Created by edz on 2019/3/27.
//  Copyright © 2019 miaomiao. All rights reserved.
//

import UIKit
import NVActivityIndicatorView


enum TextLocationType :Int{
    case middle = 1
    case right
}

class IndicatorLoadView: UIView {
    
    private let animationTime = 0.25
    private var text = ""
    weak var view:UIView?
    var completionBlock:(()->Void)?
    private var lightType = false
    private var textLocation:TextLocationType = .middle
    private var animationType:NVActivityIndicatorType = .ballBeat
    private var smallIndicator :Bool = false
    
    class func showOn(
        view:UIView,
        text:String,
        lightType:Bool = false,
        smallIndicator :Bool = false,
        animationType:NVActivityIndicatorType = .ballBeat,
        textLocation:TextLocationType = .middle,
        userInteractionIsEnabled :Bool,
        completionBlock: (()->Void)? = nil) {
        
        var preHud : IndicatorLoadView?
        for sub in view.subviews{
            if let sub = sub as? IndicatorLoadView{
                preHud = sub
                break
            }
        }
        
        if let preHud = preHud {
            preHud.contentView.resetView(text: text, smallIndicator: smallIndicator, textLocation: textLocation, animationType: animationType)
            preHud.animationShow()
        }else{
            let hud = IndicatorLoadView.init(view: view, text: text,lightType:lightType, smallIndicator: smallIndicator, animationType: animationType, textLocation: textLocation, userInteractionIsEnabled: userInteractionIsEnabled, completionBlock: completionBlock)
            hud.animationShow()
        }
    }
    
    
    
    class func showIndicator(view:UIView,animationType:NVActivityIndicatorType,userInteractionIsEnabled :Bool,completionBlock: (()->Void)? = nil){
        var preHud : IndicatorLoadView?
        for sub in view.subviews{
            if let sub = sub as? IndicatorLoadView{
                preHud = sub
                break
            }
        }
        if let preHud = preHud {
            preHud.contentView.resetView(smallIndicator: true, animationType: animationType)
            preHud.animationShow()
        }else{
            let hud = IndicatorLoadView.init(view: view, smallIndicator: true, animationType:animationType, userInteractionIsEnabled: userInteractionIsEnabled, completionBlock: completionBlock)
            hud.animationShow()
        }
    }
    
    
    private init(
        view:UIView,
        text:String = "",
        lightType:Bool = false,
        smallIndicator:Bool = false,
        animationType:NVActivityIndicatorType = .ballBeat,
        textLocation:TextLocationType = .middle,
        userInteractionIsEnabled :Bool,
        completionBlock: (()->Void)? = nil) {
        
        super.init(frame: view.bounds)
        self.text = text
        self.view = view
        self.lightType = lightType
        self.animationType = animationType
        self.textLocation = textLocation
        self.smallIndicator = smallIndicator
        self.alpha = 0
        if userInteractionIsEnabled == true && smallIndicator == false{
            self.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        }else{
            self.backgroundColor = UIColor.clear
        }
        self.translatesAutoresizingMaskIntoConstraints = false
        self.completionBlock = completionBlock
        self.isUserInteractionEnabled = userInteractionIsEnabled
        self.setupSubviews()        
    }
    
    ///重写该事件,在页面不支持用户交互时,在这里接收手势事件,但是不处理
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    class func hide(for view:UIView,animation:Bool){
        for sub in view.subviews{
            if let sub = sub as? IndicatorLoadView{
                sub.animationHide(animation)
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    ///加载子视图
    private func setupSubviews(){
        
        self.view?.addSubview(self)
        self.addSubview(contentView)
        let top = NSLayoutConstraint.init(item: self, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: 0)
        let left = NSLayoutConstraint.init(item: self, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1, constant: 0)
        let centerx = NSLayoutConstraint.init(item: self, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0)
        let centery = NSLayoutConstraint.init(item: self, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1, constant: 0)
        self.view!.addConstraints([top,left,centery,centerx])
        let contentCenterX = NSLayoutConstraint.init(item: contentView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
        let contentCenterY = NSLayoutConstraint.init(item: contentView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
        self.addConstraints([contentCenterX,contentCenterY])
        
    }
    
    lazy var contentView: IndicatorView = {
        let view = IndicatorView.init(text: self.text,lightType :self.lightType, smallIndicator: self.smallIndicator, textLocation: self.textLocation, animationType: self.animationType)
        return view
    }()
    
    
    ///动画加载
    private  func animationShow(){
        UIView.animate(withDuration: animationTime, delay: 0, options: .curveEaseInOut, animations: {
            self.alpha = 1
        }) { (complete) in}
        layoutIfNeeded()
        
    }
    
    private func animationHide(_ animation:Bool)  {
        
        if animation == true {
            UIView.animate(withDuration: animationTime, delay: 0, options: .curveEaseInOut, animations: {
                self.alpha = 0
            }) { (complete) in self.removeFromSuperview()}
        }else{
            self.removeFromSuperview()
        }
    }
    
}
