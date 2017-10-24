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
    @IBOutlet weak var cellBackgroundView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
        // Initialization code
    }
    
    func commonInit(){
        currencyImage.layer.cornerRadius = currencyImage.frame.size.height/2
        currencyDescription.numberOfLines = 0
        currencyTitle.numberOfLines = 0
        self.backgroundColor = UIColor.clear
        cellBackgroundView.layer.cornerRadius = 5
        self.currencyImage.layer.shadowColor = UIColor.black.cgColor
        self.currencyImage.layer.shadowRadius = CGFloat(5.0)
        self.currencyImage.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.currencyImage.layer.shadowOpacity = 1
        self.currencyImage.clipsToBounds = false
    }
    
    func bindData(currency : CryptoCurrency){
        currencyTitle.attributedText = fillCurrencyTitle(currency: currency)
        currencyDescription.attributedText = fillCurrencyDescription(currency: currency)
        bindImage(name: currency.name)
    }
    
    func fillCurrencyTitle(currency : CryptoCurrency) -> NSMutableAttributedString{
        let currencyTitleText = "\(currency.name!) (\(currency.symbol!))"
        let attributedString = NSMutableAttributedString.init(string: currencyTitleText)
        
        //Font
        
        attributedString.addAttribute(NSAttributedStringKey.font, value: UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.bold), range: NSRange.init(location: 0, length: currency.name!.count))
        
        attributedString.addAttribute(NSAttributedStringKey.font, value: UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium), range: NSRange.init(location: currency.name!.count+1, length: currency.symbol!.count+2))
        
        //Color
        
        attributedString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.darkGray, range: NSRange.init(location: currency.name!.count+1, length: currency.symbol!.count+2))
        return attributedString
    }
    
    func fillCurrencyDescription(currency:CryptoCurrency) -> NSMutableAttributedString{
        let priceTag = "Price : \(SettingsManager.sharedInstance.getConvertedCurrencyStringFromUSD(to: SettingsManager.sharedInstance.getSelectedCurrency(), value: currency.priceUsd!))"
        let availableSupplyTag = "Available Supply : "
        let lastUpdatedTag = "Last updated \(GenericFunctions.getTimeDifferenceFromNow(time: currency.lastUpdated!))"
        let availableSupplySuffix = GenericFunctions.suffixNumber(inputNumber: currency.availableSupply!)
        let currencyDescription = "\(priceTag) (\(currency.percentChangedLast1Hr!)%)\n\(availableSupplyTag)\(availableSupplySuffix)\n\(lastUpdatedTag)"
        
        //Font
        
        let attributedString = NSMutableAttributedString.init(string: currencyDescription)
        attributedString.addAttribute(NSAttributedStringKey.font, value: UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.medium), range: NSRange.init(location: 0, length: priceTag.count))
       // attributedString.addAttribute(NSAttributedStringKey.font, value: UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.medium), range: NSRange.init(location: priceTag.count, length: currency.priceUsd!.count))
        attributedString.addAttribute(NSAttributedStringKey.font, value: UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.medium), range: NSRange.init(location: priceTag.count+1, length: currency.percentChangedLast1Hr!.count+3))
        attributedString.addAttribute(NSAttributedStringKey.font, value: UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.medium), range: NSRange.init(location: priceTag.count+5+currency.percentChangedLast1Hr!.count, length: availableSupplyTag.count+availableSupplySuffix.count))
        attributedString.addAttribute(NSAttributedStringKey.font, value: UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.light), range: NSRange.init(location: currencyDescription.count - lastUpdatedTag.count, length: lastUpdatedTag.count))
        
        //Color
        
        let lastHrPriceChange = currency.percentChangedLast1Hr!
        if String(lastHrPriceChange.prefix(upTo: lastHrPriceChange.index(lastHrPriceChange.startIndex, offsetBy: 1))) == "-"{
             attributedString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.init(red: 200/255, green: 81/255, blue: 56/255, alpha: 1.0), range: NSRange.init(location: priceTag.count+1, length: currency.percentChangedLast1Hr!.count+3))//red color
        }else{
             attributedString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.init(red: 84/255, green: 167/255, blue: 65/255, alpha: 1.0), range: NSRange.init(location: priceTag.count+1, length: currency.percentChangedLast1Hr!.count+3))//Green color
        }
        attributedString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.darkGray, range: NSRange.init(location: currencyDescription.count - lastUpdatedTag.count, length: lastUpdatedTag.count))
        attributedString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.init(red: 38/255, green: 23/255, blue: 161/255, alpha: 1), range: NSRange.init(location: priceTag.count-(currency.priceUsd!.count+2), length: currency.priceUsd!.count+2))
        attributedString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.init(red: 38/255, green: 23/255, blue: 161/255, alpha: 1), range: NSRange.init(location: priceTag.count+currency.percentChangedLast1Hr!.count+3+availableSupplyTag.count, length: currency.availableSupply!.count))
        
        //Paragraph
        
        let paragraphAttributeLineSpacing = NSMutableParagraphStyle.init()
        paragraphAttributeLineSpacing.lineSpacing = 10
        attributedString.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphAttributeLineSpacing, range: NSRange.init(location: priceTag.count+5+currency.percentChangedLast1Hr!.count, length: currencyDescription.count-(priceTag.count+5+currency.percentChangedLast1Hr!.count)))
        let paragraphAttributeRightAlignment = NSMutableParagraphStyle.init()
        paragraphAttributeRightAlignment.alignment = .right
        attributedString.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphAttributeRightAlignment, range: NSRange.init(location: currencyDescription.count - lastUpdatedTag.count, length: lastUpdatedTag.count))
        
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
