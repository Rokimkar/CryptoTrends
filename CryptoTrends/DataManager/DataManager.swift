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
    
    func getDataForAppendingParameters(withForceFetch : Bool,additionalComponents : [String], parameters : [String],completionHandler : @escaping (_ data :[CryptoCurrency]) -> Void){
        var addComponents = ""
        for component : String in additionalComponents{
            addComponents += "\(component)/"
        }
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
        getCurrencyDataForUrl(withForceFetch: withForceFetch, url: baseUrl+addComponents+parametersStr) { (cryptoCurrencyData) in
            //print(cryptoCurrencyData)
            completionHandler(cryptoCurrencyData)
        }
    }

    func getDataForUrl(url: String,completionHandler : @escaping (_ data : Data) -> Void){
        Alamofire.request(URL.init(string: url)!).responseData { (response) in
            if let data = response.result.value{
                completionHandler(data)
            }else {
                completionHandler(Data.init())
            }
        }
    }
    
    fileprivate func getCurrencyDataForUrl(withForceFetch:Bool,url:String,completionHandler  :@escaping (_ data:[CryptoCurrency]) -> Void){
        if withForceFetch == true{
            getDataForUrl(urlString: url, success: { (data) in
                completionHandler(data)
            }, failure: { (error) in
                completionHandler([])
            })
        } else {
            CacheHelper.getCacheData(url: (URL.init(string: url)?.pathComponents.last)!, success: { (data) in
                completionHandler(data)
            }) { (error) in
                getDataForUrl(urlString: url, success: { (data) in
                    completionHandler(data)
                }, failure: { (error) in
                    completionHandler([])
                })
            }
        }
        
    }
    
    private func getDataForUrl(urlString : String, success : @escaping ([CryptoCurrency]) -> Void ,failure : @escaping (_ error : Error) -> Void) {
        Alamofire.request(URL.init(string: urlString)!).responseData { (response) in
            if let data = response.result.value{
                let decoder = JSONDecoder()
                do {
                    let mappedData = try decoder.decode([CryptoCurrency].self, from: data)
                    CacheHelper.saveCacheData(urlStr: (URL.init(string: urlString)?.pathComponents.last)!, data: mappedData)
                    success(mappedData)
                }catch{
                    failure(NSError.init(domain: "Decoding Error", code: 0, userInfo: nil))
                }
            }
        }
        
            .responseJSON { (response) in
                if let data = response.result.value{
                    self.prepareDataForSerialization(data: data)
                    print(data)
                }
        }

    }

    private func prepareDataForSerialization(data: Any){
        
    }

}
