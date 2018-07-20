//
//  CreateAccountStep2ViewController.swift
//  OnBoarding
//
//  Created by Roy Quesada on 7/20/18.
//  Copyright © 2018 Roy Quesada. All rights reserved.
//

import UIKit

class CreateAccountStep2ViewController: UIViewController, UITextViewDelegate {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var privacyPoliceTextView: UITextView!
    @IBOutlet weak var signUpButton: UIButton!
    
    var name:String!
    var phone:String!
    var openURL:URL!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.signUpButton.backgroundColor = UIUtils.GlobalConstants.MainColor
        self.signUpButton.layer.cornerRadius = 24
        self.signUpButton.layer.borderWidth = 2
        self.signUpButton.layer.borderColor = UIColor.clear.cgColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.nameTextField.text = self.name
        self.phoneTextField.text = self.phone
        
        let attributedString = NSMutableAttributedString(string:"By signing up, you agree to the Terms of Service and Privacy Policy, including Cookie Use. Others will be able to find you by email or phone number when provided.  Privacy Options")
        _ = attributedString.setAsLink(textToFind: "Terms of Service", linkURL: "https://twitter.com/en/tos")
        _ = attributedString.setAsLink(textToFind: "Privacy Policy", linkURL: "https://twitter.com/en/privacy")
        _ = attributedString.setAsLink(textToFind: "Cookie Use", linkURL: "https://help.twitter.com/en/rules-and-policies/twitter-cookies")
        _ = attributedString.setAsLink(textToFind: "Privacy Options", linkURL: "https://PP")
        
        self.privacyPoliceTextView.attributedText = attributedString
    }

   
    @IBAction func backHandler(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nav = segue.destination as? UINavigationController,
            let webVC = nav.topViewController as? WebViewController{
            webVC.openURL = self.openURL
        }
    }
    
    // MARK : - UITextViewDelegate
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        if URL.absoluteString == "https://PP"{
            debugPrint("Open privacy options")
        }else{
            self.openURL = URL
            self.performSegue(withIdentifier: "openURLSegue", sender: nil)
        }
        return false
    }

}
