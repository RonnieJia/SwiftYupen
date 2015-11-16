//
//  RJSecondViewController.swift
//  swiftDemo2
//
//  Created by 辉贾 on 15/11/7.
//  Copyright © 2015年 RJ. All rights reserved.
//

import UIKit

class RJSecondViewController: RJBaseViewController, UITableViewDelegate, UITableViewDataSource {

    var tableView: UITableView?
    var dataArray = NSMutableArray()
    var isRefreshing: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.automaticallyAdjustsScrollViewInsets = false
        self.title = "财富中心"
        self.configTableView()
        self.getData()
        self.HUDDefaultShow("正在加载数据，请稍等~", hiden: false)
    }
    
    func getData() {
        RequestAPI.HOGET("Api/Customer/GetMoneyCenter", parameters: nil, succeed: HOProductSucceed, failure: faild)
    }
    
    // 余盆产品请求
    func HOProductSucceed(task: NSURLSessionDataTask!, responseObject: AnyObject!) -> Void {
        self.HUD?.hide(true)
        self.isRefreshing = false
        if String(responseObject.objectForKey("ReturnStatus")!) == "0" {
            let messageArr = responseObject.objectForKey("ReturnMessage")! as! Array<NSDictionary>
            for dict: NSDictionary in messageArr {
                let product: RJProjectModel = RJProjectModel.createProduct(dict)
                self.dataArray.addObject(product)
            }
            self.tableView?.reloadData()
            self.tableView?.headerEndRefreshing()
            self.tableView?.footerEndRefreshing()
        } else {
            self.HUDTextShow("请求发生错误", hiden: true)
        }
    }
    
    func faild(task: NSURLSessionDataTask?, error: NSError) -> Void {
        self.HUD?.hide(true)
        self.isRefreshing = false
        self.HUDTextShow("请求发生错误", hiden: true)
    }
    func configTableView() {
        self.tableView = UITableView(frame: CGRect(x: 0, y: self.navigationController!.navigationBar.height()+20, width: self.view.width(), height: self.view.height()-self.navigationController!.navigationBar.height()-21-self.tabBarController!.tabBar.height()), style: .Plain)
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        self.tableView?.tableFooterView = UIView()
        self.tableView?.addHeaderWithTarget(self, action: Selector("tableViewHeaderRefresh"))
        self.tableView?.addFooterWithTarget(self, action: Selector("tableViewFooterRefresh"))
        self.view.addSubview(self.tableView!)
    }
    
    func tableViewHeaderRefresh() {
        self.isRefreshing = true
        self.dataArray.removeAllObjects()
        self.getData()
    }
    func tableViewFooterRefresh() {
        self.performSelector(Selector("perFormMethod"), withObject: nil, afterDelay: 0.8)
    }
    func perFormMethod() {
        self.tableView?.footerEndRefreshing()
        self.HUDTextShow("已加载所有数据，亲~", hiden: true)
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
        let cell: RJHOProductTableViewCell = RJHOProductTableViewCell.dequCell(tableView)
        let product: RJProjectModel = self.dataArray.objectAtIndex(indexPath.row) as! RJProjectModel
       cell.cellDisplayData(product)
        
        return cell
    }
    

}
