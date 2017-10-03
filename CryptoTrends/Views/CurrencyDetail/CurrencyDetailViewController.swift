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
    
    func setNavigationTitleWithAnimation(isSet : Bool){
        if isSet == true{
                self.title = self.cryptoCurrency?.name
        }else {
                self.title = ""
        }
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
                data.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.init(red: 38/255, green: 23/255, blue: 161/255, alpha: 1), range: NSRange.init(location: String(dataString.prefix(upTo: dataString.index(of: ":")!)).count, length: String(dataString.suffix(from: dataString.index(of: ":")!)).count))
                break
            case 2:
                dataString = "Rank : \(currency.rank!)"
                data.setAttributedString(NSAttributedString.init(string: dataString))
                data.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.init(red: 38/255, green: 23/255, blue: 161/255, alpha: 1), range: NSRange.init(location: String(dataString.prefix(upTo: dataString.index(of: ":")!)).count, length: String(dataString.suffix(from: dataString.index(of: ":")!)).count))
                break
            case 3:
                dataString = "Price : \(currency.priceUsd!)"
                data.setAttributedString(NSAttributedString.init(string: dataString))
                data.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.init(red: 38/255, green: 23/255, blue: 161/255, alpha: 1), range: NSRange.init(location: String(dataString.prefix(upTo: dataString.index(of: ":")!)).count, length: String(dataString.suffix(from: dataString.index(of: ":")!)).count))
                break
            case 4:
                dataString = "Price(BTC) : \(currency.priceBTC!)"
                data.setAttributedString(NSAttributedString.init(string: dataString))
                data.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.init(red: 38/255, green: 23/255, blue: 161/255, alpha: 1), range: NSRange.init(location: String(dataString.prefix(upTo: dataString.index(of: ":")!)).count, length: String(dataString.suffix(from: dataString.index(of: ":")!)).count))
                break
            case 5:
                let lastHrPriceChange = currency.percentChangedLast1Hr!
                dataString = "Last hour change : \(lastHrPriceChange)%"
                data.setAttributedString(NSAttributedString.init(string: dataString))
                
                if String(lastHrPriceChange.prefix(upTo: lastHrPriceChange.index(lastHrPriceChange.startIndex, offsetBy: 1))) == "-"{
                    data.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.init(red: 200/255, green: 81/255, blue: 56/255, alpha: 1.0), range: NSRange.init(location: String(dataString.prefix(upTo: dataString.index(of: ":")!)).count, length: String(dataString.suffix(from: dataString.index(of: ":")!)).count))//red color
                }else{
                    data.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.init(red: 84/255, green: 167/255, blue: 65/255, alpha: 1.0), range: NSRange.init(location: String(dataString.prefix(upTo: dataString.index(of: ":")!)).count, length: String(dataString.suffix(from: dataString.index(of: ":")!)).count))//Green color
                }
                break
            case 6:
                let lastDayPriceChange = currency.percentChangedLast24Hr!
                dataString = "Last day change : \(lastDayPriceChange)%"
                data.setAttributedString(NSAttributedString.init(string: dataString))
                
                if String(lastDayPriceChange.prefix(upTo: lastDayPriceChange.index(lastDayPriceChange.startIndex, offsetBy: 1))) == "-"{
                    data.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.init(red: 200/255, green: 81/255, blue: 56/255, alpha: 1.0), range: NSRange.init(location: String(dataString.prefix(upTo: dataString.index(of: ":")!)).count, length: String(dataString.suffix(from: dataString.index(of: ":")!)).count))//red color
                }else{
                    data.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.init(red: 84/255, green: 167/255, blue: 65/255, alpha: 1.0), range: NSRange.init(location: String(dataString.prefix(upTo: dataString.index(of: ":")!)).count, length: String(dataString.suffix(from: dataString.index(of: ":")!)).count))//Green color
                }
                break
            case 7:
                let lastWeekPriceChange = currency.percentChangedLast7Days!
                dataString = "Last week change : \(lastWeekPriceChange)%"
                data.setAttributedString(NSAttributedString.init(string: dataString))
                
                if String(lastWeekPriceChange.prefix(upTo: lastWeekPriceChange.index(lastWeekPriceChange.startIndex, offsetBy: 1))) == "-"{
                    data.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.init(red: 200/255, green: 81/255, blue: 56/255, alpha: 1.0), range: NSRange.init(location: String(dataString.prefix(upTo: dataString.index(of: ":")!)).count, length: String(dataString.suffix(from: dataString.index(of: ":")!)).count))//red color
                }else{
                    data.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.init(red: 84/255, green: 167/255, blue: 65/255, alpha: 1.0), range: NSRange.init(location: String(dataString.prefix(upTo: dataString.index(of: ":")!)).count, length: String(dataString.suffix(from: dataString.index(of: ":")!)).count))//Green color
                }
                break
            case 8:
                dataString = "Supply : \(currency.totalSupply!)"
                data.setAttributedString(NSAttributedString.init(string: dataString))
                data.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.init(red: 38/255, green: 23/255, blue: 161/255, alpha: 1), range: NSRange.init(location: String(dataString.prefix(upTo: dataString.index(of: ":")!)).count, length: String(dataString.suffix(from: dataString.index(of: ":")!)).count))
                break
            case 9:
                dataString = "Volume(24 hours) : \(currency.volumeUsedLast24HrUSD!)"
                data.setAttributedString(NSAttributedString.init(string: dataString))
                data.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.init(red: 38/255, green: 23/255, blue: 161/255, alpha: 1), range: NSRange.init(location: String(dataString.prefix(upTo: dataString.index(of: ":")!)).count, length: String(dataString.suffix(from: dataString.index(of: ":")!)).count))
                break
            default:
                break
            }
        }
        data.addAttribute(NSAttributedStringKey.font, value: UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.medium), range: NSRange.init(location: 0, length: dataString.count))
        return data
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension CurrencyDetailViewController : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > -20{
            setNavigationTitleWithAnimation(isSet: true)
        }else{
            setNavigationTitleWithAnimation(isSet: false)
        }
    }
}
