//
//  CurrencyDetailTableViewCell.swift
//  CryptoTrends
//
//  Created by S@nchit on 02/10/17.
//  Copyright © 2017 S@nchit. All rights reserved.
//

import UIKit

class CurrencyDetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var detailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func bindData(indexpath : IndexPath,data : NSMutableAttributedString){
        detailLabel.attributedText = data
        switch indexpath.row {
        case 0:
            detailLabel.font = UIFont.systemFont(ofSize: 40, weight: UIFont.Weight.bold)
            break
        default:
            //detailLabel.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.bold)
            break
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
