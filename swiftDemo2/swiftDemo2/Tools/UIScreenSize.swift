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