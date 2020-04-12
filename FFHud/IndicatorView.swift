//
//  IndicatorView.swift
//  Cash App
//
//  Created by edz on 2019/3/28.
//  Copyright © 2019 miaomiao. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class IndicatorView: UIView {
    
    private var textLocation:TextLocationType = .middle
    private var animationType:NVActivityIndicatorType = .ballBeat
    private var text:String = "加载中..."
    private var smallIndicotr:Bool = false
    private var lightType:Bool = false
    
    public init(
        text:String = "",
        lightType:Bool = false,
        smallIndicator:Bool = false,
        textLocation:TextLocationType = .right,
        animationType:NVActivityIndicatorType = .ballBeat) {
        super.init(frame: CGRect.zero)
        self.text = text
        self.lightType = lightType
        self.smallIndicotr = smallIndicator
        self.textLocation = textLocation
        self.animationType = animationType
        self.translatesAutoresizingMaskIntoConstraints = false
        setView()
        
    }
    
   private func setView() {
        if  smallIndicotr == true {
            setupSmallIndicator()
            backgroundColor = UIColor.clear
            layer.cornerRadius = 0
            layer.masksToBounds = false
        }else{
            setupSubviews()
            layer.cornerRadius = 4
            layer.masksToBounds = true
            backgroundColor = lightType == false ? UIColor.black.withAlphaComponent(0.9):#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        }
        startAnimation()
    }
    
    func resetView(text:String = "",lightType:Bool = false,smallIndicator:Bool = false,textLocation:TextLocationType = .right,animationType:NVActivityIndicatorType = .ballBeat) {
        
        self.text = text
        self.smallIndicotr = smallIndicator
        self.textLocation = textLocation
        self.animationType = animationType
        self.lightType = lightType
        stopAnimation()
        clearConstrains()
        for sub in self.subviews{
            sub.removeFromSuperview()
        }
        setView()
    }
    
   private func clearConstrains() {
        removeConstraints(fo: indicator)
        removeConstraints(fo: self)
        removeConstraints(fo: textLab)
    }
    
   private func removeConstraints(fo view:UIView)  {
        let constraints = view.constraints
        NSLayoutConstraint.deactivate(constraints)
    }
    
    ///小加载图
   private func setupSmallIndicator() {
        addSubview(indicator)
        NSLayoutConstraint.activate([
            indicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            indicator.widthAnchor.constraint(equalToConstant: 60),
            indicator.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    ///设置子视图
    private func setupSubviews()  {
        addSubview(indicator)
        addSubview(textLab)
        textLab.text = text
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(greaterThanOrEqualToConstant: 100),
            self.heightAnchor.constraint(greaterThanOrEqualToConstant: 100),
            self.heightAnchor.constraint(lessThanOrEqualTo: self.widthAnchor),
        ])
        
        let indicatorTopanchor = indicator.topAnchor.constraint(equalTo: self.topAnchor)
        indicatorTopanchor.constant = 8
        NSLayoutConstraint.activate([
            indicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            indicator.heightAnchor.constraint(equalToConstant: 60),
            indicator.widthAnchor.constraint(equalToConstant: 60),
            indicatorTopanchor
        ])
        let textLabLeading = textLab.leadingAnchor.constraint(greaterThanOrEqualTo: self.leadingAnchor)
        textLabLeading.constant = 10
        let textTopAnchor = textLab.topAnchor.constraint(equalTo: indicator.bottomAnchor)
        textTopAnchor.constant = 2
        let textBottomAnchor = textLab.bottomAnchor.constraint(greaterThanOrEqualTo: self.bottomAnchor, constant: -12)
        let maxWidthAnchor = textLab.widthAnchor.constraint(lessThanOrEqualToConstant: 120)

        NSLayoutConstraint.activate([
            textLabLeading,
            textTopAnchor,
            textBottomAnchor,
            maxWidthAnchor,
            textLab.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    
   private func  startAnimation()  {
        indicator.startAnimating()
    }
    
   private func stopAnimation(){
        indicator.stopAnimating()
    }
    
   private lazy var indicator: NVActivityIndicatorView = {
        let view = NVActivityIndicatorView.init(frame: CGRect.init(x: 0, y: 0, width: 60, height: 60), type: self.animationType, color: self.lightType == true ? UIColor.white : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) , padding: 10)
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
   private lazy var textLab: UILabel = {
        let text = UILabel.init()
        text.font = UIFont.systemFont(ofSize: 15)
        text.textAlignment = .center
        text.numberOfLines = 0
        text.textColor =  lightType == true ? UIColor.white : UIColor.white
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
