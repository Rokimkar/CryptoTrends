//
//  ViewController.swift
//  CryptoTrends
//
//  Created by S@nchit on 24/09/17.
//  Copyright © 2017 S@nchit. All rights reserved.
//

import UIKit
import GoogleMobileAds

class HomeViewController: UIViewController {

    @IBOutlet weak var adView: UIView!
    var dataArray : [CryptoCurrency] = []
    var bannerView : GADBannerView!
    @IBOutlet weak var currencyTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
        DataManager.sharedInstance.getDataForAppendingParameters(parameters: []) { (data) in
            self.dataArray = data
            self.currencyTableView.reloadData()
        }
        showAds()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func commonInit(){
        self.currencyTableView.dataSource = self
        self.currencyTableView.delegate = self
        self.currencyTableView.register(UINib.init(nibName: "CurrencyTableViewCell", bundle: nil), forCellReuseIdentifier: "CurrencyTableViewCell")
        self.currencyTableView.separatorStyle = .none
        self.view.backgroundColor = UIColor.clear
        self.view.backgroundColor = UIColor.init(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.8)
        self.title = "CryptoTrends"
        self.adView.backgroundColor = UIColor.clear
        setUpNavigationBar()
    }
    
    func showAds(){
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        bannerView.adUnitID = "ca-app-pub-3940256099942544/6300978111"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        bannerView.delegate = self
        self.currencyTableView.addSubview(bannerView)
    }
    
    func setUpNavigationBar(){
        self.navigationController?.navigationBar.barTintColor = UIColor.init(red: 31/255, green: 72/255, blue: 24/255, alpha: 0.4)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white,NSAttributedStringKey.font : UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.bold)]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension HomeViewController : GADBannerViewDelegate{
    /// Tells the delegate an ad request loaded an ad.
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        self.adView.addSubview(bannerView)
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

extension HomeViewController : UITableViewDataSource,UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyTableViewCell", for: indexPath) as! CurrencyTableViewCell
        cell.selectionStyle = .none
        cell.bindData(currency: dataArray[indexPath.row])
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowRadius = 2.0
        cell.layer.shadowOffset = CGSize.init(width: 1, height: 1)
        cell.layer.shadowOpacity = 1.0
        cell.contentView.backgroundColor = UIColor.clear
        cell.backgroundColor = UIColor.clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currencyDetailVC = CurrencyDetailViewController.init(nibName: "CurrencyDetailViewController", bundle: nil)
        currencyDetailVC.cryptoCurrency = self.dataArray[indexPath.row]
        self.navigationController?.pushViewController(currencyDetailVC, animated: true)
    }
}

