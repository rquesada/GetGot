//
//  PrivacyOptionsTableViewController.swift
//  OnBoarding
//
//  Created by Roy Quesada on 7/20/18.
//  Copyright © 2018 Roy Quesada. All rights reserved.
//

import UIKit

class PrivacyOptionsTableViewController: UITableViewController {

    @IBOutlet weak var emailSwitch: UISwitch!
    @IBOutlet weak var phoneSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.emailSwitch.isOn = UserDefaults.standard.bool(forKey: "emailPrivacy")
        self.phoneSwitch.isOn = UserDefaults.standard.bool(forKey: "phonePrivacy")
    }

    @IBAction func switchChangeHandler(_ sender: Any) {
        let switchButton = sender as! UISwitch
        if switchButton == self.emailSwitch{
            UserDefaults.standard.set(switchButton.isOn, forKey: "emailPrivacy")
        }else{
            UserDefaults.standard.set(switchButton.isOn, forKey: "phonePrivacy")
        }
    }
    
    @IBAction func doneHandler(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
