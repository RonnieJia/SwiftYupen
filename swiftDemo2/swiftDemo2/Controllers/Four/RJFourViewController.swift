//
//  RJFourViewController.swift
//  swiftDemo2
//
//  Created by 辉贾 on 15/11/7.
//  Copyright © 2015年 RJ. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class RJFourViewController: RJBaseViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    var locationManager: CLLocationManager?
    var mpView: MKMapView?
    var geocoder: CLGeocoder?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.title = "我的财富"
        // Do any additional setup after loading the view.
        
        self.HUDDefaultShow("正在定位您的当前位置", hiden: false)
        
        self.locationManager = CLLocationManager()
        self.geocoder = CLGeocoder()
        
        if !CLLocationManager.locationServicesEnabled() {
            self.HUD?.hidden = true
            self.HUDTextShow("定位服务尚未开启，请设置打开", hiden: true)
            return
        }
        // 如果没有授权请求用户授权
        if CLLocationManager.authorizationStatus() == CLAuthorizationStatus.NotDetermined {
            self.locationManager!.requestWhenInUseAuthorization()
            self.locationManagerUpdatingLocation()
        } else if CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedWhenInUse {
            self.locationManagerUpdatingLocation()
        }
        
    }
    
    func locationManagerUpdatingLocation() {
        self.locationManager!.delegate = self
        // 设置定位精度
        self.locationManager!.desiredAccuracy = kCLLocationAccuracyBest
        //定位平率
        let distance: CLLocationDistance = 10.0
        self.locationManager!.distanceFilter = distance
        // 启动定位
        self.locationManager!.startUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location:CLLocation = locations[0] as CLLocation// 取出第一个位置
        self.getAddressByLocation(location)
//        let coordinate: CLLocationCoordinate2D = location.coordinate
//        self.HUDTextShow(String(format: "经度：%f, 纬度：%f, 海拔：%f, 航向：%f, 速度：%f", coordinate.longitude, coordinate.latitude, location.altitude, location.course, location.speed), hiden: false)
        self.locationManager!.stopUpdatingLocation()
    }
    
    func getAddressByLocation(location: CLLocation) {
        var p:CLPlacemark?
        self.geocoder!.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
            self.HUD?.hidden = true
            if error != nil {
                self.HUDTextShow("reverse geodcode fail", hiden: true)
                print("reverse geodcode fail: \(error!.localizedDescription)")
                return
            }
            let pm = placemarks! as [CLPlacemark]
            if (pm.count > 0){
                p = placemarks![0] as CLPlacemark
                let dict: NSDictionary = ((p?.addressDictionary)! as NSDictionary)
                let str: String = String(dict.objectForKey("Country")!) + String(dict.objectForKey("State")!) + String(dict.objectForKey("SubLocality")!) + String(dict.objectForKey("Street")!)
                self.HUDTextShow(str, hiden: false)
            }else{
                self.HUDTextShow("定位失败", hiden: true)
            }
        })
    }
    
    func geocodeAddressString(address: String) {
        
    }
    

}
