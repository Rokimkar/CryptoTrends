//
//  SettingsManager.swift
//  CryptoTrends
//
//  Created by S@nchit on 09/10/17.
//  Copyright © 2017 S@nchit. All rights reserved.
//

import UIKit

public enum currencyCode : String {
    case AUD = "AUD"
    case BGN = "BGN"
    case BRL = "BRL"
    case CAD = "CAD"
    case CHF = "CHF"
    case CNY = "CNY"
    case CZK = "CZK"
    case DKK = "DKK"
    case GBP = "GBP"
    case HKD = "HKD"
    case HRK  = "HRK"
    case HUF = "HUF"
    case IDR = "IDR"
    case ILS = "ILS"
    case INR = "INR"
    case JPY = "JPY"
    case KRW = "KRW"
    case MXN = "MXN"
    case MYR = "MYR"
    case NOK = "NOK"
    case NZD = "NZD"
    case PHP = "PHP"
    case PLN = "PLN"
    case RON = "RON"
    case RUB = "RUB"
    case SEK = "SEK"
    case SGD = "SGD"
    case THB = "THB"
    case TRY = "TRY"
    case USD = "USD"
    case ZAR = "ZAR"
}

class SettingsManager: NSObject {
    
    static let sharedInstance = SettingsManager()
    var countryCurrencySymbols : CountryCurrencySymbols? = nil
    fileprivate var selectedCurrency = currencyCode.INR
    
    func getSelectedCurrency() -> currencyCode{
        return selectedCurrency
    }
    
    func updateSelectedCurrency(updatedCurrency : currencyCode,completionHandler:@escaping (_ isUpdated:Bool) -> Void){
        if countryCurrencySymbols == nil{
            self.getCountryCurrency(completionhandler: { (isFetched) in
                self.selectedCurrency = updatedCurrency
                if isFetched == true{
                    completionHandler(true)
                }else{
                    completionHandler(false)
                }
            })
        }else{
            selectedCurrency = updatedCurrency
            completionHandler(true)
        }
    }
    
    func getCountryCurrency(completionhandler:@escaping (_ isFetched : Bool)->Void){
        if self.countryCurrencySymbols == nil{
            DataManager.sharedInstance.getDataForUrl(url: "https://api.fixer.io/latest", completionHandler: {(data) in
                let decoder = JSONDecoder()
                do {
                    let mappedData = try decoder.decode(CountryCurrencySymbols.self, from: data)
                    self.countryCurrencySymbols = mappedData
                    completionhandler(true)
                }catch{
                    completionhandler(true)
                }
            })
        }
        
    }
}
