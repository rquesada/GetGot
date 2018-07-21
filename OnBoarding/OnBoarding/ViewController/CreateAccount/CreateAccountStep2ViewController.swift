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
    
    var isUsingPhone:Bool!
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

    @IBAction func editHandler(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signupHandler(_ sender: Any) {
        if self.isUsingPhone{
            self.sentVerifyCode()
        }else{
            self.performSegue(withIdentifier: "passwordSegue2", sender: nil)
        }
    }
    
    
    func sentVerifyCode(){
        let message  = "We'll text your verification code to \(self.phone!). Standart SMS fees may apply."
        let alert = UIAlertController(title: "Verify Phone", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Edit", style: UIAlertActionStyle.default, handler: { action in
            self.dismiss(animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { action in
            self.performSegue(withIdentifier: "enterCodeSegue", sender: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func backHandler(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nav = segue.destination as? UINavigationController,
            let webVC = nav.topViewController as? WebViewController{
            webVC.openURL = self.openURL
        }else if let enterCodeVC = segue.destination as? EnterCodeViewController{
                enterCodeVC.phone = self.phone
        }
    }
    
    // MARK : - UITextViewDelegate
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        if URL.absoluteString == "https://PP"{
            debugPrint("Open privacy options")
            self.performSegue(withIdentifier: "privacySegue", sender: nil)
        }else{
            self.openURL = URL
            self.performSegue(withIdentifier: "openURLSegue", sender: nil)
        }
        return false
    }
}
