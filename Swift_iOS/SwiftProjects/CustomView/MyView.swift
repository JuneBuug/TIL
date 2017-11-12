//
//  MyView.swift
//  CustomViewPractice
//
//  Created by woowabrothers on 2017. 7. 13..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//


import UIKit

class MyView : UIView {
    

    
    override func draw(_ rect: CGRect) {
        UIColor.brown.setFill()
        UIRectFill(self.bounds)
        
        let currentContext = UIGraphicsGetCurrentContext()
        
        
        // 3
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        // 4
        let startColor = hexStringToUIColor(hex: "#e0c3fc")
        var startColorComponents = startColor.cgColor.components
        let endColor = hexStringToUIColor(hex: "#8ec5fc")
        var endColorComponents = endColor.cgColor.components
        
        // 5
        let colorComponents : [CGFloat]
            = [startColorComponents![0], startColorComponents![1], startColorComponents![2], startColorComponents![3], endColorComponents![0], endColorComponents![1], endColorComponents![2], endColorComponents![3]]
        
        // 6
        let locations:[CGFloat] = [0.0, 1.0]
        
        // 7
        let gradient = CGGradient(colorSpace: colorSpace,colorComponents: colorComponents,locations: locations,count: 2)
        
    
        let startPoint = CGPoint(x: 0, y: 0)
        let endPoint = CGPoint(x: self.bounds.width, y: self.bounds.height)
        
        // 8
        currentContext?.drawLinearGradient(gradient!, start: startPoint, end: endPoint, options: CGGradientDrawingOptions(rawValue: UInt32(0)))
        
        
        // https://www.ioscreator.com/tutorials/draw-gradients-core-graphics-tutorial-ios10
    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.characters.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
}
