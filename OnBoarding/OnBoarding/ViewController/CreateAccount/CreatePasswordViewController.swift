//
//  CreatePasswordViewController.swift
//  OnBoarding
//
//  Created by Roy Quesada on 7/20/18.
//  Copyright © 2018 Roy Quesada. All rights reserved.
//

import UIKit

class CreatePasswordViewController: UIViewController {

    @IBOutlet weak var revealPassword: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var checkImage: UIImageView!
    var toolbar: UIToolbar!
    var nextButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let customButton = UIButton()
        customButton.frame = CGRect(x:0, y:0, width:60, height:25)
        customButton.setTitle("Next", for: .normal)
        customButton.backgroundColor = UIUtils.GlobalConstants.MainColor
        customButton.layer.cornerRadius = 18.0
        customButton.setTitleColor(UIUtils.GlobalConstants.DisableColor, for: UIControlState.disabled)
        customButton.setTitleColor(UIUtils.GlobalConstants.MainFontColor, for: UIControlState.normal)
        customButton.addTarget(self, action: #selector(nextHandler), for: .touchUpInside)
        self.nextButton = UIBarButtonItem(customView: customButton)
        self.nextButton.isEnabled = false
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let frame = CGRect(x: 0.0, y: 0.0, width: 375, height: 50)
        self.toolbar = UIToolbar(frame: frame)
        self.toolbar.barStyle = UIBarStyle.default
        self.toolbar.items = [flexibleSpace,self.nextButton]
        self.toolbar.sizeToFit()
        self.passwordTextField.inputAccessoryView = self.toolbar
        self.passwordTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.passwordTextField.becomeFirstResponder()
    }
    
    @objc func nextHandler(){
        debugPrint("Next")
    }

    @IBAction func revealPasswordHandler(_ sender: Any) {
        self.passwordTextField.isSecureTextEntry = !self.passwordTextField.isSecureTextEntry
        let buttonTitle = self.passwordTextField.isSecureTextEntry ? "Reveal password" : "Hide password"
        self.revealPassword.setTitle(buttonTitle, for: UIControlState.normal)
    }
    
    @IBAction func backHandler(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        self.nextButton.isEnabled = false
        self.errorLabel.isHidden = true
        self.checkImage.isHidden =  true
        
        self.revealPassword.isHidden = textField.text == "" ? true : false
        if let pass = textField.text, pass.count > 5{
            self.checkPassword(password: pass)
        }
    }
    
    func checkPassword(password:String){
        if password == "123456"{
            self.errorLabel.isHidden = false
        }else{
            self.nextButton.isEnabled = true
            self.errorLabel.isHidden = true
            self.checkImage.isHidden =  false
        }
    }
}
