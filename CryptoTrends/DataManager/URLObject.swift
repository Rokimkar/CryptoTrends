//
//  URLObject.swift
//  CryptoTrends
//
//  Created by S@nchit on 03/11/17.
//  Copyright © 2017 S@nchit. All rights reserved.
//

import UIKit

class URLObject: NSObject {
    
    let urlString : String
    let cacheTime : String // in secs
    
    init(url : String,cacheTime:String) {
        self.urlString = url
        self.cacheTime = cacheTime
    }
}
