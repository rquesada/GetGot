//
//  WantResetAccountViewController.swift
//  OnBoarding
//
//  Created by Roy Quesada on 7/23/18.
//  Copyright © 2018 Roy Quesada. All rights reserved.
//

import UIKit

class WantResetAccountViewController: UIViewController {

    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var option1Switch: UISwitch!
    @IBOutlet weak var option2Switch: UISwitch!
    var changeByCode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.continueButton.backgroundColor = UIUtils.GlobalConstants.MainColor
        self.continueButton.layer.cornerRadius = 24
        self.continueButton.layer.borderWidth = 2
        self.continueButton.layer.borderColor = UIColor.clear.cgColor
        
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.bordered, target: self, action: #selector(backHandler))
        self.navigationItem.leftBarButtonItem = newBackButton

    }
    @IBAction func dontAccessHandler(_ sender: Any) {
        self.performSegue(withIdentifier: "webSegue", sender: nil)
    }
    
    @IBAction func continueHandler(_ sender: Any) {
    }
    
    @objc func backHandler(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func option2Change(_ sender: Any) {
        self.option1Switch.isOn = !self.option1Switch.isOn
    }
    
    
    @IBAction func option1Change(_ sender: Any) {
        self.option2Switch.isOn = !self.option2Switch.isOn
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nav = segue.destination as? UINavigationController,
            let webVC = nav.topViewController as? WebViewController{
            webVC.title = "Reset Password"
            webVC.openURL = URL(string: "https://help.twitter.com/forms/signin")  
        }
    }

}
