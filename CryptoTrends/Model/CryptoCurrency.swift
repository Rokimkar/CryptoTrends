//
//  CryptoCurrency.swift
//  CryptoTrends
//
//  Created by S@nchit on 24/09/17.
//  Copyright © 2017 S@nchit. All rights reserved.
//

import UIKit

class CryptoCurrency: Codable {
    let id : String?
    let name : String?
    let symbol : String?
    let rank : String?
    let priceUsd : String?
    let priceBTC : String?
    let volumeUsedLast24HrUSD : String?
    let marketCapUSD : String?
    let availableSupply : String?
    let totalSupply : String?
    let percentChangedLast1Hr : String?
    let percentChangedLast24Hr : String?
    let percentChangedLast7Days : String?
    let lastUpdated : String?
    
    enum CodingKeys : String, CodingKey{
        case id = "id"
        case name = "name"
        case symbol = "symbol"
        case rank = "rank"
        case priceUsd = "price_usd"
        case priceBTC = "price_btc"
        case volumeUsedLast24HrUSD = "24h_volume_usd"
        case marketCapUSD = "market_cap_usd"
        case availableSupply = "available_supply"
        case totalSupply = "total_supply"
        case percentChangedLast1Hr = "percent_change_1h"
        case percentChangedLast24Hr = "percent_change_24h"
        case percentChangedLast7Days = "percent_change_7d"
        case lastUpdated = "last_updated"
    }
    
}
