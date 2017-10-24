//
//  SettingsManager.swift
//  CryptoTrends
//
//  Created by S@nchit on 09/10/17.
//  Copyright © 2017 S@nchit. All rights reserved.
//

import UIKit

public enum CurrencyCode : String {
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
    
    //static let sharedInstance = SettingsManager()
    class var sharedInstance : SettingsManager{
        struct Static {
            static let instance = SettingsManager()
        }
        Static.instance.getCountryCurrency(completionhandler: { (isFetched) in
            
        })
        return Static.instance
    }
    var countryCurrencySymbols : CountryCurrencySymbols? = nil
    fileprivate var selectedCurrency = CurrencyCode.INR
    static let currencyVisualSymbolsList = ["AUD":"A$","BGN":"BGN","BRL":"R$","CAD":"$","CHF":"CHF","CNY":"¥","CZK":"Kč","DKK":"kr","GBP":"£","HKD":"$","HRK":"kn","HUF":"Ft","IDR":"Rp","ILS":"₪","INR":"₹","JPY":"¥","KRW":"₩","MXN":"$","MYR":"RM","NOK":"kr","NZD":"$","PHP":"₱","PLN":"zł","RON":"lei","RUB":"руб","SEK":"kr","SGD":"S$","THB":"฿","TRY":"TL","USD":"$","ZAR":"R"]
    static let currencySymbolsArray = ["AUD","BGN","AUD","BGN","BRL","CAD","CHF","CNY","CZK","DKK","GBP","HKD","HRK","HUF","IDR","ILS","INR","JPY","KRW","MXN","MYR","NOK","NZD","PHP","PLN","RON","RUB","SEK","SGD","THB","TRY","USD","ZAR"]
    
    func getSelectedCurrency() -> CurrencyCode{
        return selectedCurrency
    }
    
    func updateSelectedCurrency(updatedCurrency : CurrencyCode,completionHandler:@escaping (_ isUpdated:Bool) -> Void){
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
                    completionhandler(false)
                }
            })
        }else{
            completionhandler(true)
        }
        
    }
    
    func getConvertedCurrencyStringFromUSD(to: CurrencyCode, value : String) -> String{
        var convertedValue = ""
        if let symbols = self.countryCurrencySymbols{
            convertedValue = SettingsManager.currencyVisualSymbolsList[to.rawValue]! + " " + GenericFunctions.getFormattedCommaSeperatedNumber(input: String(Float(value)!*(Float(symbols.rates[to.rawValue]!)/Float(symbols.rates[CurrencyCode.USD.rawValue]!))))
        }else{
            convertedValue = "\(SettingsManager.currencyVisualSymbolsList[CurrencyCode.USD.rawValue] ?? String.init("$")) " + GenericFunctions.getFormattedCommaSeperatedNumber(input: value)
        }
        return convertedValue
    }
}
