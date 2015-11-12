//
//  UIScreenFloat.swift
//  swiftDemo2
//
//  Created by jiapinghui on 15/11/9.
//  Copyright © 2015年 RJ. All rights reserved.
//

import Foundation

class UIScreenSize: NSObject {
    
    class func WIDTH() -> CGFloat {
        return UIScreen.mainScreen().bounds.size.width
    }
    
    class func HEIGHT() -> CGFloat {
        return UIScreen.mainScreen().bounds.size.height
    }
    
    class func WIDTHMAKE(width: CGFloat) -> CGFloat {
        return self.WIDTH()*width/320
    }
    
    class func HEIGHTMAKE(height: CGFloat) -> CGFloat {
        return self.HEIGHT()*height/568
    }
    
}

extension UIColor {
    class func lineColor() -> UIColor {
        return UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0)
    }
    
    class func backgroundColor() -> UIColor {
        return UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1.0)
    }
    
    class func redFontColor() -> UIColor {
        return UIColor(red: 1.00, green: 0.00, blue: 0.14, alpha: 1.0)
    }
    
    class func lightGrayFontColor() -> UIColor {
        return UIColor(red: 0.58, green: 0.58, blue: 0.58, alpha: 1.00)
    }
    
    class func darkGrayFontColor() -> UIColor {
        return UIColor(red: 0.26, green: 0.26, blue: 0.26, alpha: 1.00)
    }
}