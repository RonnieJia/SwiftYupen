//
//  RJThirdViewController.swift
//  swiftDemo2
//
//  Created by 辉贾 on 15/11/7.
//  Copyright © 2015年 RJ. All rights reserved.
//

import UIKit

let IndustryButtonTag:  Int = 10000
let TypeButtonTag:      Int = 10001
let StatesButtonTag:    Int = 10002
let leftBarTag:         Int = 10003
let rightBarTag:        Int = 10003

class RJThirdViewController: RJBaseViewController, UITableViewDelegate, UITableViewDataSource {

    var selectButton: UIButton?
    var chooseTableView: UITableView?
    var tableView: UITableView?
    var frontRow: Int = -1
    var dataArray: NSMutableArray = NSMutableArray()
    var flag: Int = 0
    
    func makeGenuineData() {
        let details: NSArray = ["这是烟台大学的标志性建筑--钟楼", "这是位于三元湖的一个雕塑", "这是烟台大学的一条林间小道", "这是烟台大学的一片小草地", "这是烟台大学景色优美的三元湖", "烟台大学东门，面朝大海，春暖花开。", "这是位于烟台大学西门的一个石头"]
        for i: Int in 0...6 {
            let model = RJThirdZCModel()
            model.imageName = String(i)+".png"
            model.status = "众筹中"
            model.detail = details.objectAtIndex(i) as! String
            
            model.progress = CGFloat(random()%100)/100.0
            model.people = random()%500+12
            model.monry = CGFloat(random()%10000)+1000
            self.dataArray.addObject(model)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.automaticallyAdjustsScrollViewInsets = false
        self.title = "众筹"
        self.makeGenuineData()
        self.configSubViews()
    }
    
    func configSubViews() {
        self.createLeftNavigationBarItem("RJRedHeart.png", size: CGSize(width: UIScreenSize.WIDTHMAKE(24), height: UIScreenSize.WIDTHMAKE(24)), selector: Selector("barButtonClickAction:"), tag: leftBarTag)
        self.createRightNavigationBarItem("RJPrint.png", size: CGSize(width: UIScreenSize.WIDTHMAKE(24), height: UIScreenSize.WIDTHMAKE(24)), selector: Selector("barButtonClickAction:"), tag: rightBarTag)
        
        self.tableView = UITableView(frame: CGRect(x: 0, y: self.navigationController!.navigationBar.height()+20+UIScreenSize.HEIGHTMAKE(30), width: self.view.width(), height: self.view.height()-self.navigationController!.navigationBar.height()-20-UIScreenSize.HEIGHTMAKE(30)-(self.tabBarController?.tabBar.height())!))
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.tableFooterView = UIView()
        self.tableView?.showsVerticalScrollIndicator = false
        self.tableView?.separatorStyle = .None
        self.tableView?.addHeaderWithTarget(self, action: Selector("tableViewHeaderRefresh"))
        self.tableView?.addFooterWithTarget(self, action: Selector("tableViewFooterRefresh"))
        self.view.addSubview(self.tableView!)
        
        self.configChooseButton()
    }
    
    func barButtonClickAction(button: UIButton) {
        if button.tag == leftBarTag {
            self.navigationController?.pushViewController(RJAttentionViewController(), animated: true)
        } else {
            self.navigationController?.pushViewController(RJBuyListViewController(), animated: true)
        }
    }
    
    func tableViewHeaderRefresh() {
        self.frontRow = -1
        self.dataArray.removeAllObjects()
        self.makeGenuineData()
        self.flag = 1
        self.performSelector(Selector("delay"), withObject: nil, afterDelay: 0.8)
    }
    
    func tableViewFooterRefresh() {
        self.flag = 2
        self.performSelector(Selector("delay"), withObject: nil, afterDelay: 0.8)
    }
    
    func delay() {
        if flag == 1 {
            self.tableView?.headerEndRefreshing()
            self.tableView?.reloadData()
        } else {
            self.tableView?.footerEndRefreshing()
            self.HUDTextShow("已加载所有数据，亲~", hiden: true)
        }
    }

    func configChooseButton() {
        let lineImageView = UIImageView(frame: CGRectMake(0, self.navigationController!.navigationBar.height()+20, self.view.width(), UIScreenSize.HEIGHTMAKE(30)))
        lineImageView.image = UIImage(named: "RJThirdLine.jpg")
        self.view.addSubview(lineImageView)
        
        let titlesArray: Array<String> = ["全部行业", "全部筹类", "全部状态"]
        let tagArray: Array<Int> = [IndustryButtonTag ,TypeButtonTag, StatesButtonTag]
        for i: Int in 0...2 {
            let button: RJThridChooseButton = RJThridChooseButton(type: .Custom)
            button.frame = CGRectMake(CGFloat(i)*(self.view.width()/3.0), self.navigationController!.navigationBar.height()+20, self.view.width()/3.0, UIScreenSize.HEIGHTMAKE(30))
            button.setTitle(titlesArray[i], forState: .Normal)
            button.setTitleColor(UIColor.lightGrayFontColor(), forState: .Normal)
            button.setImage(UIImage(named: "RJChooseButtonDown.png"), forState: .Normal)
            button.setImage(UIImage(named: "RJChooseButtonUp.png"), forState: .Selected)
            button.tag = tagArray[i]
            button.addTarget(self, action: Selector("chooseButtonClickAction:"), forControlEvents: .TouchUpInside)
            self.view.addSubview(button)
        }
        
        self.chooseTableView = UITableView(frame: CGRectMake(0, 0, 0, 0))
        self.view.addSubview(self.chooseTableView!)
        self.chooseTableView!.delegate = self
        self.chooseTableView!.dataSource = self
        self.chooseTableView!.backgroundColor = UIColor.clearColor()
        self.chooseTableView!.tableFooterView = UIView()
        self.chooseTableView!.showsVerticalScrollIndicator = false
    }
    
    func chooseButtonClickAction(button: UIButton) {
        
        var x: CGFloat = 0.0
        switch button.tag {
        case IndustryButtonTag:
            self.HUDTextShow("行业选择", hiden: true)
            x = 0.0
            break
        case TypeButtonTag:
            self.HUDTextShow("筹类选择", hiden: true)
            x = self.view.width()/3.0
            break
        case StatesButtonTag:
            self.HUDTextShow("状态选择", hiden: true)
            x = self.view.width()/3.0*2.0
            break
        default:
            break
        }
        if button == self.selectButton {
            button.selected = !button.selected
            if button.selected {
                self.animationSetChooseTableHeight(200)
            } else {
                self.animationSetChooseTableHeight(0)
            }
        } else {
            self.selectButton?.selected = false
            button.selected = true
            self.chooseTableView?.frame = CGRectMake(x, self.navigationController!.navigationBar.height()+20+UIScreenSize.HEIGHTMAKE(30), self.view.width()/3.0, 0)
            self.animationSetChooseTableHeight(200)
        }
        self.selectButton = button
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.chooseTableView {
            return 10
        }
        return self.dataArray.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if tableView == self.chooseTableView {
            self.animationSetChooseTableHeight(0)
            self.selectButton?.selected = false
            self.selectButton?.setTitle(String(indexPath.row), forState: .Normal)
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if tableView == self.tableView {
            return UIScreenSize.HEIGHTMAKE(259)
        }
        return UIScreenSize.HEIGHTMAKE(25)
            
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if tableView == self.chooseTableView {
            var cell = tableView.dequeueReusableCellWithIdentifier("cell")
            if cell == nil {
                cell = UITableViewCell(style: .Default, reuseIdentifier: "cell")
                cell!.backgroundColor = UIColor.yellowColor()
            }
            cell!.textLabel?.text = String(indexPath.row)
            return cell!
        }
        let cell = RJThirdTableViewCell.dequCell(tableView)
        let model:RJThirdZCModel = self.dataArray.objectAtIndex(indexPath.row) as! RJThirdZCModel
        cell.cellDisplayData(model)
        
        return cell
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if tableView == self.tableView {
            if self.frontRow < indexPath.row {
                self.frontRow = indexPath.row;
                let animation: CABasicAnimation = CABasicAnimation(keyPath: "transform.scale")
                cell.layer.anchorPoint = CGPointMake(0.5, 0.5)
                animation.fromValue = 0.5
                animation.toValue = 1.0
                animation.duration = 0.4
                cell.layer.addAnimation(animation, forKey: "scale")
            } else {
                self.frontRow = indexPath.row;
            }
        } else {
            if cell.respondsToSelector("setSeparatorInset:") {
                cell.separatorInset = UIEdgeInsetsZero
            }
            if cell.respondsToSelector("setLayoutMargins:") {
                cell.layoutMargins = UIEdgeInsetsZero
            }
        }
    }
    
    func animationSetChooseTableHeight(height: CGFloat) {
        UIView.animateWithDuration(0.4, animations: { () -> Void in
            self.chooseTableView?.setHeight(height)
        })
    }

}
