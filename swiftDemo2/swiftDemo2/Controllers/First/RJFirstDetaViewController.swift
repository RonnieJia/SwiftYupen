//
//  RJFirstDetaViewController.swift
//  swiftDemo2
//
//  Created by 辉贾 on 15/11/7.
//  Copyright © 2015年 RJ. All rights reserved.
//

import UIKit

class RJFirstDetaViewController: RJBaseViewController, UITableViewDelegate, UITableViewDataSource {

    let httpURL: String = "api/MobileProject"
    var tableView: UITableView?
    var daraArray: Array<RJProjectModel>? = Array()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.yellowColor()
        self.title = "详情"
        self.automaticallyAdjustsScrollViewInsets = false
        
        let dict:Dictionary<String, String> = ["take":"10", "skip":"0"]
        RequestAPI.CMGET(httpURL, parameters: dict, succeed: succeed, failure: faild)
        self.HUDDefaultShow("正在加载数据，请稍候~", hiden: false)
        
    }
    
    func succeed(task: NSURLSessionDataTask!, responseObject: AnyObject!) -> Void {
        var dict = responseObject.objectForKey("data") as! Dictionary<String, AnyObject>
        let dict2 = dict["Result"] as! Array<Dictionary<String, AnyObject>>
        for object:Dictionary<String, AnyObject> in dict2 {
            let model: RJProjectModel = RJProjectModel()
            for key: String in object.keys {
                model.setValue(String(object[key]), forKey: key)
            }
            self.daraArray!.append(model)
        }
        self.HUD!.hide(true)
        self.conigSubviews()
    }
    
    func faild(task: NSURLSessionDataTask?, error: NSError) -> Void {
        print(error)
        self.HUD!.hide(true)
        self.HUDTextShow("网络出现错误", hiden:true)
    }
    
    func conigSubviews() {
        self.tableView = UITableView(frame: CGRect(x: 0, y: self.navigationController!.navigationBar.height()+20, width: self.view.width(), height: self.view.height()-self.navigationController!.navigationBar.height()-20), style: .Plain)
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.separatorStyle = .SingleLine
        self.view.addSubview(self.tableView!)
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.daraArray!.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView!.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50.0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier :String = "cellName"
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier)
        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: identifier)
        }
        let model = self.daraArray![indexPath.row]
        cell!.textLabel!.text = model.PAddress!
        
        return cell!;
    }
    
}
