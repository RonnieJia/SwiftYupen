//
//  RJFirstBottomCollectionViewCell.swift
//  swiftDemo2
//
//  Created by jiapinghui on 15/11/10.
//  Copyright © 2015年 RJ. All rights reserved.
//

import UIKit

class RJFirstBottomCollectionViewCell: UICollectionViewCell {
    
    var imageView: UIImageView?
    private var peopleLabel: UILabel?
    private var progressLabel: UILabel?
    private var moneyLabel: UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.imageView = UIImageView(frame: CGRect(x: UIScreenSize.WIDTHMAKE(10), y: UIScreenSize.HEIGHTMAKE(5), width: self.width()-UIScreenSize.WIDTHMAKE(20), height: self.height()-UIScreenSize.HEIGHTMAKE(10)))
//        self.imageView!.backgroundColor = UIColor.redColor()
        self.contentView.addSubview(self.imageView!)
        
        let blackView: UIView = UIView(frame: CGRect(x: UIScreenSize.WIDTHMAKE(10), y: self.height()-UIScreenSize.HEIGHTMAKE(45), width: self.width()-UIScreenSize.WIDTHMAKE(20), height: UIScreenSize.HEIGHTMAKE(40)))
        blackView.backgroundColor = UIColor.blackColor()
        blackView.alpha = 0.6
        self.contentView.addSubview(blackView)
        
        let line1 = UIView(frame: CGRect(x: UIScreenSize.WIDTHMAKE(300)/3.0, y: UIScreenSize.HEIGHTMAKE(5), width: 1, height: UIScreenSize.HEIGHTMAKE(30)))
        line1.backgroundColor = UIColor.whiteColor()
        blackView.addSubview(line1)
        let line2 = UIView(frame: CGRect(x: UIScreenSize.WIDTHMAKE(300)/3.0*2.0, y: UIScreenSize.HEIGHTMAKE(5), width: 1, height: UIScreenSize.HEIGHTMAKE(30)))
        line2.backgroundColor = UIColor.whiteColor()
        blackView.addSubview(line2)
        
        let titleArr = ["支持人数", "众筹进度", "募集金额"]
        for i: Int in 0...2 {
            let nameLabel = UILabel(frame: CGRect(x: UIScreenSize.WIDTHMAKE(300)/3.0 * CGFloat(i), y: UIScreenSize.HEIGHTMAKE(22), width: UIScreenSize.WIDTHMAKE(300)/3.0, height: UIScreenSize.HEIGHTMAKE(15)))
            nameLabel.font = UIFont.systemFontOfSize(UIScreenSize.HEIGHTMAKE(10.0))
            nameLabel.textAlignment = .Center
            nameLabel.textColor = UIColor.whiteColor()
            blackView.addSubview(nameLabel)
            nameLabel.text = titleArr[i]
            
            let numLabel = UILabel(frame: CGRect(x: UIScreenSize.WIDTHMAKE(300)/3.0 * CGFloat(i), y: UIScreenSize.HEIGHTMAKE(10), width: UIScreenSize.WIDTHMAKE(300)/3.0, height: UIScreenSize.HEIGHTMAKE(15)))
            numLabel.font = UIFont.systemFontOfSize(UIScreenSize.HEIGHTMAKE(10.0))
            numLabel.textAlignment = .Center
            numLabel.textColor = UIColor.whiteColor()
            blackView.addSubview(numLabel)
            switch i {
                case 0:
                    self.peopleLabel = numLabel
                    break;
                case 1:
                    self.progressLabel = numLabel
                    break;
                default:
                    self.moneyLabel = numLabel
                    break;
            }
            
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func displayDataWithCell(product: RJCMProductModel){
        self.imageView?.sd_setImageWithURL(NSURL(string: product.PAppImage))
        self.peopleLabel?.text = product.SupportCount+"人"
        self.moneyLabel?.text = product.TotalAmount
        var progress: CGFloat
        if product.PIsAmountFixed != "0" {
            progress = CGFloat((product.TotalAmount as NSString).doubleValue/(product.PFixedAmount as NSString).doubleValue)*100
        } else {
            let dateFormatter: NSDateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let startTime = dateFormatter.dateFromString(product.PStartDate)!
            let endTime = dateFormatter.dateFromString(product.PEndDate)!
            let serverTime: NSDate?
            if (product.ServerTime as NSString).length<8 {
                serverTime = NSDate()
            } else {
                serverTime = dateFormatter.dateFromString(product.ServerTime)!
            }
            let allTime = endTime.timeIntervalSinceDate(startTime)
            let hadTime = serverTime?.timeIntervalSinceDate(startTime)
            progress = CGFloat(hadTime!/allTime*100)
        }
        if progress > 100.0 {
            progress = 100.00
        }
        self.progressLabel?.text = String(format: "%.2f", progress)+"%"
    }

    
}

/*
NSTimeInterval allTime = [endTime timeIntervalSinceDate:startTime];
NSTimeInterval hadTime = [serverTime timeIntervalSinceDate:startTime];
proggress = hadTime/(allTime)*100;
}
if (proggress >= 100.0) {
proggress = 100.0;
}
cell.progressLabel.text = [NSString stringWithFormat:@"%.2f%%",proggress];
cell.moneyLabel.text = [NSString stringWithFormat:@"%.2f",[model.TotalAmount d*/
