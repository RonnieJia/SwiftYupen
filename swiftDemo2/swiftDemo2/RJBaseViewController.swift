//
//  RJBaseViewController.swift
//  swiftDemo2
//
//  Created by 辉贾 on 15/11/7.
//  Copyright © 2015年 RJ. All rights reserved.
//

import UIKit

class RJBaseViewController: UIViewController {

    var HUD: MBProgressHUD?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /** HUDDefaultShow
     */
    func HUDDefaultShow(title: String, hiden: Bool) {
        let MBHUD: MBProgressHUD = MBProgressHUD(view: self.view)
        MBHUD.labelText = title
        MBHUD.show(true)
        self.view.addSubview(MBHUD)
        self.HUD = MBHUD
        if hiden {
            self.HUD?.hide(true, afterDelay: 0.8)
        }
    }
    
    /** HUDTextShow
     :param: title    need show text
     */
    func HUDTextShow(title: String, hiden: Bool) {
        let MBHUD: MBProgressHUD = MBProgressHUD(view: self.view)
        MBHUD.mode = .Text
        MBHUD.labelText = title
        MBHUD.show(true)
        self.view.addSubview(MBHUD)
        self.HUD = MBHUD
        if hiden {
            self.HUD?.hide(true, afterDelay: 0.8)
        }
    }
    
    /** HUDCustomViewShow
     :param: customView     youself create customView to show
     */
    func HUDCustomViewShow(customView: UIView, hiden: Bool) {
        let MBHUD: MBProgressHUD = MBProgressHUD(view: self.view)
        MBHUD.mode = .CustomView
        MBHUD.customView = customView
        MBHUD.show(true)
        self.view.addSubview(MBHUD)
        self.HUD = MBHUD
        if hiden {
            self.HUD?.hide(true, afterDelay: 0.8)
        }
    }
    
    /** HUDDeterminateHorizontalBarShow
     :param: progress          show progress with bar
     */
    func HUDDeterminateHorizontalBarShow(progress: Float, hiden: Bool) {
        let MBHUD: MBProgressHUD = MBProgressHUD(view: self.view)
        MBHUD.mode = .DeterminateHorizontalBar
        MBHUD.progress = progress
        MBHUD.show(true)
        self.view.addSubview(MBHUD)
        self.HUD = MBHUD
        if hiden {
            self.HUD?.hide(true, afterDelay: 0.8)
        }
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
