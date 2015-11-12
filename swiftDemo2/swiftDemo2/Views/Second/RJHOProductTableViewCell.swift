//
//  RJHOProductTableViewCell.swift
//  swiftDemo2
//
//  Created by jiapinghui on 15/11/12.
//  Copyright © 2015年 RJ. All rights reserved.
//

import UIKit

class RJHOProductTableViewCell: UITableViewCell {
    
    private var titleLabel:             UILabel?
    private var giftImageView:          UIImageView?
    private var deadLineLabel:          UILabel?
    private var moneyLabel:             UILabel?
    private var profitLabel:            UILabel?
    private var profitIntroductLabel:   UILabel?
    private var progressView:           RJProgressView?
    private var persentLabel:           UILabel?
    
    static let identifier = "cell"
    class func dequCell(tableView: UITableView) -> RJHOProductTableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier)
        if cell == nil {
            cell = RJHOProductTableViewCell(style: .Default, reuseIdentifier: identifier)
        }
        return cell as! RJHOProductTableViewCell
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let introuceImageView = UIImageView(frame: CGRect(x: UIScreenSize.WIDTHMAKE(89.5), y: UIScreenSize.HEIGHTMAKE(9), width: UIScreenSize.WIDTHMAKE(0.5), height: UIScreenSize.HEIGHTMAKE(94)))
        self.contentView.addSubview(introuceImageView)
        introuceImageView.image = UIImage(named: "RJCellLine.png")
        
        let arrowImageView = UIImageView(frame: CGRect(x: UIScreenSize.WIDTHMAKE(285), y: UIScreenSize.HEIGHTMAKE(50), width: UIScreenSize.WIDTHMAKE(20), height: UIScreenSize.HEIGHTMAKE(20)))
        self.contentView.addSubview(arrowImageView)
        arrowImageView.image = UIImage(named: "RJSeconrArrow.png")
        
        self.titleLabel = UILabel(frame: CGRect(x: UIScreenSize.WIDTHMAKE(100), y: UIScreenSize.HEIGHTMAKE(15), width: UIScreenSize.WIDTHMAKE(200), height: UIScreenSize.HEIGHTMAKE(30)))
        self.titleLabel!.font = UIFont.systemFontOfSize(UIScreenSize.HEIGHTMAKE(20))
        self.contentView.addSubview(self.titleLabel!)
        
        self.giftImageView = UIImageView(frame: CGRect(x: UIScreenSize.WIDTHMAKE(165), y: UIScreenSize.HEIGHTMAKE(22), width: UIScreenSize.WIDTHMAKE(16), height: UIScreenSize.HEIGHTMAKE(16)))
        self.contentView.addSubview(self.giftImageView!)
        self.giftImageView?.backgroundColor = UIColor.clearColor()
        self.giftImageView?.image = UIImage(named: "RJSecondGift.png")
        self.giftImageView?.hidden = true
        
        self.deadLineLabel = UILabel(frame: CGRect(x: UIScreenSize.WIDTHMAKE(100), y: UIScreenSize.HEIGHTMAKE(40), width: UIScreenSize.WIDTHMAKE(200), height: UIScreenSize.HEIGHTMAKE(30)))
        self.deadLineLabel?.font = UIFont.systemFontOfSize(UIScreenSize.HEIGHTMAKE(14))
        self.deadLineLabel?.textColor = UIColor.lightGrayColor()
        self.contentView.addSubview(self.deadLineLabel!)
        
        self.moneyLabel = UILabel(frame: CGRect(x: UIScreenSize.WIDTHMAKE(100), y: UIScreenSize.HEIGHTMAKE(65), width: UIScreenSize.WIDTHMAKE(200), height: UIScreenSize.HEIGHTMAKE(30)))
        self.moneyLabel?.font = UIFont.systemFontOfSize(UIScreenSize.HEIGHTMAKE(14))
        self.moneyLabel?.textColor = UIColor.lightGrayColor()
        self.contentView.addSubview(self.moneyLabel!)
        
        self.profitLabel = UILabel(frame: CGRect(x: UIScreenSize.WIDTHMAKE(0), y: UIScreenSize.HEIGHTMAKE(15), width: UIScreenSize.WIDTHMAKE(90), height: UIScreenSize.HEIGHTMAKE(60)))
        self.profitLabel?.font = UIFont.systemFontOfSize(UIScreenSize.HEIGHTMAKE(18))
        self.profitLabel?.textColor = UIColor.redColor()
        self.profitLabel?.shadowOffset = CGSizeMake(1, 0)
        self.profitLabel?.shadowColor = UIColor.lightGrayFontColor()
        self.profitLabel?.textAlignment = .Center
        self.contentView.addSubview(self.profitLabel!)
        
        self.profitIntroductLabel = UILabel(frame: CGRect(x: UIScreenSize.WIDTHMAKE(0), y: UIScreenSize.HEIGHTMAKE(80), width: UIScreenSize.WIDTHMAKE(90), height: UIScreenSize.HEIGHTMAKE(15)))
        self.profitIntroductLabel?.font = UIFont.systemFontOfSize(UIScreenSize.HEIGHTMAKE(12.0))
        self.profitIntroductLabel?.textColor = UIColor.darkGrayFontColor()
        self.profitIntroductLabel?.textAlignment = .Center
        self.contentView.addSubview(self.profitIntroductLabel!)
        
        self.progressView = RJProgressView(frame: CGRect(x: UIScreenSize.WIDTHMAKE(200), y: UIScreenSize.HEIGHTMAKE(16), width: UIScreenSize.WIDTHMAKE(80), height: UIScreenSize.HEIGHTMAKE(80)))
        self.progressView?.backgroundColor = UIColor.clearColor()
        self.progressView?.strokeColor = UIColor(red: 0.87, green: 0.87, blue: 0.87, alpha: 1.0)
        self.progressView?.coverWidth = 2.5
        self.progressView?.loadIndicator()
        self.contentView.addSubview(self.progressView!)
        
        self.persentLabel = UILabel(frame: CGRect(x: UIScreenSize.WIDTHMAKE(10), y: UIScreenSize.HEIGHTMAKE(30), width: UIScreenSize.WIDTHMAKE(60), height: UIScreenSize.HEIGHTMAKE(20)))
        self.persentLabel?.font = UIFont.systemFontOfSize(UIScreenSize.HEIGHTMAKE(14.0))
        self.persentLabel?.textColor = UIColor(red: 0.40, green: 0.40, blue: 0.40, alpha: 1.0)
        self.persentLabel?.adjustsFontSizeToFitWidth = true
        self.persentLabel?.textAlignment = .Center
        self.progressView?.addSubview(self.persentLabel!)
    }
    
    func cellDisplayData(product: RJProjectModel) {
        self.profitIntroductLabel?.text = product.TopTwo
        
        let rateStr: NSString = product.TopoOne as NSString
        let attributeRate = NSMutableAttributedString(string: rateStr as String)
        attributeRate.addAttribute(NSFontAttributeName, value: UIFont.systemFontOfSize(UIScreenSize.HEIGHTMAKE(38)), range: NSMakeRange(0, rateStr.length-3))
        self.profitLabel?.attributedText = attributeRate
        
        self.titleLabel?.text = product.GeneralName
        
        if product.IsLotteryDraw == "1" {
            self.giftImageView?.hidden = false
        } else {
            self.giftImageView?.hidden = true
        }
        
        let deadLineStr = "期限 "+product.MinimumTerm+" 个月"
        let deadAttibute = NSMutableAttributedString(string: deadLineStr)
        deadAttibute.addAttribute(NSForegroundColorAttributeName, value: UIColor.redFontColor(), range: NSMakeRange(3, (product.MinimumTerm as NSString).length))
        self.deadLineLabel?.attributedText = deadAttibute
        
        let moneyStr = "起投额 "+product.MinimumMoney+" 元"
        let moneyAttibute = NSMutableAttributedString(string: moneyStr)
        moneyAttibute.addAttribute(NSForegroundColorAttributeName, value: UIColor.redFontColor(), range: NSMakeRange(4, (product.MinimumMoney as NSString).length))
        self.moneyLabel?.attributedText = moneyAttibute
        
        var progress: Float = ((product.sum as NSString).floatValue-(product.haveing as NSString).floatValue)/(product.sum as NSString).floatValue
        if (product.sum as NSString).floatValue<=0 || (product.haveing as NSString).floatValue<=0 {
            progress = 1;
        }
        if progress < 0.04 {
            progress = 0.04
        } else if progress > 0.97 && progress < 1.0 {
            progress = 0.97
        }
        self.progressView?.allProducts(1.0, haveSelled: CGFloat(progress))
        
        if (product.haveing as NSString).floatValue <= 0 {
            self.persentLabel?.text = "已抢光"
        } else {
            self.persentLabel?.text = String(format: "%.2f万", (product.haveing as NSString).floatValue/20)
        }
        
        self.setNeedsLayout()
        
    }
    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)!
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.whiteColor()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
