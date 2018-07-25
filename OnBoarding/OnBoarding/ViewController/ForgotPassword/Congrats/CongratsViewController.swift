//
//  CongratsViewController.swift
//  OnBoarding
//
//  Created by Roy Quesada on 7/25/18.
//  Copyright © 2018 Roy Quesada. All rights reserved.
//

import UIKit

class CongratsViewController: UIViewController {

    @IBOutlet weak var continueButton: UIButton!
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

    @IBAction func continueHandler(_ sender: Any) {
        debugPrint("Continue")
    }
    
    @objc func backHandler(){
        self.dismiss(animated: true, completion: nil)
    }
    
}
