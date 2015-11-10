//
//  RJFirestCollectionHeaderView.swift
//  swiftDemo2
//
//  Created by 辉贾 on 15/11/8.
//  Copyright © 2015年 RJ. All rights reserved.
//

import UIKit

class RJFirestCollectionHeaderView: UICollectionReusableView {

    override func applyLayoutAttributes(layoutAttributes: UICollectionViewLayoutAttributes) {
        let label = UILabel(frame: CGRectMake(10, 10, self.width()-20, 20))
        label.backgroundColor = UIColor.yellowColor()
        label.text = "hello world"
        label.textColor = UIColor.blackColor()
        self.addSubview(label)
    }
    
}
