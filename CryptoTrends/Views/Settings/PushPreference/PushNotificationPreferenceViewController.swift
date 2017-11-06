//
//  PushNotificationPreferenceViewController.swift
//  CryptoTrends
//
//  Created by S@nchit on 06/11/17.
//  Copyright © 2017 S@nchit. All rights reserved.
//

import UIKit
import MoEngage_iOS_SDK

class PushNotificationPreferenceViewController: UIViewController {

    @IBOutlet weak var dataTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }
    
    func commonInit(){
        dataTable.dataSource = self
        dataTable.delegate = self
        self.title = "Push Preference"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension PushNotificationPreferenceViewController : UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = UITableViewCell.init()
        cell.textLabel?.text = getTextForIndexpath(indexPath: indexPath)
        cell.textLabel?.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.regular)
        return cell
    }
    
    func getTextForIndexpath(indexPath  :IndexPath) -> String{
        var text = ""
        switch indexPath.row {
        case 0:
            text = "Daily"
            break
        case 1:
            text = "Weekly"
            break
        case 2:
            text = "Monthly"
            break
        case 3:
            text = "Occasionaly"
            break
        case 4:
            text = "Never"
            break
        default:
            break
        }
        return text
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        MoEngage.sharedInstance().setUserAttribute(cell?.detailTextLabel?.text!, forKey: "PushPreference")
        self.navigationController?.popViewController(animated: true)
    }
    
}
