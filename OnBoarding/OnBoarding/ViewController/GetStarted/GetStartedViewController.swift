//
//  GetStartedViewController.swift
//  OnBoarding
//
//  Created by Roy Quesada on 7/19/18.
//  Copyright © 2018 Roy Quesada. All rights reserved.
//

import UIKit

class GetStartedViewController: UIViewController {

    @IBOutlet weak var getStartedButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.getStartedButton.backgroundColor = UIUtils.GlobalConstants.MainColor
        self.getStartedButton.layer.cornerRadius = 24
        self.getStartedButton.layer.borderWidth = 2
        self.getStartedButton.layer.borderColor = UIColor.clear.cgColor
    }

    @IBAction func loginHandler(_ sender: Any) {
        debugPrint("Show Login")
        
    }
    
    @IBAction func getStartedHandler(_ sender: Any) {
        debugPrint("Create your account")
        self.performSegue(withIdentifier: "createAccountSegue", sender: nil)
    }
    

}
