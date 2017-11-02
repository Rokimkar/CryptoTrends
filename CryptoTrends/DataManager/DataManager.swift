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
    
    func getDataForAppendingParameters(withForceFetch : Bool,additionalComponents : [String], parameters : [String],cacheTime:String,completionHandler : @escaping (_ data :[CryptoCurrency]) -> Void){
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
        let urlObject = URLObject.init(url: baseUrl+addComponents+parametersStr, cacheTime: cacheTime)
        getCurrencyDataForUrl(withForceFetch: withForceFetch, url: urlObject) { (cryptoCurrencyData) in
            //print(cryptoCurrencyData)
            completionHandler(cryptoCurrencyData)
        }
    }

    func getDataForUrl(url: String, completionHandler : @escaping (_ data : Data) -> Void){
        Alamofire.request(URL.init(string: url)!).responseData { (response) in
            if let data = response.result.value{
                completionHandler(data)
            }else {
                completionHandler(Data.init())
            }
        }
    }
    
    fileprivate func getCurrencyDataForUrl(withForceFetch:Bool,url:URLObject,completionHandler  :@escaping (_ data:[CryptoCurrency]) -> Void){
        if withForceFetch == true{
            getDataForUrl(urlObject: url, success: { (data) in
                completionHandler(data)
            }, failure: { (error) in
                completionHandler([])
            })
        } else {
            CacheHelper.getCacheData(url: url, success: { (data) in
                completionHandler(data)
            }) { (error) in
                getDataForUrl(urlObject: url, success: { (data) in
                    completionHandler(data)
                }, failure: { (error) in
                    completionHandler([])
                })
            }
        }
        
    }
    
    private func getDataForUrl(urlObject : URLObject, success : @escaping ([CryptoCurrency]) -> Void ,failure : @escaping (_ error : Error) -> Void) {
        Alamofire.request(URL.init(string: urlObject.urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!).responseData { (response) in
            if let data = response.result.value{
                let decoder = JSONDecoder()
                do {
                    let mappedData = try decoder.decode([CryptoCurrency].self, from: data)
                    CacheHelper.saveCacheData(urlStr: (URL.init(string: urlObject.urlString)?.pathComponents.last)!, data: mappedData)
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
