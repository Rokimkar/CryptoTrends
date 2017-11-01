//
//  GenericFunctions.swift
//  CryptoTrends
//
//  Created by S@nchit on 01/10/17.
//  Copyright © 2017 S@nchit. All rights reserved.
//

import UIKit

class GenericFunctions: NSObject {
    static let kOneDay = 3600
    
    class func suffixNumber (inputNumber : Any) -> String {
        var number = 0.0
        if inputNumber is String{
            number = Double(inputNumber as! String) ?? 0
        }
        let sign = ((number < 0) ? "-" : "" )
        if (number < 1000.0){
            return "\(sign)\(number)";
        }
        let exp:Int = Int(log10(number) / 3.0 )
        let units:[String] = ["K","M","B","T","P","E"]
        let roundedNum:Double = round(10 * number / pow(1000.0,Double(exp))) / 10
        return "\(sign)\(roundedNum)\(units[exp-1])"
    }
    
    class func getTimeDifferenceFromNow(time:String) -> String{
        let lastUpdatedDate = Date.init(timeIntervalSince1970: Double(time)!)
        let timeDiffernce = -(Int((lastUpdatedDate.timeIntervalSinceNow)))
        var timeDifferceString = ""
        if timeDiffernce < 60{
            timeDifferceString = "\(timeDiffernce) seconds ago"
        }else if timeDiffernce/3600 >= 1{
            timeDifferceString = "\(timeDiffernce/GenericFunctions.kOneDay) hours ago"
        }else{
            timeDifferceString = "\(timeDiffernce/60) minutes ago"
        }
        return timeDifferceString
    }
    
    class func getFormattedCommaSeperatedNumber(input : String) -> String{
        let formatter = NumberFormatter.init()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        let number = Float(input)
        var result = input
        if result.first != "0"{
            result = formatter.string(from: NSNumber.init(value: number!))!
        }
        return result
        
    }
    
    class func searchKeyword(dataArray : [CryptoCurrency],keyword : String) -> [CryptoCurrency]{
        var resultArray : [CryptoCurrency] = []
        for currency : CryptoCurrency in dataArray{
            if RabinKarpSearch.search(text: currency.name ?? "", pattern: keyword) != -1{
                resultArray.append(currency)
            }else if RabinKarpSearch.search(text: currency.symbol ?? "", pattern: keyword) != -1{
                resultArray.append(currency)
            }
        }
        return resultArray
    }
}
