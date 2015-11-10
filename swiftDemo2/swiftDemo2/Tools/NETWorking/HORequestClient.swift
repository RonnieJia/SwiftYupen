//
//  HORequestClient.swift
//  swiftDemo2
//
//  Created by jiapinghui on 15/11/9.
//  Copyright © 2015年 RJ. All rights reserved.
//

import UIKit

class HORequestClient: AFHTTPSessionManager {
    class var sharedInstance: HORequestClient {
        
        struct Staic {
            static var onceToken: dispatch_once_t = 0
            static var instance: HORequestClient? = nil
        }
        
        dispatch_once(&Staic.onceToken, {() -> Void in
            let url: NSURL = NSURL(string: "https://api.yupen.cn/")!
            Staic.instance = HORequestClient(baseURL:url)
            
        })
        
        return Staic.instance!
        
    }
}
