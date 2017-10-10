//
//  SettingsManager.swift
//  CryptoTrends
//
//  Created by S@nchit on 09/10/17.
//  Copyright © 2017 S@nchit. All rights reserved.
//

import UIKit

public enum currencyCode : String {
    case INR = "inr"
    case USD = "usd"
}

class SettingsManager: NSObject {
    
    static let sharedInstance = SettingsManager()
    fileprivate var selectedCurrency = currencyCode.USD
    
    func getSelectedCurrency() -> currencyCode{
        return selectedCurrency
    }
    
}
