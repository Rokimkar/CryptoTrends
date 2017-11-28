//
//  CurrencyDetailViewController.swift
//  CryptoTrends
//
//  Created by S@nchit on 30/09/17.
//  Copyright © 2017 S@nchit. All rights reserved.
//

import UIKit
import GoogleMobileAds

class CurrencyDetailViewController: UIViewController {
    
    @IBOutlet weak var adView: UIView!
    @IBOutlet weak var firstLetterLabel: UILabel!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var currencyDetailLabel: UILabel!
    @IBOutlet weak var backGroundImageView: UIImageView!
    @IBOutlet weak var currencyImageView: UIImageView!
    @IBOutlet weak var cryptoCurrencyDetailTableView: UITableView!
    
    private let pullToRefereshControl = UIRefreshControl.init()
    var previousFetchedCryptoCurrency : CryptoCurrency?
    var freshFetchedCurrency : CryptoCurrency?
    var bannerView : GADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commoninit()
        showAds()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animateCurrencyImageView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    func commoninit(){
        self.cryptoCurrencyDetailTableView.dataSource = self
        self.cryptoCurrencyDetailTableView.delegate = self
        if #available(iOS 10.0, *){
            self.cryptoCurrencyDetailTableView.refreshControl = self.pullToRefereshControl
        } else {
            self.cryptoCurrencyDetailTableView.addSubview(self.pullToRefereshControl)
        }
        self.pullToRefereshControl.addTarget(self, action: #selector(handlePullToReferesh), for: UIControlEvents.valueChanged)
        self.cryptoCurrencyDetailTableView.register(UINib.init(nibName: "CurrencyDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "CurrencyDetailTableViewCell")
        self.cryptoCurrencyDetailTableView.separatorStyle = .none
        self.currencyDetailLabel.numberOfLines = 0
        self.view.backgroundColor = UIColor.white
        self.cryptoCurrencyDetailTableView.backgroundColor = UIColor.clear
        setUpNavigation()
        if let bgColor = getAverageColorValueForCurrency(){
            backGroundImageView.backgroundColor = bgColor
            self.navigationController?.navigationBar.barTintColor = bgColor
        }
        self.setTextForCurrencyDetailLabel(currencyNameFont: 30, lastUpdatedFont: 12)
        self.currencyImageView.layer.shadowColor = UIColor.black.cgColor
        self.currencyImageView.layer.shadowRadius = CGFloat(2.0)
        self.currencyImageView.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.currencyImageView.layer.shadowOpacity = 1
        self.currencyImageView.clipsToBounds = false
        GenericFunctions.sendEventsToMoEngage(event : "CurrencyDetail",payload:["CurrencyName":previousFetchedCryptoCurrency?.name ?? "","Price" : previousFetchedCryptoCurrency?.priceUsd ?? "0"])
    }
    
    func animateCurrencyImageView(){
        let rotationAnimation = CABasicAnimation.init(keyPath: "transform.rotation.z")
        rotationAnimation.toValue = 3.14159 // pi rotation
        rotationAnimation.duration = CFTimeInterval.init(0.35)
        rotationAnimation.isCumulative = true
        rotationAnimation.repeatCount = 2
        self.currencyImageView.layer.add(rotationAnimation, forKey: "rotationAnimation")
    }
    
    func setUpNavigation(){
        self.navigationController?.navigationBar.barTintColor = UIColor.clear
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear
    }
    
    func getAverageColorValueForCurrency() -> UIColor?{
        if let currencyImage = UIImage.init(named: previousFetchedCryptoCurrency!.name!){
            currencyImageView.image = currencyImage
            var bitmap = [UInt8](repeating : 0,count : 4)
            let context = CIContext(options : nil)
            let inputImage = CIImage(image:currencyImage)
            let extent = inputImage!.extent
            let inputExtent = CIVector(x: extent.origin.x, y: extent.origin.y, z: extent.size.width, w: extent.size.height)
            let filter = CIFilter(name: "CIAreaAverage", withInputParameters: [kCIInputImageKey: inputImage!, kCIInputExtentKey: inputExtent])!
            let outputImage = filter.outputImage!
            let outputExtent = outputImage.extent
            assert(outputExtent.size.width == 1 && outputExtent.size.height == 1)
            
            // Render to bitmap.
            context.render(outputImage, toBitmap: &bitmap, rowBytes: 4, bounds: CGRect(x: 0, y: 0, width: 1, height: 1), format: kCIFormatRGBA8, colorSpace: CGColorSpaceCreateDeviceRGB())
            
            // Compute and implement result.
            let result = UIColor.init(red: 1.0-CGFloat(bitmap[0])/255, green: 1.0-CGFloat(bitmap[1])/255, blue: 1.0-CGFloat(bitmap[2])/255, alpha: 1)
            self.backgroundView.backgroundColor =  UIColor.init(red:CGFloat(bitmap[0])/255, green:CGFloat(bitmap[1])/255, blue:CGFloat(bitmap[2])/255, alpha: 0.1)
            return result
        }else{
            firstLetterLabel.text = String(describing: self.previousFetchedCryptoCurrency!.name!.first!)
            firstLetterLabel.font = UIFont.systemFont(ofSize: 60, weight: UIFont.Weight.bold)
            self.currencyImageView.backgroundColor = UIColor.lightGray
            self.backGroundImageView.backgroundColor = UIColor.init(red: 150/255, green: 150/255, blue: 200/255, alpha: 0.2)
            self.backgroundView.backgroundColor = UIColor.init(red: 200/255, green: 200/255, blue: 200/255, alpha: 0.2)
            self.currencyImageView.layer.shadowRadius = CGFloat(3.0)
        }
        return UIColor.white
    }
    
    func showAds(){
        bannerView = GADBannerView(adSize: GADAdSizeFullWidthPortraitWithHeight(50))
        bannerView.adUnitID = "ca-app-pub-3940256099942544/6300978111"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        bannerView.delegate = self
        self.adView.addSubview(bannerView)
        bannerView.clipsToBounds = true
    }
    
    func setTextForCurrencyDetailLabel(currencyNameFont : CGFloat, lastUpdatedFont:CGFloat){
        if let currency = self.previousFetchedCryptoCurrency, let currencyName = currency.name{
            let lastUpdated = "last updated \(GenericFunctions.getTimeDifferenceFromNow(time: currency.lastUpdated!))"
            let attributedText = NSMutableAttributedString.init(string: "\(currencyName)\n\(lastUpdated)")
            attributedText.addAttribute(NSAttributedStringKey.font, value: UIFont.systemFont(ofSize: currencyNameFont, weight: UIFont.Weight.bold), range: NSRange.init(location: 0, length: currencyName.count))
            attributedText.addAttribute(NSAttributedStringKey.font, value: UIFont.systemFont(ofSize: lastUpdatedFont, weight: UIFont.Weight.light), range: NSRange.init(location: currencyName.count+1, length: lastUpdated.count))
            self.currencyDetailLabel.attributedText = attributedText
        }
        
    }
    
    func dataForIndexPath(indexPath : IndexPath) -> NSMutableAttributedString{
        let data = NSMutableAttributedString.init()
        var dataString = ""
        if let currency = self.previousFetchedCryptoCurrency{
            switch indexPath.row {
            case 0:
                dataString = "Symbol : \(currency.symbol!)"
                data.setAttributedString(NSAttributedString.init(string: dataString))
                data.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.init(red: 38/255, green: 23/255, blue: 161/255, alpha: 1), range: NSRange.init(location: String(dataString.prefix(upTo: dataString.index(of: ":")!)).count, length: String(dataString.suffix(from: dataString.index(of: ":")!)).count))
                break
            case 1:
                dataString = "Rank : \(currency.rank!)"
                data.setAttributedString(NSAttributedString.init(string: dataString))
                data.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.init(red: 38/255, green: 23/255, blue: 161/255, alpha: 1), range: NSRange.init(location: String(dataString.prefix(upTo: dataString.index(of: ":")!)).count, length: String(dataString.suffix(from: dataString.index(of: ":")!)).count))
                break
            case 2:
                dataString = "Price : \(SettingsManager.sharedInstance.getConvertedCurrencyStringFromUSD(to: SettingsManager.sharedInstance.getSelectedCurrency(), value: currency.priceUsd!))"
                data.setAttributedString(NSAttributedString.init(string: dataString))
                data.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.init(red: 38/255, green: 23/255, blue: 161/255, alpha: 1), range: NSRange.init(location: String(dataString.prefix(upTo: dataString.index(of: ":")!)).count, length: String(dataString.suffix(from: dataString.index(of: ":")!)).count))
                break
            case 3:
                dataString = "Price(BTC) : \(currency.priceBTC!)"
                data.setAttributedString(NSAttributedString.init(string: dataString))
                data.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.init(red: 38/255, green: 23/255, blue: 161/255, alpha: 1), range: NSRange.init(location: String(dataString.prefix(upTo: dataString.index(of: ":")!)).count, length: String(dataString.suffix(from: dataString.index(of: ":")!)).count))
                break
            case 4:
                let lastHrPriceChange = currency.percentChangedLast1Hr!
                dataString = "Last hour change : \(lastHrPriceChange)%"
                data.setAttributedString(NSAttributedString.init(string: dataString))
                
                if String(lastHrPriceChange.prefix(upTo: lastHrPriceChange.index(lastHrPriceChange.startIndex, offsetBy: 1))) == "-"{
                    data.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.init(red: 200/255, green: 81/255, blue: 56/255, alpha: 1.0), range: NSRange.init(location: String(dataString.prefix(upTo: dataString.index(of: ":")!)).count, length: String(dataString.suffix(from: dataString.index(of: ":")!)).count))//red color
                }else{
                    data.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.init(red: 84/255, green: 167/255, blue: 65/255, alpha: 1.0), range: NSRange.init(location: String(dataString.prefix(upTo: dataString.index(of: ":")!)).count, length: String(dataString.suffix(from: dataString.index(of: ":")!)).count))//Green color
                }
                break
            case 5:
                let lastDayPriceChange = currency.percentChangedLast24Hr!
                dataString = "Last day change : \(lastDayPriceChange)%"
                data.setAttributedString(NSAttributedString.init(string: dataString))
                
                if String(lastDayPriceChange.prefix(upTo: lastDayPriceChange.index(lastDayPriceChange.startIndex, offsetBy: 1))) == "-"{
                    data.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.init(red: 200/255, green: 81/255, blue: 56/255, alpha: 1.0), range: NSRange.init(location: String(dataString.prefix(upTo: dataString.index(of: ":")!)).count, length: String(dataString.suffix(from: dataString.index(of: ":")!)).count))//red color
                }else{
                    data.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.init(red: 84/255, green: 167/255, blue: 65/255, alpha: 1.0), range: NSRange.init(location: String(dataString.prefix(upTo: dataString.index(of: ":")!)).count, length: String(dataString.suffix(from: dataString.index(of: ":")!)).count))//Green color
                }
                break
            case 6:
                let lastWeekPriceChange = currency.percentChangedLast7Days!
                dataString = "Last week change : \(lastWeekPriceChange)%"
                data.setAttributedString(NSAttributedString.init(string: dataString))
                
                if String(lastWeekPriceChange.prefix(upTo: lastWeekPriceChange.index(lastWeekPriceChange.startIndex, offsetBy: 1))) == "-"{
                    data.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.init(red: 200/255, green: 81/255, blue: 56/255, alpha: 1.0), range: NSRange.init(location: String(dataString.prefix(upTo: dataString.index(of: ":")!)).count, length: String(dataString.suffix(from: dataString.index(of: ":")!)).count))//red color
                }else{
                    data.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.init(red: 84/255, green: 167/255, blue: 65/255, alpha: 1.0), range: NSRange.init(location: String(dataString.prefix(upTo: dataString.index(of: ":")!)).count, length: String(dataString.suffix(from: dataString.index(of: ":")!)).count))//Green color
                }
                break
            case 7:
                dataString = "Supply : \(GenericFunctions.getFormattedCommaSeperatedNumber(input: currency.totalSupply!))"
                data.setAttributedString(NSAttributedString.init(string: dataString))
                data.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.init(red: 38/255, green: 23/255, blue: 161/255, alpha: 1), range: NSRange.init(location: String(dataString.prefix(upTo: dataString.index(of: ":")!)).count, length: String(dataString.suffix(from: dataString.index(of: ":")!)).count))
                break
            case 8:
                dataString = "Volume(24 hours) : \(SettingsManager.sharedInstance.getConvertedCurrencyStringFromUSD(to: SettingsManager.sharedInstance.getSelectedCurrency(), value: currency.volumeUsedLast24HrUSD!))"
                data.setAttributedString(NSAttributedString.init(string: dataString))
                data.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.init(red: 38/255, green: 23/255, blue: 161/255, alpha: 1), range: NSRange.init(location: String(dataString.prefix(upTo: dataString.index(of: ":")!)).count, length: String(dataString.suffix(from: dataString.index(of: ":")!)).count))
                break
            default:
                break
            }
        }
        data.addAttribute(NSAttributedStringKey.font, value: UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.medium), range: NSRange.init(location: 0, length: dataString.count))
        return data
    }
    
    func getDataAndUpdate(isForceFetch : Bool){
        DataManager.sharedInstance.getDataForAppendingParameters(withForceFetch: isForceFetch, additionalComponents :[(previousFetchedCryptoCurrency!.name!)],parameters: ["convert=\(SettingsManager.sharedInstance.getSelectedCurrency())"], cacheTime: "60") { (currencyArray) in
            if currencyArray.count > 0{
                self.previousFetchedCryptoCurrency = currencyArray[0]
                self.cryptoCurrencyDetailTableView.reloadData()
            }
            self.setTextForCurrencyDetailLabel(currencyNameFont: 30, lastUpdatedFont: 12)
            self.animateCurrencyImageView()
            self.pullToRefereshControl.endRefreshing()
            
        }
    }
    
    @objc func back(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func handlePullToReferesh(){
        // referesh data and handle currency image animation.
        getDataAndUpdate(isForceFetch: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension CurrencyDetailViewController : GADBannerViewDelegate{
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        //removeAds()
        print("adViewDidReceiveAd")
    }
    
    /// Tells the delegate an ad request failed.
    func adView(_ bannerView: GADBannerView,
                didFailToReceiveAdWithError error: GADRequestError) {
        print("adView:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }
    
    /// Tells the delegate that a full screen view will be presented in response
    /// to the user clicking on an ad.
    func adViewWillPresentScreen(_ bannerView: GADBannerView) {
        print("adViewWillPresentScreen")
    }
    
    /// Tells the delegate that the full screen view will be dismissed.
    func adViewWillDismissScreen(_ bannerView: GADBannerView) {
        print("adViewWillDismissScreen")
    }
    
    /// Tells the delegate that the full screen view has been dismissed.
    func adViewDidDismissScreen(_ bannerView: GADBannerView) {
        print("adViewDidDismissScreen")
    }
    
    /// Tells the delegate that a user click will open another app (such as
    /// the App Store), backgrounding the current app.
    func adViewWillLeaveApplication(_ bannerView: GADBannerView) {
        print("adViewWillLeaveApplication")
    }
}

extension CurrencyDetailViewController : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyDetailTableViewCell", for: indexPath) as! CurrencyDetailTableViewCell
        cell.bindData(indexpath: indexPath, data: self.dataForIndexPath(indexPath: indexPath))
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < -24{
            self.setTextForCurrencyDetailLabel(currencyNameFont: (30+(5*(log(-scrollView.contentOffset.y)-log(24)))), lastUpdatedFont: (12+(3*(log(-scrollView.contentOffset.y)-log(24)))))
        }else{
            self.setTextForCurrencyDetailLabel(currencyNameFont: 30, lastUpdatedFont: 12)
        }
    }
}
