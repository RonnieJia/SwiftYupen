//
//  RequestAPI.swift
//  swiftDemo2
//
//  Created by 辉贾 on 15/11/8.
//  Copyright © 2015年 RJ. All rights reserved.
//

import Foundation

typealias Succeed = (NSURLSessionDataTask!, AnyObject!) -> Void

typealias Failure = (NSURLSessionDataTask!, NSError) -> Void

class RequestAPI: NSObject {
    
    class func reachability() {
        AFNetworkReachabilityManager.sharedManager().startMonitoring()
        AFNetworkReachabilityManager.sharedManager().setReachabilityStatusChangeBlock { (status: AFNetworkReachabilityStatus) -> Void in
            switch (status) {
            case .Unknown:// 未知
                
                break;
                
            case .NotReachable:// 无网络连接
                
                break;
            case .ReachableViaWiFi:// WIFI
                break;
                
            case .ReachableViaWWAN:// 手机自带网络
                break;
            }
        }
    }
    
    class func CMGET(url:String!, parameters:AnyObject?, succeed: Succeed, failure:Failure) {
        let mysucceed: Succeed = succeed
        let myfailure: Failure = failure
        CMRequestClient.sharedInstance.responseSerializer.acceptableContentTypes = NSSet(objects: "application/json", "text/html", "text/json", "text/javascript","text/plain") as Set<NSObject>
        CMRequestClient.sharedInstance.GET(url, parameters: parameters, success: { (task: NSURLSessionDataTask!, responseObject: AnyObject!) -> Void in
            mysucceed(task, responseObject)
        }) { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                myfailure(task!, error)
        }
    }
    
    class func CMPOST(url:String!, parameters:AnyObject?, succeed: Succeed, failure:Failure) {
        let mysucceed: Succeed = succeed
        let myfailure: Failure = failure
        CMRequestClient.sharedInstance.responseSerializer.acceptableContentTypes = NSSet(objects: "application/json", "text/html", "text/json", "text/javascript","text/plain") as Set<NSObject>
        CMRequestClient.sharedInstance.POST(url, parameters: parameters, success: { (task: NSURLSessionDataTask!, responseObject: AnyObject!) -> Void in
            mysucceed(task, responseObject)
            }) { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                myfailure(task!, error)
        }
    }
    
    class func HOGET(url:String!, parameters:AnyObject?, succeed: Succeed, failure:Failure) {
        let mysucceed: Succeed = succeed
        let myfailure: Failure = failure
        HORequestClient.sharedInstance.responseSerializer.acceptableContentTypes = NSSet(objects: "application/json", "text/html", "text/json", "text/javascript","text/plain") as Set<NSObject>
        
        HORequestClient.sharedInstance.GET(url, parameters: parameters, success: { (task: NSURLSessionDataTask!, responseObject: AnyObject!) -> Void in
            mysucceed(task, responseObject)
            }) { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                myfailure(task!, error)
        }
    }
    
    class func HOPOST(url:String!, parameters:AnyObject?, succeed: Succeed, failure:Failure) {
        let mysucceed: Succeed = succeed
        let myfailure: Failure = failure
        HORequestClient.sharedInstance.responseSerializer.acceptableContentTypes = NSSet(objects: "application/json", "text/html", "text/json", "text/javascript","text/plain") as Set<NSObject>
        HORequestClient.sharedInstance.requestSerializer.setValue("IOS", forHTTPHeaderField: "X-Equipment")
        HORequestClient.sharedInstance.POST(url, parameters: parameters, success: { (task: NSURLSessionDataTask!, responseObject: AnyObject!) -> Void in
            mysucceed(task, responseObject)
            }) { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                myfailure(task!, error)
        }
    }
    
}

