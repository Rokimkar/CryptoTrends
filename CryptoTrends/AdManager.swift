//
//  AdManager.swift
//  CryptoTrends
//
//  Created by S@nchit on 06/10/17.
//  Copyright © 2017 S@nchit. All rights reserved.
//

import UIKit
import GoogleMobileAds

class AdManager: NSObject {
    var bannerView : GADBannerView!
    
    func getBannerAdView() -> GADBannerView{
        return self.bannerView
    }
}
