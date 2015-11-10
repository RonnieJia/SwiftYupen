//
//  RJFirstCollectionViewCell.swift
//  swiftDemo2
//
//  Created by 辉贾 on 15/11/8.
//  Copyright © 2015年 RJ. All rights reserved.
//

import UIKit

class RJFirstCollectionViewCell: UICollectionViewCell {
    
    var imageView: UIImageView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.imageView = UIImageView(frame: self.bounds)
        self.addSubview(self.imageView!)
        self.backgroundColor = UIColor.whiteColor()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
