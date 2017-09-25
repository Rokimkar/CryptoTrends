//
//  DataManager.swift
//  CryptoTrends
//
//  Created by S@nchit on 24/09/17.
//  Copyright © 2017 S@nchit. All rights reserved.
//

import UIKit
import Alamofire

class DataManager: NSObject {
    static let sharedInstance = DataManager()
    let baseUrl = "https://api.coinmarketcap.com/v1/ticker/"
    
    func getDataForAppendingParameters(parameters : [String],completionHandler : @escaping (_ data :[CryptoCurrency]) -> Void){
        var parametersStr = ""
        for parameter : String in parameters{
            parametersStr += parameter
            if parameter != parameters.last!{
                parametersStr += "&"
            }
        }
        if parametersStr != ""{
            parametersStr = "?"+parametersStr
        }
        getCurrencyDataForUrl(url: baseUrl+parametersStr) { (cryptoCurrencyData) in
            //print(cryptoCurrencyData)
            completionHandler(cryptoCurrencyData)
        }
    }
    
    func getCurrencyDataForUrl(url:String,completionHandler  :@escaping (_ data:[CryptoCurrency]) -> Void){
        CacheHelper.getCacheData(url: (URL.init(string: url)?.pathComponents.last)!, success: { (data) in
            completionHandler(data)
        }) { (error) in
            Alamofire.request(URL.init(string: url)!).responseData { (response) in
                if let data = response.result.value{
                    let decoder = JSONDecoder()
                    do {
                        let mappedData = try decoder.decode([CryptoCurrency].self, from: data)
                        CacheHelper.saveCacheData(urlStr: (URL.init(string: url)?.pathComponents.last)!, data: mappedData)
                        completionHandler(mappedData)
                    }catch{
                        completionHandler([])
                    }
                }
            }
        }
        
    }
}
