//
//  CountryCurrencySymbols.swift
//  CryptoTrends
//
//  Created by S@nchit on 19/10/17.
//  Copyright © 2017 S@nchit. All rights reserved.
//

import UIKit

class CountryCurrencySymbols: Codable {
    
    let base : String
    let date : String
    let rates : Dictionary<String,Double>
    
    enum CodingKeys : String,CodingKey{
        case base = "base"
        case date = "date"
        case rates = "rates"
    }

}
