//
//  CongratsViewController.swift
//  OnBoarding
//
//  Created by Roy Quesada on 7/25/18.
//  Copyright © 2018 Roy Quesada. All rights reserved.
//

import UIKit

class CongratsViewController: OBBaseViewController {

    @IBOutlet weak var continueButton: ConfirmButton!
    override func viewDidLoad() {
        super.viewDidLoad()

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
