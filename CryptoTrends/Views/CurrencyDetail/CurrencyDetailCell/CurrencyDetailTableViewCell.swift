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
        commontInit()
        // Initialization code
    }
    
    func commontInit(){
        self.backgroundColor = UIColor.clear
        self.detailLabel.backgroundColor = UIColor.clear
    }
    
    func bindData(indexpath : IndexPath,data : NSMutableAttributedString){
        detailLabel.attributedText = data
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
