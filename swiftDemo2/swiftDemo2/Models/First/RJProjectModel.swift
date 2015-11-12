//
//  RJProjectModel.swift
//  swiftDemo2
//
//  Created by 辉贾 on var 5/var var /8.
//  Copyright © 20var 5年 RJ. All rights reserved.
//

import Foundation

class RJProjectModel: NSObject {
    
    var AlreadyBuy: String = ""
    var DetailsInfo: String = ""
    var GeneralName: String = ""
    var IsDisable: String = ""
    var IsLotteryDraw: String = ""
    var IsRecommend: String = ""
    var IsRedPacket: String = ""
    var KeyId: String = ""
    var LoanType: String = ""
    var MinimumMoney: String = ""
    var MinimumTerm: String = ""
    var MoneyDescription: String = ""
    var MoneyName: String = ""
    var RateDescription: String = ""
    var Remarks: String = ""
    var RiskController: String = ""
    var SellType: String = ""
    var SellTypeM: String = ""
    var TopTwo: String = ""
    var TopoOne: String = ""
    var TrueRate: String = ""
    var haveing: String = ""
    var imgurl: String = ""
    var sum: String = ""
    
    class func createProduct(dict: NSDictionary) -> RJProjectModel {
        let product = RJProjectModel()
        for key: String in dict.allKeys as! Array<String> {
            product.setValue(String(dict.objectForKey(key)!), forKey: key)
        }
        return product
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
}
