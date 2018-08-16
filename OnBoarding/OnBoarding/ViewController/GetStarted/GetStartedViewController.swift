//
//  GetStartedViewController.swift
//  OnBoarding
//
//  Created by Roy Quesada on 7/19/18.
//  Copyright © 2018 Roy Quesada. All rights reserved.
//83183007/sebas1234

import UIKit

class GetStartedViewController: OBBaseViewController {

    @IBOutlet weak var brandIcon: UIImageView!
    @IBOutlet weak var getStartedButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.getStartedButton.backgroundColor = Config.GlobalConstants.MainColor
        self.getStartedButton.layer.cornerRadius = 24
        self.getStartedButton.layer.borderWidth = 2
        self.getStartedButton.layer.borderColor = UIColor.clear.cgColor
        
        self.brandIcon.image  = Config.sharedInstance.appIcon
    }

    @IBAction func loginHandler(_ sender: Any) {
        //Show GetStarted
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "loginID") as! LoginViewController
        self.present(controller, animated: true, completion: nil)
        
    }
    
    @IBAction func getStartedHandler(_ sender: Any) {
        debugPrint("Create your account")
        self.performSegue(withIdentifier: "createAccountSegue", sender: nil)
    }
    

}
