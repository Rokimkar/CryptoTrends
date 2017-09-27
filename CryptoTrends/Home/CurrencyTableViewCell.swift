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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func bindData(currency : CryptoCurrency){
        currencyTitle.text = currency.name
        currencyDescription.text = currency.priceUsd
        currencyVolume.text = currency.availableSupply
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
