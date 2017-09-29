//
//  CurrencyTableViewCell.swift
//  CryptoTrends
//
//  Created by S@nchit on 26/09/17.
//  Copyright © 2017 S@nchit. All rights reserved.
//

import UIKit

class CurrencyTableViewCell: UITableViewCell {

    @IBOutlet weak var currencyVolume: UILabel!
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
    }
    
    func bindData(currency : CryptoCurrency){
        currencyTitle.text = currency.name
        currencyDescription.text = currency.priceUsd
        currencyVolume.text = currency.availableSupply
        bindImage(name: currency.name)
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
