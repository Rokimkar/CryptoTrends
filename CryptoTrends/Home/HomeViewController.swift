//
//  ViewController.swift
//  CryptoTrends
//
//  Created by S@nchit on 24/09/17.
//  Copyright © 2017 S@nchit. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    var dataArray : [CryptoCurrency] = []
    @IBOutlet weak var currencyTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        var thing = "Car"
//        let closure = {
//            print(thing)
//        }
//        thing = "Aeroplane"
//        closure()
        commonInit()
        DataManager.sharedInstance.getDataForAppendingParameters(parameters: []) { (data) in
            self.dataArray = data
            self.currencyTableView.reloadData()
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func commonInit(){
        self.currencyTableView.dataSource = self
        self.currencyTableView.delegate = self
        self.currencyTableView.register(UINib.init(nibName: "CurrencyTableViewCell", bundle: nil), forCellReuseIdentifier: "CurrencyTableViewCell")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension HomeViewController : UITableViewDataSource,UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyTableViewCell", for: indexPath) as! CurrencyTableViewCell
        cell.bindData(currency: dataArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
    }
}

