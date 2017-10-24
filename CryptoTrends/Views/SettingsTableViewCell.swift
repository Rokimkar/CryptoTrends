//
//  SettingsTableViewCell.swift
//  CryptoTrends
//
//  Created by S@nchit on 21/10/17.
//  Copyright © 2017 S@nchit. All rights reserved.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {

    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.descriptionLabel.numberOfLines = 0
        // Initialization code
    }
    
    func bind(data : [String:Any]){
        var title = ""
        var description = ""
        if let _ = data["title"],data["title"] is String{
            title = data["title"] as! String
        }
        
        if let _ = data["description"],data["description"] is String{
            description = data["description"] as! String
        }
        
        let labelText = NSMutableAttributedString.init(string: title+"\n"+description)
        labelText.addAttribute(NSAttributedStringKey.font, value: UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.bold), range: NSRange.init(location: 0, length: title.count))
        labelText.addAttribute(NSAttributedStringKey.font, value: UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.medium), range: NSRange.init(location: title.count+1, length: description.count))
        descriptionLabel.attributedText = labelText
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
