//
//  RabinKarpSearch.swift
//  CryptoTrends
//
//  Created by S@nchit on 31/10/17.
//  Copyright © 2017 S@nchit. All rights reserved.
//

import UIKit

struct Constants {
    static let hashMultiplier = 69069
}

precedencegroup PowerPrecedence { higherThan: MultiplicationPrecedence }
infix operator ** : PowerPrecedence
func ** (radix: Int, power: Int) -> Int {
    return Int(pow(Double(radix), Double(power)))
}
func ** (radix: Double, power: Int) -> Double {
    return pow(radix, Double(power))
}

class RabinKarpSearch: NSObject {
    // Rabin karp method
    // Find first position of pattern in the text using Rabin Karp algorithm
    class func search(text: String, pattern: String) -> Int {
        // convert to array of ints
        let textSmall = text.lowercased()
        let patternSmall = pattern.lowercased()
        let patternArray = patternSmall.characters.flatMap { $0.asInt }
        let textArray = textSmall.characters.flatMap { $0.asInt }
        
        if textArray.count <= patternArray.count{
            if pattern == text{
                return 1
            }
            return -1
        }
        
        let patternHash = hash(array: patternArray)
        var endIdx = patternArray.count - 1
        let firstChars = Array(textArray[0...endIdx])
        let firstHash = hash(array: firstChars)
        
        if patternHash == firstHash {
            // Verify this was not a hash collison
            if firstChars == patternArray {
                return 0
            }
        }
        
        var prevHash = firstHash
        // Now slide the window across the text to be searched
        for idx in 1...(textArray.count - patternArray.count) {
            endIdx = idx + (patternArray.count - 1)
            let window = Array(textArray[idx...endIdx])
            let windowHash = nextHash(
                prevHash: prevHash,
                dropped: textArray[idx - 1],
                added: textArray[endIdx],
                patternSize: patternArray.count - 1
            )
            
            if windowHash == patternHash {
                if patternArray == window {
                    return idx
                }
            }
            
            prevHash = windowHash
        }
        
        return -1
    }
    
    private class func hash(array: Array<Int>) -> Double {
        var total: Double = 0
        var exponent = array.count - 1
        for i in array {
            total += Double(i) * (Double(Constants.hashMultiplier) ** exponent)
            exponent -= 1
        }
        
        return Double(total)
    }
    
    private class func nextHash(prevHash: Double, dropped: Int, added: Int, patternSize: Int) -> Double {
        let oldHash = prevHash - (Double(dropped) *
            (Double(Constants.hashMultiplier) ** patternSize))
        return Double(Constants.hashMultiplier) * oldHash + Double(added)
    }
}

extension Character {
    var asInt: Int {
        let s = String(self).unicodeScalars
        return Int(s[s.startIndex].value)
    }
}
