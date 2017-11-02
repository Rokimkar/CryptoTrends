//
//  CacheHelper.swift
//  CryptoTrends
//
//  Created by S@nchit on 25/09/17.
//  Copyright © 2017 S@nchit. All rights reserved.
//

import UIKit
import Disk

class CacheHelper: NSObject {
    
    class func saveCacheData(urlStr:String, data : [CryptoCurrency]){
        let cache = Cache.init(data: data, lastSavedTime: Date(timeIntervalSinceReferenceDate:NSTimeIntervalSince1970))
        do{
            try Disk.save(cache, to: .documents, as: urlStr)
        }catch{
            print(error)
        }
    }
    
    class func getCacheData(url : URLObject, success : ([CryptoCurrency]) -> Void,failure : (_ error:Error) -> Void){
        do{
            let cacheData = try Disk.retrieve(url.urlString, from: .documents, as: Cache.self)
            let now = Date() //Date(timeIntervalSinceReferenceDate:NSTimeIntervalSince1970)
            let timeDifference = abs(Int(cacheData.lastSavedTime!.timeIntervalSince(now))/60) //in minutes
            if timeDifference < Int(url.cacheTime)!/60{
                success(cacheData.data!)
            }else{
                failure(NSError.init(domain: "Time Limit exceeded", code: 1, userInfo: nil))
            }
        }catch{
            print(error)
            failure(error)
        }
    }
}
