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
        self.currencyTableView.separatorStyle = .none
        self.view.backgroundColor = UIColor.clear
        self.currencyTableView.backgroundColor = UIColor.init(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.8)
        self.title = "CryptoTrends"
        setUpNavigationBar()
    }
    
    func setUpNavigationBar(){
        self.navigationController?.navigationBar.barTintColor = UIColor.init(red: 125/255, green: 21/255, blue: 24/255, alpha: 0.4)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
        //self.navigationController?.navigationBar.isTranslucent = false
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
        cell.selectionStyle = .none
        cell.bindData(currency: dataArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currencyDetailVC = CurrencyDetailViewController.init(nibName: "CurrencyDetailViewController", bundle: nil)
        currencyDetailVC.cryptoCurrency = self.dataArray[indexPath.row]
        self.navigationController?.pushViewController(currencyDetailVC, animated: true)
    }
}

