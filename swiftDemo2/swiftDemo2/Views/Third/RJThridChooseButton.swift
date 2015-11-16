//
//  RJThridChooseButton.swift
//  swiftDemo2
//
//  Created by 辉贾 on 15/11/13.
//  Copyright © 2015年 RJ. All rights reserved.
//

import UIKit

class RJThridChooseButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        self.imageView?.setPositionX(self.width()-(self.imageView?.width())!-UIScreenSize.WIDTHMAKE(5))
        self.titleLabel?.setPositionX(UIScreenSize.WIDTHMAKE(7))
        self.titleLabel?.setWidth(self.width()-(self.imageView?.width())!-UIScreenSize.WIDTHMAKE(12))
        self.titleLabel?.textAlignment = .Center
    }
}
