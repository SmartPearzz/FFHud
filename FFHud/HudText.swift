//
//  HudText.swift
//  HudText
//
//  Created by edz on 2019/1/16.
//  Copyright © 2019 miaomiao. All rights reserved.
//

import Foundation
import UIKit
private let animationTime = 0.25

public class HudText: UIView {
    
    private var text = ""
    private var duration:Double = 2.0
    private var dim = false
    private var view:UIView?
    private var tap:UITapGestureRecognizer?
    private var completionBlock:(()->Void)?
    private var light:Bool = false
    
    class func showOn(view:UIView,text:String = "",light:Bool = false,duration:TimeInterval = 2.0,dim:Bool = false,completionBlock: (()->Void)? = nil)  {
        var preHud : HudText?
        for sub in view.subviews{
            if let sub = sub as? HudText{
                preHud = sub
                break
            }
        }
        if let pre = preHud {
            pre.resetText(text: text)
        }else{
            let hud = HudText.init(view: view, text: text,light: light, duration: duration, dim: dim)
            view.addSubview(hud)
        }
    }
    
    init(view:UIView,text:String = "",light:Bool = false,duration:TimeInterval = 1.0,dim:Bool = false,completionBlock: (()->Void)? = nil) {
        
        super.init(frame: CGRect.zero)
        self.text = text
        self.dim = dim
        self.duration = duration
        self.view = view
        self.backgroundColor = UIColor.clear
        self.translatesAutoresizingMaskIntoConstraints = false
        self.alpha = 0.1
        self.completionBlock = completionBlock
        self.dim = !dim
        self.light = light
        self.isUserInteractionEnabled = !dim
        self.setupSubviews()
        self.animationShow()
        self.delayHide()
    }
    
    private  func animationShow()  {
        
        UIView.animate(withDuration: animationTime, delay: 0, options: .curveEaseInOut, animations: {
            self.alpha = 1.0
        }) { (_) in
            
        }
    }
    
    private func resetText(text:String) {
        self.text = text
        textLab.text = text
        UIView.animate(withDuration: animationTime) {
            self.layoutIfNeeded()
        }
        self.delayHide()
    }
    
    private  func delayHide() {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(animationHide), object: self)
        self.perform(#selector(animationHide), with: self, afterDelay: self.duration)
    }
    
    @objc func animationHide() {
        UIView.animate(withDuration: animationTime, delay: 0, options: .curveEaseInOut, animations: {
            self.alpha = 0
        }) { (complete) in
            self.removeFromSuperview()
            if let doCourse = self.completionBlock{
                doCourse()
            }
        }
    }
    
    private func setupSubviews()  {
        self.view?.addSubview(self)
        let top = NSLayoutConstraint.init(item: self, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: 0)
        let left = NSLayoutConstraint.init(item: self, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1, constant: 0)
        let centerx = NSLayoutConstraint.init(item: self, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0)
        let centery = NSLayoutConstraint.init(item: self, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1, constant: 0)
        self.view!.addConstraints([top,left,centery,centerx])
        
        self.addSubview(backView)
        let maxW = NSLayoutConstraint.init(item: backView, attribute: .width, relatedBy: .lessThanOrEqual, toItem: self, attribute: .width, multiplier: 0.9, constant: 0)
        let bcenterx = NSLayoutConstraint.init(item: backView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
        let bcentery = NSLayoutConstraint.init(item: backView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
        self.addConstraints([bcenterx,bcentery,maxW])
        backView.addSubview(textLab)
        textLab.text = text
        let ttop = NSLayoutConstraint.init(item: textLab, attribute: .top, relatedBy: .equal, toItem: backView, attribute: .top, multiplier: 1, constant: 14)
        let tleft = NSLayoutConstraint.init(item: textLab, attribute: .left, relatedBy: .equal, toItem: backView, attribute: .left, multiplier: 1, constant: 15)
        let tcenterx = NSLayoutConstraint.init(item: textLab, attribute: .centerX, relatedBy: .equal, toItem: backView, attribute: .centerX, multiplier: 1, constant: 0)
        let tcentery = NSLayoutConstraint.init(item: textLab, attribute: .centerY, relatedBy: .equal, toItem: backView, attribute: .centerY, multiplier: 1, constant: 0)
        self.addConstraints([ttop,tleft,tcenterx,tcentery])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var textLab: UILabel = {
        let lab = UILabel.init()
        lab.textAlignment = .center
        lab.numberOfLines = 0
        lab.translatesAutoresizingMaskIntoConstraints = false
        lab.backgroundColor = UIColor.clear
        lab.textColor = UIColor.white
        lab.font = UIFont.systemFont(ofSize: 16)
        return lab
    }()
    
    private lazy var backView: UIView = {
        let view = UIView.init()
        view.backgroundColor = self.light == false ? UIColor.black.withAlphaComponent(0.9):#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
}

