//
//  CurrencyTableViewCell.swift
//  CryptoTrends
//
//  Created by S@nchit on 26/09/17.
//  Copyright © 2017 S@nchit. All rights reserved.
//

import UIKit

class CurrencyTableViewCell: UITableViewCell {

    @IBOutlet weak var currencyDescription: UILabel!
    @IBOutlet weak var currencyTitle: UILabel!
    @IBOutlet weak var currencyImage: UIImageView!
    @IBOutlet weak var overlappinglabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
        // Initialization code
    }
    
    func commonInit(){
        currencyImage.layer.cornerRadius = currencyImage.frame.size.height/2
        currencyDescription.numberOfLines = 0
        currencyTitle.numberOfLines = 0
    }
    
    func bindData(currency : CryptoCurrency){
        currencyTitle.text = currency.name
        currencyDescription.attributedText = fillCurrencyDescription(currency: currency)
        bindImage(name: currency.name)
    }
    
    func fillCurrencyDescription(currency:CryptoCurrency) -> NSMutableAttributedString{
        let currencyDescription = "Price : \(currency.priceUsd!) (\(currency.percentChangedLast1Hr!))%\n\(currency.symbol!)"
        
        //Font
        
        let attributedString = NSMutableAttributedString.init(string: currencyDescription)
        attributedString.addAttribute(NSAttributedStringKey.font, value: UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.medium), range: NSRange.init(location: 0, length: 6))
        attributedString.addAttribute(NSAttributedStringKey.font, value: UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.medium), range: NSRange.init(location: 8, length: currency.priceUsd!.count))
        attributedString.addAttribute(NSAttributedStringKey.font, value: UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.medium), range: NSRange.init(location: 8+currency.priceUsd!.count+1, length: currency.percentChangedLast1Hr!.count+3))
        
        //Color
        
        let lastHrPriceChange = currency.percentChangedLast1Hr!
        if String(lastHrPriceChange.prefix(upTo: lastHrPriceChange.index(lastHrPriceChange.startIndex, offsetBy: 1))) == "-"{
             attributedString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.init(red: 200/255, green: 81/255, blue: 56/255, alpha: 1.0), range: NSRange.init(location: 8+currency.priceUsd!.count+1, length: currency.percentChangedLast1Hr!.count+3))//red color
        }else{
             attributedString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.init(red: 84/255, green: 167/255, blue: 65/255, alpha: 1.0), range: NSRange.init(location: 8+currency.priceUsd!.count+1, length: currency.percentChangedLast1Hr!.count+3))//Green color
        }
        
        return attributedString
    }
    
    func bindImage(name : String?){
        currencyImage.image = nil
        overlappinglabel.text = ""
        if let image = UIImage.init(named: name!){
            currencyImage.image = image
        }else{
            setTextForOverlappingLabel(inputString: name!)
        }
    }
    
    func setTextForOverlappingLabel(inputString : String){
        let text = inputString.prefix(upTo: (inputString.index(inputString.startIndex, offsetBy: 1)))
        overlappinglabel.text = String.init(describing: text)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
