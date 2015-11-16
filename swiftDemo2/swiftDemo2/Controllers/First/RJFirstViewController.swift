//
//  RJFirstViewController.swift
//  swiftDemo2
//
//  Created by 辉贾 on 15/11/7.
//  Copyright © 2015年 RJ. All rights reserved.
//

import UIKit

let leftBarButtonTag: Int       = 10001
let rightBarButtonTag: Int      = 10002
let loanScrollViewTag: Int      = 10003
let topCollectionTag: Int       = 10004
let bottomCollectionTag: Int    = 10005
let topPageControlTag: Int      = 10006
let bottomPageControlTag: Int      = 10007

class RJFirstViewController: RJBaseViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    private var topCollectionView:UICollectionView?
    private var bottomCollectionView:UICollectionView?
    private var loanScroller: UIView?
    private var topPageControl: UIPageControl?
    private var scrollPageControl: UIPageControl?
    var num: Int = 0
    
    
    private var bannerArray = NSMutableArray()
    private var productArr = NSMutableArray()
    private var CMProduct = NSMutableArray()
    private var textDict: NSDictionary?
//    private var longPressGesture: UILongPressGestureRecognizer!

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.tabBarController?.tabBar.hidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        self.title = "首页"
        
        self.HUDDefaultShow("正在加载数据，请稍等~", hiden: false)
        self.createNavigationBarItem()
        self.getNetData()
    }
    
    func createNavigationBarItem() {
        self.createLeftNavigationBarItem("RJSetting.png", size: CGSize(width: UIScreenSize.WIDTHMAKE(34), height: UIScreenSize.WIDTHMAKE(34)), selector: Selector("navigationBarButtonClickAction:"), tag: leftBarButtonTag)
        self.createRightNavigationBarItem("RJScan.png", size: CGSize(width: UIScreenSize.WIDTHMAKE(34), height: UIScreenSize.WIDTHMAKE(34)), selector: Selector("navigationBarButtonClickAction:"), tag: rightBarButtonTag)
    }
    
    // navigationBarButton的Action
    func navigationBarButtonClickAction(barButton: UIButton) {
        if barButton.tag == leftBarButtonTag {
            self.HUDTextShow("左侧", hiden: true)
        } else {
            self.HUDTextShow("右侧", hiden: true)
        }
    }
    
    func getNetData() {
        RequestAPI.CMGET("Api/MobileProject/HotBanners", parameters: nil, succeed: BannerSucceed, failure: faild)
        
        RequestAPI.CMGET("Api/MobileProject/Recommand/100", parameters: nil, succeed: CMProductSucceed, failure: faild)
        
        RequestAPI.HOPOST("Api/Customer/MoneyAndTime_Men", parameters: NSDictionary(), succeed: HOTextSucceed, failure: faild)
        
        RequestAPI.HOGET("Api/Customer/GetMoneyCenter", parameters: nil, succeed: HOProductSucceed, failure: faild)
    }
    // 轮播图片请求
    func BannerSucceed(task: NSURLSessionDataTask!, responseObject: AnyObject!) -> Void {
        let array = responseObject.objectForKey("projects") as! Array<NSDictionary>
        for dict: NSDictionary in array {
            self.bannerArray.addObject(String(dict.objectForKey("Url")!))
        }
        self.num += 1
        self.reloadUI()
        
    }
    // 众筹请求
    func CMProductSucceed(task: NSURLSessionDataTask!, responseObject: AnyObject!) -> Void {
        let dataArr = responseObject.objectForKey("data")! as! Array<NSDictionary>
        for dict: NSDictionary in dataArr {
            let allkeys = dict.allKeys as! Array<String>
            let product = RJCMProductModel()
            for key: String in allkeys {
                product.setValue(String(dict.objectForKey(key)!), forKey: key)
            }
            self.CMProduct.addObject(product)
        }
        self.num += 1
        self.reloadUI()
        
    }
    // 余盆数据请求
    func HOTextSucceed(task: NSURLSessionDataTask!, responseObject: AnyObject!) -> Void {
        self.textDict = responseObject.objectForKey("ReturnMessage") as? NSDictionary
        self.num += 1
        self.reloadUI()
    }
    // 余盆产品请求
    func HOProductSucceed(task: NSURLSessionDataTask!, responseObject: AnyObject!) -> Void {
        let status = responseObject.objectForKey("ReturnStatus")! as! NSString
        let baseUrl = "https://api.yupen.cn/"
        if status.isEqualToString("0") {
            let products = responseObject.objectForKey("ReturnMessage")! as! Array<NSDictionary>
            for dict: NSDictionary in products {
                let imgurl = dict.objectForKey("imgurl")! as! String
                let allUrl = baseUrl+imgurl
                self.productArr.addObject(allUrl)
            }
        }
        self.num += 1
        self.reloadUI()
    }
    
    func reloadUI() {
        if self.num == 4 {
            self.HUD!.hide(true)
            let loan: LoanScrollView = LoanScrollView()
            self.loanScroller = loan.createLoanScroller(self.bannerArray)
            loan.loanScrollView?.delegate = self
            loan.loanScrollView?.tag = loanScrollViewTag
            self.scrollPageControl = loan.pageControl!
            self.loanScroller!.setPositionY(self.navigationController!.navigationBar.height()+20)
            self.view.addSubview(self.loanScroller!)
            self.createIntroduceLabel(self.textDict!)
            self.topCollectionView?.reloadData()
            self.bottomCollectionView?.reloadData()
        }
    }
    
    func faild(task: NSURLSessionDataTask?, error: NSError) -> Void {
        print(error)
    }
    
    /**介绍数据的Label
     - parameter data: 数据
     */
    func createIntroduceLabel(data: NSDictionary) {
        let label = UILabel(frame: CGRect(x: 0, y: self.loanScroller!.bottom(), width: self.view.width(), height: UIScreenSize.HEIGHTMAKE(24)))
        label.textColor = UIColor.blackColor()
        label.font = UIFont.systemFontOfSize(UIScreenSize.WIDTHMAKE(10.0))
        label.textAlignment = .Center
        self.view.addSubview(label)
        
        let Money = String(data.objectForKey("InvestmentMoney")!) as NSString
        let StartTime = String(data.objectForKey("InvestmentStartTime")!) as NSString
        let Users = String(data.objectForKey("Users")!) as NSString
        let testShow = "立即成交"+String(Money)+"万元 运营时间"+String(StartTime)+"天 注册用户"+String(Users)+"万人"
        let attribute = NSMutableAttributedString(string: testShow)
        attribute.addAttribute(NSForegroundColorAttributeName, value: UIColor.redColor(), range: NSMakeRange(4, Money.length))
        attribute.addAttribute(NSForegroundColorAttributeName, value: UIColor.redColor(), range: NSMakeRange(11+Money.length, StartTime.length))
        attribute.addAttribute(NSForegroundColorAttributeName, value: UIColor.redColor(), range: NSMakeRange(attribute.length-2-Users.length, Users.length))
        label.attributedText = attribute
        
        let line = UIView(frame: CGRect(x: 0, y: label.bottom(), width: UIScreenSize.WIDTH(), height: 1.0))
        line.backgroundColor = UIColor.lightGrayColor()
        self.view.addSubview(line)
        
        self.makeCollectionView(topCollectionTag, positionY: line.bottom(), height: UIScreenSize.HEIGHTMAKE(133))
        self.makeCollectionView(bottomCollectionTag, positionY: self.topCollectionView!.bottom()+UIScreenSize.HEIGHTMAKE(10), height: UIScreenSize.HEIGHTMAKE(156))
    }
    
    func makeCollectionView(tag: Int,positionY: CGFloat, height: CGFloat) {
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: self.view.width(), height: height)
        flowLayout.scrollDirection = .Horizontal// 设置垂直显示
        
        let collection = UICollectionView(frame: CGRectMake(0, positionY, self.view.width(), height), collectionViewLayout: flowLayout)
        collection.tag = tag
        collection.backgroundColor = UIColor.whiteColor()
        collection.alwaysBounceHorizontal = true
        collection.delegate = self
        collection.dataSource = self
        collection.pagingEnabled = true
        collection.showsHorizontalScrollIndicator = false
        self.view.addSubview(collection)
        if tag == topCollectionTag {
            self.topCollectionView = collection
            self.topCollectionView!.registerClass(RJFirstCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
            
            self.topPageControl = UIPageControl(frame: CGRect(x: 0, y: UIScreenSize.HEIGHTMAKE(110)+positionY, width: UIScreenSize.WIDTH(), height: 20))
            self.topPageControl!.pageIndicatorTintColor = UIColor.lightGrayColor()
            self.topPageControl!.currentPageIndicatorTintColor = UIColor.redColor()
            self.view.addSubview(self.topPageControl!)
            
            let line = UIView(frame: CGRect(x: 0, y: self.topCollectionView!.bottom(), width: self.view.width(), height: 1))
            line.backgroundColor = UIColor.lightGrayColor()
            self.view.addSubview(line)
        } else if tag == bottomCollectionTag {
            self.bottomCollectionView = collection
            self.bottomCollectionView!.registerClass(RJFirstBottomCollectionViewCell.self, forCellWithReuseIdentifier: "cellbottom")
        }
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if collectionView.tag == topCollectionTag {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! RJFirstCollectionViewCell
            cell.imageView?.sd_setImageWithURL(NSURL(string: self.productArr.objectAtIndex(indexPath.row) as! String))
            return cell
        } else if collectionView.tag == bottomCollectionTag {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cellbottom", forIndexPath: indexPath) as! RJFirstBottomCollectionViewCell
            let product: RJCMProductModel = self.CMProduct.objectAtIndex(indexPath.row) as! RJCMProductModel
            cell.displayDataWithCell(product)
            return cell
        }
        return UICollectionViewCell()
    }
        //返回cell 上下左右的间距
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets{
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == topCollectionTag {
            self.topPageControl!.numberOfPages = self.productArr.count
            return self.productArr.count
        }
        return self.CMProduct.count
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView.tag == topCollectionTag {
            let currentPage = Int(scrollView.contentOffset.x/self.view.width()+0.5)
            self.topPageControl!.currentPage = currentPage
        } else if scrollView.tag == loanScrollViewTag {
            let currentPage = Int(scrollView.contentOffset.x/self.view.width()+0.5)
            self.scrollPageControl?.currentPage = currentPage
        }
    }
    
}

class LoanScrollView: NSObject, UIScrollViewDelegate {
    
    var loanScrollView: UIScrollView?
    var pageControl: UIPageControl?
    
    func createLoanScroller(imageArr: NSArray) -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreenSize.WIDTH(), height: UIScreenSize.HEIGHTMAKE(150)))
        
        self.loanScrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: UIScreenSize.WIDTH(), height: UIScreenSize.HEIGHTMAKE(150)))
        self.loanScrollView!.contentSize = CGSizeMake(self.loanScrollView!.width()*3, self.loanScrollView!.height())
        self.loanScrollView!.showsVerticalScrollIndicator = false
        self.loanScrollView!.showsHorizontalScrollIndicator = false
        self.loanScrollView!.backgroundColor = UIColor.clearColor()
        self.loanScrollView!.pagingEnabled = true
        self.loanScrollView!.delegate = self
        view.addSubview(self.loanScrollView!)
        for i in 0...imageArr.count-1 {
            let imageView = UIImageView(frame: CGRect(x: CGFloat(i) * view.width(), y: 0, width: view.width(), height: UIScreenSize.HEIGHTMAKE(150)))
            let string = imageArr.objectAtIndex(i) as! String
            imageView.sd_setImageWithURL(NSURL(string: string))
            imageView.tag = 100+i
            imageView.backgroundColor = UIColor.yellowColor()
            self.loanScrollView!.addSubview(imageView)
        }
        
        self.pageControl = UIPageControl(frame: CGRect(x: 0, y: UIScreenSize.HEIGHTMAKE(130), width: UIScreenSize.WIDTH(), height: UIScreenSize.HEIGHTMAKE(20)))
        self.pageControl!.numberOfPages = imageArr.count
        self.pageControl!.pageIndicatorTintColor = UIColor.lightGrayColor()
        self.pageControl!.currentPageIndicatorTintColor = UIColor.redColor()
        view.addSubview(self.pageControl!)
        
        return view
    }
}

/*
func conigSubviews() {
let flowLayout = UICollectionViewFlowLayout()
flowLayout.itemSize = CGSize(width: (self.view.width()-30)/2, height: 210)
flowLayout.scrollDirection = .Vertical// 设置垂直显示
flowLayout.sectionInset = UIEdgeInsetsMake(0, 1, 0, 1)// 设置边距
flowLayout.headerReferenceSize = CGSizeMake(0, 0)

self.collectionView = UICollectionView(frame: CGRectMake(0, 0, self.view.width(), self.view.height()-self.navigationController!.navigationBar.height()-20), collectionViewLayout: flowLayout)
self.collectionView!.backgroundColor = UIColor.whiteColor()
self.collectionView!.alwaysBounceVertical = true
self.collectionView!.delegate = self
self.collectionView!.dataSource = self
self.view.addSubview(self.collectionView!)
self.collectionView!.registerClass(RJFirstCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
self.collectionView!.registerClass(RJFirestCollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headerView")

longPressGesture = UILongPressGestureRecognizer(target: self, action: "handleLongGesture:")
self.collectionView!.addGestureRecognizer(longPressGesture)
}
*/

/*
//调整数据源数据的顺序
func collectionView(collectionView: UICollectionView, moveItemAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {

let str = self.dataArr.objectAtIndex(sourceIndexPath.row)
self.dataArr.replaceObjectAtIndex(sourceIndexPath.row, withObject: self.dataArr.objectAtIndex(destinationIndexPath.row))
self.dataArr.replaceObjectAtIndex(destinationIndexPath.row, withObject: str)

}
*/
/*
func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
return CGSize(width: self.view.width(), height: 50)
}

//返回自定义HeadView或者FootView，我这里以headview为例
func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView{
var headerView = RJFirestCollectionHeaderView()
if kind == UICollectionElementKindSectionHeader{
headerView = self.collectionView!.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "headerView", forIndexPath: indexPath) as! RJFirestCollectionHeaderView
}
headerView.backgroundColor = UIColor.cyanColor()
return headerView
}

// 长按手势，实现拖拽
func handleLongGesture(gesture: UILongPressGestureRecognizer) {

switch(gesture.state) {

case UIGestureRecognizerState.Began:
guard let selectedIndexPath = self.collectionView!.indexPathForItemAtPoint(gesture.locationInView(self.collectionView!)) else {
break
}
self.collectionView!.beginInteractiveMovementForItemAtIndexPath(selectedIndexPath)
case UIGestureRecognizerState.Changed:
self.collectionView!.updateInteractiveMovementTargetPosition(gesture.locationInView(gesture.view!))
case UIGestureRecognizerState.Ended:
self.collectionView!.endInteractiveMovement()
default:
self.collectionView!.cancelInteractiveMovement()
}
}
*/
