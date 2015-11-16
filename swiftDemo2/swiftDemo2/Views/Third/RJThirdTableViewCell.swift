//
//  RJThirdTableViewCell.swift
//  swiftDemo2
//
//  Created by 辉贾 on 15/11/14.
//  Copyright © 2015年 RJ. All rights reserved.
//

import UIKit

class RJThirdTableViewCell: UITableViewCell {
    
    var progress: CGFloat = 0.5
    
    /// 容器
    private var containerView: UIView = UIView()
    /// 描述图片
    private var backImageView: UIImageView = UIImageView()
    /// 状态
    private var statusLabel: UILabel = UILabel()
    /// 描述Label
    private var detailLabel: UILabel = UILabel()
    /// 进度条
    private var fullLine: UIView = UIView()
    private var currentLine: UIView = UIView()
    
    private var dataView: UIView?
    /// 支持人数
    private var supportLabel: UILabel = UILabel()
    /// 进度
    private var progressLabel: UILabel = UILabel()
    /// 募集金额
    private var moneyLabel:UILabel = UILabel()
    
    static let identifier = "cell"
    class func dequCell(tableView: UITableView) -> RJThirdTableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier)
        if cell == nil {
            cell = RJThirdTableViewCell(style: .Default, reuseIdentifier: identifier)
        }
        return cell as! RJThirdTableViewCell
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.whiteColor()
        
        self.containerView = UIView()
        self.containerView.backgroundColor = UIColor.backgroundColor()
        self.containerView.layer.cornerRadius = 2
        self.contentView.addSubview(self.containerView)
        
        self.backImageView = UIImageView()
        self.backImageView.backgroundColor = UIColor.clearColor()
        self.containerView.addSubview(self.backImageView)
        
        self.statusLabel = UILabel()
        self.statusLabel.backgroundColor = UIColor(red: 0.98, green: 0.25, blue: 0.36, alpha: 1.0)
        self.statusLabel.font = UIFont.boldSystemFontOfSize(UIScreenSize.HEIGHTMAKE(14.0))
        self.statusLabel.textAlignment = .Center
        self.statusLabel.textColor = UIColor.whiteColor()
        self.statusLabel.layer.cornerRadius = 2
        self.statusLabel.layer.masksToBounds = true
        self.containerView.addSubview(self.statusLabel)
        
        self.detailLabel.backgroundColor = UIColor.clearColor()
        self.detailLabel.textAlignment = .Left
        self.detailLabel.font = UIFont.systemFontOfSize(UIScreenSize.HEIGHTMAKE(12.0))
        self.detailLabel.numberOfLines = 0
        self.containerView.addSubview(self.detailLabel)
        
        self.fullLine.backgroundColor = UIColor(red: 0.84, green: 0.84, blue: 0.84, alpha: 1.0)
        self.fullLine.layer.cornerRadius = UIScreenSize.WIDTHMAKE(2)
        self.fullLine.layer.masksToBounds = true
        self.containerView.addSubview(self.fullLine)
        self.currentLine.backgroundColor = UIColor(red: 0.98, green: 0.09, blue: 0.29, alpha: 1.0)
        self.currentLine.layer.cornerRadius = UIScreenSize.WIDTHMAKE(2.0)
        self.currentLine.layer.masksToBounds = true
        self.containerView.addSubview(self.currentLine)
        
        self.dataView = self.createBottomUI()
        self.containerView.addSubview(self.dataView!)
        
        
    }
    
    override func layoutSubviews() {
        self.containerView.frame = CGRect(x: UIScreenSize.WIDTHMAKE(10), y: UIScreenSize.HEIGHTMAKE(10), width: self.width()-UIScreenSize.WIDTHMAKE(20), height: self.height()-UIScreenSize.HEIGHTMAKE(20))
        self.backImageView.frame = CGRect(x: 0, y: 0, width: self.containerView.width(), height: UIScreenSize.HEIGHTMAKE(146))
        self.statusLabel.frame = CGRect(x: UIScreenSize.WIDTHMAKE(10), y: self.backImageView.bottom()+UIScreenSize.HEIGHTMAKE(10), width: UIScreenSize.WIDTHMAKE(55), height: UIScreenSize.HEIGHTMAKE(19))
        self.detailLabel.frame = CGRect(x: self.statusLabel.right(), y: self.statusLabel.positionY(), width: UIScreenSize.WIDTHMAKE(213), height: self.statusLabel.height())
        self.fullLine.frame = CGRect(x: UIScreenSize.WIDTHMAKE(13), y: self.statusLabel.bottom()+UIScreenSize.HEIGHTMAKE(15), width: self.containerView.width()-UIScreenSize.WIDTHMAKE(26), height: UIScreenSize.HEIGHTMAKE(3))
        self.currentLine.frame = CGRect(x: UIScreenSize.WIDTHMAKE(13), y: self.fullLine.positionY(), width: self.fullLine.width()*self.progress, height: UIScreenSize.HEIGHTMAKE(3))
        self.dataView?.frame = CGRect(x: 0, y: self.fullLine.bottom()+UIScreenSize.HEIGHTMAKE(15), width: self.containerView.width(), height: UIScreenSize.HEIGHTMAKE(26))
        
    }
    
    func createBottomUI() -> UIView {
        let view: UIView = UIView()
        
        let labelWidth: CGFloat = (UIScreenSize.WIDTHMAKE(300)-2)/3.0
        let labelHeight: CGFloat = UIScreenSize.HEIGHTMAKE(13)
        
        self.supportLabel.frame = CGRect(x: 0, y: 0, width: labelWidth, height: labelHeight)
        self.supportLabel.font = UIFont.systemFontOfSize(UIScreenSize.HEIGHTMAKE(12))
        self.supportLabel.textAlignment = .Center
        self.supportLabel.textColor = UIColor.blackColor()
        view.addSubview(self.supportLabel)
        let supportL = UILabel(frame: CGRect(x: 0, y: self.supportLabel.bottom(), width: labelWidth, height: labelHeight))
        supportL.font = UIFont.systemFontOfSize(UIScreenSize.HEIGHTMAKE(12))
        supportL.textAlignment = .Center
        supportL.textColor = UIColor.lightGrayFontColor()
        supportL.text = "支持人数"
        view.addSubview(supportL)
        let line1 = UIView(frame: CGRect(x: supportL.right(), y: 0, width: 1, height: 2*labelHeight))
        line1.backgroundColor = UIColor.lineColor()
        view.addSubview(line1)
        
        self.progressLabel.frame = CGRect(x: line1.right(), y: 0, width: labelWidth, height: labelHeight)
        self.progressLabel.font = UIFont.systemFontOfSize(UIScreenSize.HEIGHTMAKE(12))
        self.progressLabel.textAlignment = .Center
        self.progressLabel.textColor = UIColor.blackColor()
        view.addSubview(self.progressLabel)
        let progressL = UILabel(frame: CGRect(x: self.progressLabel.positionX(), y: self.progressLabel.bottom(), width: labelWidth, height: labelHeight))
        progressL.font = UIFont.systemFontOfSize(UIScreenSize.HEIGHTMAKE(12))
        progressL.textAlignment = .Center
        progressL.textColor = UIColor.lightGrayFontColor()
        progressL.text = "众筹进度"
        view.addSubview(progressL)
        let line2 = UIView(frame: CGRect(x: progressL.right(), y: 0, width: 1, height: 2*labelHeight))
        line2.backgroundColor = UIColor.lineColor()
        view.addSubview(line2)
        
        self.moneyLabel.frame = CGRect(x: line2.right(), y: 0, width: labelWidth, height: labelHeight)
        self.moneyLabel.font = UIFont.systemFontOfSize(UIScreenSize.HEIGHTMAKE(12))
        self.moneyLabel.textAlignment = .Center
        self.moneyLabel.textColor = UIColor.blackColor()
        view.addSubview(self.moneyLabel)
        let moneyL = UILabel(frame: CGRect(x: self.moneyLabel.positionX(), y: self.moneyLabel.bottom(), width: labelWidth, height: labelHeight))
        moneyL.font = UIFont.systemFontOfSize(UIScreenSize.HEIGHTMAKE(12))
        moneyL.textAlignment = .Center
        moneyL.textColor = UIColor.lightGrayFontColor()
        moneyL.text = "募集金额"
        view.addSubview(moneyL)
        
        return view
    }
    
    func cellDisplayData(model: RJThirdZCModel) {
        self.backImageView.image = UIImage(named: model.imageName)
        self.statusLabel.text = model.status
        self.detailLabel.text = model.detail
        self.progress = model.progress
        self.currentLine.setWidth(self.fullLine.width()*self.progress)
        self.supportLabel.text = String(format: "%d人", model.people)
        self.progressLabel.text = String(format: "%.2f%%", Float(model.progress))
        self.moneyLabel.text = String(format: "%.2f元", Float(model.monry))
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
