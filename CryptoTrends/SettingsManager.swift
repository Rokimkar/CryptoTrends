//
//  SettingsManager.swift
//  CryptoTrends
//
//  Created by S@nchit on 09/10/17.
//  Copyright © 2017 S@nchit. All rights reserved.
//

import UIKit

public enum currencyCode : String {
    case INR = "INR"
    case USD = "USD"
}

class SettingsManager: NSObject {
    
    static let sharedInstance = SettingsManager()
    fileprivate var selectedCurrency = currencyCode.INR
    
    func getSelectedCurrency() -> currencyCode{
        return selectedCurrency
    }
    
    func updateSelectedCurrency(updatedCurrency : currencyCode){
        selectedCurrency = updatedCurrency
    }
    
}
