//
//  UIView-Extension.swift
//  swiftDemo2
//
//  Created by 辉贾 on 15/11/7.
//  Copyright © 2015年 RJ. All rights reserved.
//

import Foundation

extension UIView {

    func width() -> CGFloat {
        return self.frame.size.width
    }

    func height() -> CGFloat {
        return self.frame.size.height
    }
    
    func positionX() -> CGFloat {
        return self.frame.origin.x
    }
    
    func positionY() -> CGFloat {
        return self.frame.origin.y
    }
    
    func right() -> CGFloat {
        return self.positionX()+self.width()
    }
    
    func bottom() -> CGFloat {
        return self.positionY() + self.height()
    }
    
    func setWidth(width: CGFloat) {
        self.frame = CGRect(x: self.positionX(), y: self.positionY(), width: width, height: self.height())
    }

    func setHeight(height: CGFloat) {
        self.frame = CGRect(x: self.positionX(), y: self.positionY(), width: self.width(), height: height)
    }

    func setPositionX(x: CGFloat) {
        self.frame = CGRect(x: x, y: self.positionY(), width: self.width(), height: self.height())
    }

    func setPositionY(y: CGFloat) {
        self.frame = CGRect(x: self.positionX(), y: y, width: self.width(), height: self.height())
    }
    
    func setCornerRadius(corner:CGFloat) {
        self.layer.cornerRadius = corner
    }
    
    

}
