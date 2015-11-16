//
//  RJSecondDetailController.swift
//  swiftDemo2
//
//  Created by 辉贾 on 15/11/13.
//  Copyright © 2015年 RJ. All rights reserved.
//

import UIKit

class RJSecondDetailController: RJBaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.automaticallyAdjustsScrollViewInsets = false
        self.title = "财富中心"
        self.HUDDefaultShow("正在加载数据，请稍等~", hiden: false)
    }
}
