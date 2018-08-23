//
//  ResetPasswordViewController.swift
//  OnBoarding
//
//  Created by Roy Quesada on 7/24/18.
//  Copyright © 2018 Roy Quesada. All rights reserved.
//

import UIKit

class ResetPasswordViewController: OBBaseViewController, UITextFieldDelegate {

    @IBOutlet weak var password1TextField: UITextField!
    @IBOutlet weak var password2TextField: UITextField!
    @IBOutlet weak var rememberSwitch: UISwitch!
    @IBOutlet weak var submitButton: ConfirmButton!
    @IBOutlet weak var error1Label: UILabel!
    @IBOutlet weak var error2Label: UILabel!
    
    var doneButton: UIBarButtonItem!
    var flexibleSpace: UIBarButtonItem!
    var toolbar: UIToolbar!
    var upButtonItem: UIBarButtonItem!
    var downButtonItem: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        self.password1TextField.layer.borderWidth = 0.5
        self.password1TextField.layer.cornerRadius = 5
        self.password1TextField.layer.borderColor = UIColor.lightGray.cgColor
        
        self.password2TextField.layer.borderWidth = 0.5
        self.password2TextField.layer.cornerRadius = 5
        self.password2TextField.layer.borderColor = UIColor.lightGray.cgColor
        
        let customButton = UIButton()
        customButton.frame = CGRect(x:0, y:0, width:60, height:25)
        customButton.setTitle("Done", for: .normal)
        customButton.backgroundColor = Config.GlobalConstants.MainColor
        customButton.layer.cornerRadius = 18.0
        customButton.setTitleColor(Config.GlobalConstants.DisableColor, for: UIControlState.disabled)
        customButton.setTitleColor(Config.GlobalConstants.MainFontColor, for: UIControlState.normal)
        customButton.addTarget(self, action: #selector(doneHandler), for: .touchUpInside)
        self.doneButton = UIBarButtonItem(customView: customButton)
        
        let upButton = UIButton()
        upButton.frame = CGRect(x: 0, y: 0, width: 30, height: 25)
        upButton.setTitle("▲", for: .normal)
        upButton.setTitleColor(UIColor.lightGray, for: UIControlState.disabled)
        upButton.setTitleColor(Config.GlobalConstants.MainColor, for: UIControlState.normal)
        upButton.addTarget(self, action: #selector(upHandler), for: .touchUpInside)
        self.upButtonItem = UIBarButtonItem(customView: upButton)
        self.upButtonItem.isEnabled = false
        
        let downButton = UIButton()
        downButton.frame = CGRect(x: 0, y: 0, width: 30, height: 25)
        downButton.setTitle("▼", for: .normal)
        downButton.setTitleColor(UIColor.lightGray, for: UIControlState.disabled)
        downButton.setTitleColor(Config.GlobalConstants.MainColor, for: UIControlState.normal)
        downButton.addTarget(self, action: #selector(downHandler), for: .touchUpInside)
        self.downButtonItem = UIBarButtonItem(customView: downButton)
        self.downButtonItem.isEnabled = true
        
        self.flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        
        let frame = CGRect(x: 0.0, y: 0.0, width: 375, height: 50)
        self.toolbar = UIToolbar(frame: frame)
        self.toolbar.barStyle = UIBarStyle.default
        self.toolbar.items = [self.upButtonItem,self.downButtonItem,self.flexibleSpace, self.doneButton]
        self.toolbar.sizeToFit()
        self.password1TextField.inputAccessoryView = toolbar
        self.password2TextField.inputAccessoryView = toolbar
        
        self.password1TextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        self.password2TextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.bordered, target: self, action: #selector(backHandler))
        self.navigationItem.leftBarButtonItem = newBackButton
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.password1TextField.becomeFirstResponder()
    }
    
    @objc func backHandler(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        self.showErrorL1(msg: "", isError: false)
        self.showErrorL2(msg: "", isError: false)
        
        
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
        
        self.password1TextField.resignFirstResponder()
        self.password2TextField.resignFirstResponder()
    }
    
    @objc func upHandler(){
        self.password1TextField.becomeFirstResponder()
    }
    
    @objc func downHandler(){
        self.password2TextField.becomeFirstResponder()
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
        
        
        if let txtString = self.password1TextField.text{
            
            var haveError = false
            if txtString == ""{
                self.showErrorL1(msg: "Please, insert a new password.", isError: true)
                haveError = true
            }
            
            if txtString != ""{
                if txtString.count < 6{
                    self.showErrorL1(msg: "Too short", isError: true)
                    haveError = true
                }else if txtString.count >= 6 && txtString.count < 10{
                    self.showErrorL1(msg: "Weak", isError: true)
                }else{
                    self.showErrorL1(msg: "Very strong", isError: false)
                }
            }
            
            if (txtString != "") && (txtString != self.password2TextField.text){
                self.showErrorL2(msg: "Passwords do not match.", isError: true)
                haveError = true
            }
            
            if !haveError {
                self.performSegue(withIdentifier: "congratsSegue", sender: nil)
            }
            
        }
        
        
        
    }
    
    @IBAction func rememberChange(_ sender: Any) {
        debugPrint("Remember me")
    }
    
    // MARK: - UITextFieldDelegate
    @objc func textFieldDidBeginEditing(_ textField: UITextField) {
        self.downButtonItem.isEnabled = (textField == self.password1TextField) ? true : false
        self.upButtonItem.isEnabled = (textField == self.password1TextField) ? false : true
    }
}
