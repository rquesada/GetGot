//
//  ResetPasswordViewController.swift
//  OnBoarding
//
//  Created by Roy Quesada on 7/24/18.
//  Copyright © 2018 Roy Quesada. All rights reserved.
//

import UIKit

class ResetPasswordViewController: UIViewController {

    @IBOutlet weak var password1TextField: UITextField!
    @IBOutlet weak var password2TextField: UITextField!
    @IBOutlet weak var rememberSwitch: UISwitch!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var error1Label: UILabel!
    @IBOutlet weak var error2Label: UILabel!
    
    var doneButton: UIBarButtonItem!
    var flexibleSpace: UIBarButtonItem!
    var toolbar: UIToolbar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.submitButton.backgroundColor = UIUtils.GlobalConstants.MainColor
        self.submitButton.layer.cornerRadius = 24
        self.submitButton.layer.borderWidth = 2
        self.submitButton.layer.borderColor = UIColor.clear.cgColor
        
        self.password1TextField.layer.borderWidth = 0.5
        self.password1TextField.layer.cornerRadius = 5
        self.password1TextField.layer.borderColor = UIColor.lightGray.cgColor
        
        self.password2TextField.layer.borderWidth = 0.5
        self.password2TextField.layer.cornerRadius = 5
        self.password2TextField.layer.borderColor = UIColor.lightGray.cgColor
        
        let customButton = UIButton()
        customButton.frame = CGRect(x:0, y:0, width:60, height:25)
        customButton.setTitle("Done", for: .normal)
        customButton.backgroundColor = UIUtils.GlobalConstants.MainColor
        customButton.layer.cornerRadius = 18.0
        customButton.setTitleColor(UIUtils.GlobalConstants.DisableColor, for: UIControlState.disabled)
        customButton.setTitleColor(UIUtils.GlobalConstants.MainFontColor, for: UIControlState.normal)
        customButton.addTarget(self, action: #selector(doneHandler), for: .touchUpInside)
        self.doneButton = UIBarButtonItem(customView: customButton)
        
        self.flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        
        let frame = CGRect(x: 0.0, y: 0.0, width: 375, height: 50)
        self.toolbar = UIToolbar(frame: frame)
        self.toolbar.barStyle = UIBarStyle.default
        self.toolbar.items = [self.flexibleSpace, self.doneButton]
        self.toolbar.sizeToFit()
        self.password1TextField.inputAccessoryView = toolbar
        self.password2TextField.inputAccessoryView = toolbar
        
        self.password1TextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        self.password2TextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.password1TextField.becomeFirstResponder()
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if textField == self.password1TextField{
            if let text = self.password1TextField.text{
                if text.count < 6{
                    self.showErrorL1(msg: "Too short", isError: true)
                }else if text.count >= 6 && text.count < 10{
                    self.showErrorL1(msg: "Weak", isError: true)
                }else{
                    self.showErrorL1(msg: "Very strong", isError: false)
                }
            }
        }else if textField == self.password2TextField{
            if let text = self.password2TextField.text{
                if text != self.password1TextField.text{
                    self.showErrorL2(msg: "Passwords do not match.", isError: true)
                }
            }
        }
    }

    @objc func doneHandler(){
        if self.password1TextField.text == ""{
            self.showErrorL1(msg: "Please, insert a new password.", isError: true)
        }
        if (self.password1TextField.text != "") && (self.password1TextField.text != self.password2TextField.text){
            self.showErrorL2(msg: "Passwords do not match.", isError: true)
        }
    }
    
    func showErrorL1(msg:String, isError:Bool){
        self.password1TextField.layer.borderColor = isError ? UIColor.red.cgColor : UIColor.lightGray.cgColor
        self.error1Label.textColor = isError ? UIColor.red : UIColor.green
        self.error1Label.text = msg
        self.error1Label.isHidden = false
    }
    
    func showErrorL2(msg:String, isError:Bool){
        self.password2TextField.layer.borderColor = isError ? UIColor.red.cgColor : UIColor.lightGray.cgColor
        self.error2Label.textColor = isError ? UIColor.red : UIColor.green
        self.error2Label.text = msg
        self.error2Label.isHidden = false
    }
   
    @IBAction func submitHandler(_ sender: Any) {
    }
    
    @IBAction func rememberChange(_ sender: Any) {
    }
}
