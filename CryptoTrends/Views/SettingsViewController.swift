//
//  SettingsViewController.swift
//  CryptoTrends
//
//  Created by S@nchit on 21/10/17.
//  Copyright © 2017 S@nchit. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    var settingsDataArray : Array<[String : Any]>?
    var pickerView : UIPickerView?
    @IBOutlet weak var settingsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commontInit()
    }
    
    func commontInit(){
        self.settingsTableView.dataSource = self
        self.settingsTableView.delegate = self
        self.settingsTableView.register(UINib.init(nibName: "SettingsTableViewCell", bundle: nil), forCellReuseIdentifier: "SettingsTableViewCell")
        getDataForTable()
    }
    
    func getDataForTable(){
        let path  = Bundle.main.path(forResource: "SettingsItem", ofType: "plist")
        let dataArray = NSArray.init(contentsOf: URL.init(fileURLWithPath: path!)) as? [[String : Any]]
        settingsDataArray = dataArray
        settingsTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension SettingsViewController : UITableViewDataSource,UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int{
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let _ = self.settingsDataArray{
            return self.settingsDataArray!.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsTableViewCell", for: indexPath) as! SettingsTableViewCell
        cell.bind(data: self.settingsDataArray![indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            if self.pickerView == nil{
                self.pickerView = UIPickerView.init(frame: CGRect.init(x: 0, y: self.view.frame.size.height-300, width: self.view.frame.size.width, height: 300))
                self.pickerView?.dataSource = self
                self.pickerView?.delegate = self
                self.pickerView?.backgroundColor = UIColor.lightGray
                self.pickerView?.showsSelectionIndicator = true
                let toolBar = UIToolbar.init(frame: CGRect.init(x: 0, y: (self.pickerView?.frame.origin.y)!-50, width: self.view.frame.size.width, height: 50))
                toolBar.items = [UIBarButtonItem.init(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(donePressed))]
                toolBar.isUserInteractionEnabled = true
                self.view.addSubview(toolBar)
                self.view.addSubview(self.pickerView!)
            }else{
                self.view.sendSubview(toBack: self.settingsTableView)
            }
        }
    }
    
    @objc func donePressed(){
        self.view.bringSubview(toFront: self.settingsTableView)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}

extension SettingsViewController : UIPickerViewDataSource,UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return SettingsManager.currencySymbolsArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return SettingsManager.currencySymbolsArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        SettingsManager.sharedInstance.updateSelectedCurrency(updatedCurrency: CurrencyCode(rawValue: SettingsManager.currencySymbolsArray[row])!) { (isUpdated) in
            if isUpdated == true{
                
            }else{
                // error occured alert
            }
        }
    }
}

