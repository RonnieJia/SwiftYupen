//
//  RequestClient.swift
//  swiftDemo2
//
//  Created by 辉贾 on 15/11/8.
//  Copyright © 2015年 RJ. All rights reserved.
//

import UIKit

class CMRequestClient: AFHTTPSessionManager {
    
    class var sharedInstance: CMRequestClient {
        
        struct Staic {
            static var onceToken: dispatch_once_t = 0
            static var instance: CMRequestClient? = nil
        }
        
        dispatch_once(&Staic.onceToken, {() -> Void in
            let url: NSURL = NSURL(string: "https://zcapi.yupen.cn/")!
            Staic.instance = CMRequestClient(baseURL:url)
        
        })
        
        return Staic.instance!
        
    }
    
}
