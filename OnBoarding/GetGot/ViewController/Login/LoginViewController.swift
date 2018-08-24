//
//  LoginViewController.swift
//  OnBoarding
//
//  Created by Roy Quesada on 7/20/18.
//  Copyright © 2018 Roy Quesada. All rights reserved.
//

import UIKit

class LoginViewController: OBBaseViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var showPasswordButton: UIButton!
    @IBOutlet weak var brandIcon: UIImageView!
    
    var loginButton: UIBarButtonItem!
    var flexibleSpace: UIBarButtonItem!
    var forgotPasswordButton: UIBarButtonItem!
    var toolbar: UIToolbar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.brandIcon.image = Config.sharedInstance.appIcon
        let customButton = UIButton()
        customButton.frame = CGRect(x:0, y:0, width:60, height:25)
        customButton.setTitle("Log in", for: .normal)
        customButton.backgroundColor = Config.GlobalConstants.MainColor
        customButton.layer.cornerRadius = 18.0
        customButton.setTitleColor(Config.GlobalConstants.DisableColor, for: UIControlState.disabled)
        customButton.setTitleColor(Config.GlobalConstants.MainFontColor, for: UIControlState.normal)
        customButton.addTarget(self, action: #selector(loginHandler), for: .touchUpInside)
        self.loginButton = UIBarButtonItem(customView: customButton)
        self.loginButton.isEnabled = false
        
        self.forgotPasswordButton = UIBarButtonItem(title: "Forgot pasword?", style: UIBarButtonItemStyle.plain, target: self, action:
            #selector(forgotHandler))
        self.flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        
        let frame = CGRect(x: 0.0, y: 0.0, width: 375, height: 50)
        self.toolbar = UIToolbar(frame: frame)
        self.toolbar.barStyle = UIBarStyle.default
        self.toolbar.items = [self.forgotPasswordButton, self.flexibleSpace, self.loginButton]
        self.toolbar.sizeToFit()
        self.usernameTextField.inputAccessoryView = toolbar
        self.passwordTextField.inputAccessoryView = toolbar
        
        self.usernameTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        self.passwordTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if self.passwordTextField.text != "" && self.usernameTextField.text != ""{
            self.loginButton.isEnabled = true
        }else{
            self.loginButton.isEnabled = false
        }
    }
    
    @objc func loginHandler(){
        if self.usernameTextField.text == "12345678"{
            self.showLoginError()
        }else{
            debugPrint("Go to Main page")
        }
    }
    
    @objc func forgotHandler(){
        self.performSegue(withIdentifier: "findAccountSegue", sender: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.usernameTextField.becomeFirstResponder()
    }

    @IBAction func backHandler(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func revealPasswordHandler(_ sender: Any) {
        self.passwordTextField.isSecureTextEntry = !self.passwordTextField.isSecureTextEntry
    }
    
    func showLoginError(){
        let message  = "We found more than one account with that phone number. Please try again with your username or email."
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
