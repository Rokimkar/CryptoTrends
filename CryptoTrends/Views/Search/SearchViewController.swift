//
//  SearchViewController.swift
//  CryptoTrends
//
//  Created by S@nchit on 01/11/17.
//  Copyright © 2017 S@nchit. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchResultTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var searchResults : [CryptoCurrency] = []
    var dataArray : [CryptoCurrency] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    func commonInit(){
        self.searchBar.delegate = self
        self.searchResultTableView.register(UINib.init(nibName: "CurrencyTableViewCell", bundle: nil), forCellReuseIdentifier: "CurrencyTableViewCell")
        self.searchResultTableView.dataSource = self
        self.searchResultTableView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension SearchViewController : UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //Perform search
        searchResults = GenericFunctions.searchKeyword(dataArray: dataArray, keyword: searchText)
        searchResultTableView.reloadData()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        //
    }
    
}

extension SearchViewController : UITableViewDataSource,UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyTableViewCell", for: indexPath) as! CurrencyTableViewCell
        cell.bindData(currency: searchResults[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currencyDetailVC = CurrencyDetailViewController.init(nibName: "CurrencyDetailViewController", bundle: nil)
        currencyDetailVC.previousFetchedCryptoCurrency = (tableView.cellForRow(at: indexPath) as! CurrencyTableViewCell).currency!
        self.navigationController?.pushViewController(currencyDetailVC, animated: true)
    }
}
