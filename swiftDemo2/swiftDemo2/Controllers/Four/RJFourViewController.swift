//
//  RJFourViewController.swift
//  swiftDemo2
//
//  Created by 辉贾 on 15/11/7.
//  Copyright © 2015年 RJ. All rights reserved.
//

import UIKit
import CoreLocation

class RJFourViewController: RJBaseViewController, CLLocationManagerDelegate {

    var locationManager: CLLocationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.title = "我的财富"
        // Do any additional setup after loading the view.
        
        if !CLLocationManager.locationServicesEnabled() {
            self.HUDTextShow("定位服务尚未开启，请设置打开", hiden: true)
            return
        }
        
         if CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedWhenInUse {
            self.locationManager.delegate = self
            // 设置定位精度
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
            //定位平率
            let distance: CLLocationDistance = 10.0
            self.locationManager.distanceFilter = distance
            // 启动定位
            self.locationManager.startUpdatingLocation()
        }
        
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location:CLLocation = locations[0] as CLLocation// 取出第一个位置
        
        let coordinate: CLLocationCoordinate2D = location.coordinate
        
        self.HUDTextShow(String(format: "经度：%f, 纬度：%f, 海拔：%f, 航向：%f, 速度：%f", coordinate.longitude, coordinate.latitude, location.altitude, location.course, location.speed), hiden: true)
        
        self.locationManager.stopUpdatingLocation()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
