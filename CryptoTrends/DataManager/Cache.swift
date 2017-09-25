//
//  Cache.swift
//  CryptoTrends
//
//  Created by S@nchit on 25/09/17.
//  Copyright © 2017 S@nchit. All rights reserved.
//

import UIKit

class Cache: Codable {
    let data : [CryptoCurrency]?
    let lastSavedTime : Date?
    init(data : [CryptoCurrency],lastSavedTime : Date) {
        self.data = data
        self.lastSavedTime = lastSavedTime
    }
}
