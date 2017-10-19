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
    var countryCurrencySymbols : CountryCurrencySymbols? = nil
    fileprivate var selectedCurrency = currencyCode.INR
    
    func getSelectedCurrency() -> currencyCode{
        return selectedCurrency
    }
    
    func updateSelectedCurrency(updatedCurrency : currencyCode){
        selectedCurrency = updatedCurrency
    }
    
    func getCountryCurrency(){
        DataManager.sharedInstance.getDataForUrl(url: "https://api.fixer.io/latest", completionHandler: {(data) in
            let decoder = JSONDecoder()
            do {
                    let mappedData = try decoder.decode(CountryCurrencySymbols.self, from: data)
                    print(mappedData)
//                    CacheHelper.saveCacheData(urlStr: (URL.init(string: urlString)?.pathComponents.last)!, data: mappedData)
//                    success(mappedData)
                }catch{
                    print(error)
                    //failure(NSError.init(domain: "Decoding Error", code: 0, userInfo: nil))
                }
        })
    }
    
}
