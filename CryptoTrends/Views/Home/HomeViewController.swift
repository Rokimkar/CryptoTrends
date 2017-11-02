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

    @IBOutlet weak var heightConstraintForAdView: NSLayoutConstraint!
    @IBOutlet weak var adView: UIView!
    @IBOutlet weak var currencyTableView: UITableView!
    
    var dataArray : [CryptoCurrency] = []
    var bannerView : GADBannerView!
    private let pullToRefreshControl = UIRefreshControl.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
        getDataAndUpdateTable(isForceFetch: true)
        showAds()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.currencyTableView.reloadData()
        setUpNavigationBar()
    }
    
    func commonInit(){
        self.currencyTableView.dataSource = self
        self.currencyTableView.delegate = self
        self.currencyTableView.register(UINib.init(nibName: "CurrencyTableViewCell", bundle: nil), forCellReuseIdentifier: "CurrencyTableViewCell")
        self.currencyTableView.separatorStyle = .none
        self.view.backgroundColor = UIColor.clear
        self.view.backgroundColor = UIColor.init(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.8)
        self.title = "Home"
        self.adView.backgroundColor = UIColor.clear
        setUpNavigationBar()
        if #available(iOS 10.0, *){
            currencyTableView.refreshControl = pullToRefreshControl
        } else {
            currencyTableView.addSubview(pullToRefreshControl)
        }
        pullToRefreshControl.addTarget(self, action: #selector(pullToRefereshed), for: UIControlEvents.valueChanged)
        pullToRefreshControl.beginRefreshing()
    }

    func getDataAndUpdateTable(isForceFetch : Bool){
//        SettingsManager.sharedInstance.updateSelectedCurrency(updatedCurrency: CurrencyCode.INR) { (isUpdateded) in
//            //
//        }
        DataManager.sharedInstance.getDataForAppendingParameters(withForceFetch: isForceFetch,additionalComponents :[],parameters: ["convert=\(SettingsManager.sharedInstance.getSelectedCurrency())"], cacheTime: "60") { (data) in
            self.dataArray = data
            self.pullToRefreshControl.endRefreshing()
            self.currencyTableView.reloadData()
            print(GenericFunctions.searchKeyword(dataArray: data, keyword: "bit"))
        }
    }
    
    func showAds(){
        bannerView = GADBannerView(adSize: GADAdSizeFullWidthPortraitWithHeight(100))
        bannerView.adUnitID = "ca-app-pub-3940256099942544/6300978111"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        bannerView.delegate = self
        heightConstraintForAdView.constant = bannerView.frame.size.height
        self.adView.addSubview(bannerView)
        bannerView.clipsToBounds = true
    }
    
    func removeAds(){
        heightConstraintForAdView.constant = 0
        bannerView.removeFromSuperview()
    }
    
    func setUpNavigationBar(){
        self.navigationController?.navigationBar.barTintColor = UIColor.init(red: 31/255, green: 72/255, blue: 24/255, alpha: 0.4)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white,NSAttributedStringKey.font : UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.bold)]
        self.navigationController?.navigationBar.isTranslucent = false
        
        let settingsButton = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 50, height: 50))
        settingsButton.setImage(UIImage.init(named: "Settings"), for: .normal)
        settingsButton.addTarget(self, action: #selector(settingsClicked), for: .touchUpInside)
        
        let searchButton = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 30, height: 30))
        searchButton.setImage(UIImage.init(named: "Search"), for: .normal)
        searchButton.addTarget(self, action: #selector(searchClicked), for: .touchUpInside)
        searchButton.imageView?.contentMode = .scaleAspectFit
        self.navigationItem.rightBarButtonItems = [UIBarButtonItem.init(customView: searchButton)]
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: settingsButton)
    }
    
    @objc func searchClicked(){
        let searchController = SearchViewController.init(nibName: "SearchViewController", bundle: nil)
        searchController.dataArray = dataArray
        self.navigationController?.pushViewController(searchController, animated: true)
    }
    
    @objc func pullToRefereshed(){
        getDataAndUpdateTable(isForceFetch: true)
    }
    
    @objc func settingsClicked(){
        let settingsViewController = SettingsViewController.init(nibName: "SettingsViewController", bundle: nil)
        self.navigationController?.pushViewController(settingsViewController, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension HomeViewController : GADBannerViewDelegate{
    /// Tells the delegate an ad request loaded an ad.
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        
        print("adViewDidReceiveAd")
    }
    
    /// Tells the delegate an ad request failed.
    func adView(_ bannerView: GADBannerView,
                didFailToReceiveAdWithError error: GADRequestError) {
        removeAds()
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
        currencyDetailVC.previousFetchedCryptoCurrency = self.dataArray[indexPath.row]
        self.navigationController?.pushViewController(currencyDetailVC, animated: true)
    }
}

