//
//  RJSecondViewController.swift
//  swiftDemo2
//
//  Created by 辉贾 on 15/11/7.
//  Copyright © 2015年 RJ. All rights reserved.
//

import UIKit

class RJSecondViewController: RJBaseViewController {

    var tableView: UITableView?
    var dataArray = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.title = "财富中心"
        self.HUDDefaultShow("正在加载数据，请稍等~", hiden: false)
        self.getData()
    }
    
    func getData() {
        RequestAPI.HOGET("Api/Customer/GetMoneyCenter", parameters: nil, succeed: HOProductSucceed, failure: faild)
    }
    
    // 余盆产品请求
    func HOProductSucceed(task: NSURLSessionDataTask!, responseObject: AnyObject!) -> Void {
        self.HUD?.hide(true)
        print(responseObject)
        
        self.configTableView()
    }
    func faild(task: NSURLSessionDataTask?, error: NSError) -> Void {
        self.HUDTextShow("请求发生错误", hiden: true)
    }
    func configTableView() {
        self.tableView = UITableView(frame: CGRect(x: 0, y: self.navigationController!.navigationBar.height()+20, width: self.view.width(), height: self.view.height()-self.navigationController!.navigationBar.height()-20), style: .Plain)
        self.view.addSubview(self.tableView!)
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView!.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UIScreenSize.HEIGHTMAKE(112)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier :String = "cellName"
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier)
        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: identifier)
        }
        
        return cell!;
    }
    

}
