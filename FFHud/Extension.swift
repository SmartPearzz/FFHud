//
//  Extension.swift
//  SwiftHud
//
//  Created by 王欣 on 4/12/20.
//  Copyright © 2020 QFPay. All rights reserved.
//

import Foundation
import UIKit

public extension UIViewController{
    
     @objc func display(
        text:String,
        light:Bool = false,
        animated: Bool = true,
        duration :Double = 1.5,
        dim:Bool = true){
        HudText.showOn(view: self.view, text: text,light: light, duration: duration, dim: dim)
    }
    
    @objc func displayLoading(
        text: String = "加载中...",
        lightType:Bool = false,
        userInteractionIsEnabled:Bool = true,
        onWindow:Bool = false) {
        
        if onWindow == true {
            let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first!
            IndicatorLoadView.showOn(view: window,text: text,lightType:lightType, textLocation:.middle, userInteractionIsEnabled: userInteractionIsEnabled)
        }else{
            IndicatorLoadView.showOn(view: self.view,text: text,lightType:lightType, textLocation:.middle, userInteractionIsEnabled: userInteractionIsEnabled)
        }
    }
    
    
    @objc func hideLoading(animated: Bool = true) {
        IndicatorLoadView.hide(for: self.view,animation: animated)
    }
}

extension UIView{
    
    @objc func showText(_ text:String){
        HudText.showOn(view:UIApplication.shared.windows.filter{$0.isKeyWindow}.first!, text: text,light: false, duration: 1.5, dim: true)
    }
}
