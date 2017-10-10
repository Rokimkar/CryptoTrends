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
        animateTextInLabelWithText(text: data)
    }
    
    func animateTextInLabelWithText(text : NSAttributedString){
        let transition = CATransition.init()
        transition.duration = 0.75
        transition.type = kCATransitionMoveIn
        transition.subtype = kCATransitionFromBottom
        transition.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseInEaseOut)
        self.detailLabel.layer.add(transition, forKey: "changeTextTransition")
        detailLabel.attributedText = text
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
