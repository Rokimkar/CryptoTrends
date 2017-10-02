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
    }
    
    func dataForIndexPath(indexPath : IndexPath) -> String{
        var data = ""
        if let currency = self.cryptoCurrency{
            switch indexPath.row {
            case 0:
                data = currency.name!
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
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height = 0.0
        switch indexPath.row {
        case 0:
            height = 100
            break
        default:
            break
        }
        return CGFloat(height)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyDetailTableViewCell", for: indexPath) as! CurrencyDetailTableViewCell
        cell.bindData(indexpath: indexPath, data: self.dataForIndexPath(indexPath: indexPath))
        return cell
    }
}
