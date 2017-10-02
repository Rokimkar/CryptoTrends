//
//  CurrencyDetailViewController.swift
//  CryptoTrends
//
//  Created by S@nchit on 30/09/17.
//  Copyright © 2017 S@nchit. All rights reserved.
//

import UIKit

class CurrencyDetailViewController: UIViewController {
    
    @IBOutlet weak var cryptoCurrencyDetailTableView: UITableView!
    
    var cryptoCurrency : CryptoCurrency?
    override func viewDidLoad() {
        super.viewDidLoad()
        commoninit()
        self.title = cryptoCurrency?.name
        // Do any additional setup after loading the view.
    }
    
    func commoninit(){
        self.cryptoCurrencyDetailTableView.dataSource = self
        self.cryptoCurrencyDetailTableView.delegate = self
        self.cryptoCurrencyDetailTableView.register(UINib.init(nibName: "CurrencyDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "CurrencyDetailTableViewCell")
        self.cryptoCurrencyDetailTableView.separatorStyle = .none
    }
    
    func dataForIndexPath(indexPath : IndexPath) -> NSMutableAttributedString{
        let data = NSMutableAttributedString.init()
        var dataString = ""
        if let currency = self.cryptoCurrency{
            switch indexPath.row {
            case 0:
                dataString = currency.name!
                data.setAttributedString(NSAttributedString.init(string: dataString))
                break
            case 1:
                dataString = "Symbol : \(currency.symbol!)"
                data.setAttributedString(NSAttributedString.init(string: dataString))
                data.addAttribute(NSAttributedStringKey.font, value: UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.light), range: NSRange.init(location: 0, length: String(dataString.prefix(upTo: dataString.index(of: ":")!)).count))
                break
            default:
                break
            }
        }
        return data
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension CurrencyDetailViewController : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height = 30.0
        switch indexPath.row {
        case 0:
            height = 70
            break
        default:
            break
        }
        return CGFloat(height)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyDetailTableViewCell", for: indexPath) as! CurrencyDetailTableViewCell
        cell.bindData(indexpath: indexPath, data: self.dataForIndexPath(indexPath: indexPath))
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        return cell
    }
}
