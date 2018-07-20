//
//  CreateAccountViewController.swift
//  OnBoarding
//
//  Created by Roy Quesada on 7/19/18.
//  Copyright © 2018 Roy Quesada. All rights reserved.
//

import UIKit

class CreateAccountViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var nameImageCheck: UIImageView!
    @IBOutlet weak var phoneImageCheck: UIImageView!
    
    @IBOutlet weak var errorLabel: UILabel!
    var nextButton: UIBarButtonItem!
    var flexibleSpace: UIBarButtonItem!
    var switchButton: UIBarButtonItem!
    var toolbar: UIToolbar!
    var phoneTextStatus:String = ""
    
    var isValidName = false
    var isValidPhone = false
    
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
        
        self.switchButton = UIBarButtonItem(title: "Use email instead", style: UIBarButtonItemStyle.plain, target: self, action:
            #selector(CreateAccountViewController.switchHandler))
        self.flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let frame = CGRect(x: 0.0, y: 0.0, width: 375, height: 50)
        self.toolbar = UIToolbar(frame: frame)
        self.toolbar.barStyle = UIBarStyle.default
        self.toolbar.items = [ self.flexibleSpace, self.nextButton]
        self.toolbar.sizeToFit()
        self.nameTextField.inputAccessoryView = toolbar
        self.phoneTextField.inputAccessoryView = toolbar
        
        self.nameTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        self.phoneTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.nameTextField.becomeFirstResponder()
    }
    
    @IBAction func cancelHandler(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func nextHandler(){
        if self.nameTextField.isFirstResponder{
            if self.isValidPhone{
                debugPrint("Check with server")
            }else{
                self.phoneTextField.becomeFirstResponder()
            }
        }else{
            if self.isValidName{
                debugPrint("Check with server")
            }else{
                self.nameTextField.becomeFirstResponder()
            }
        }
    }
    
    @objc func switchHandler(){
        self.phoneTextField.text = ""
        self.errorLabel.isHidden = true
        self.swithToPhone(usePhone: !(self.phoneTextStatus == "phone"))
        self.phoneTextField.resignFirstResponder()
        self.phoneTextField.becomeFirstResponder()
    }
    
    // MARK: - UITextFieldDelegate
    @objc func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == self.nameTextField{
            self.errorLabel.isHidden = true
            self.toolbar.items = [ self.flexibleSpace, self.nextButton]
        }else if textField == self.phoneTextField{
            self.toolbar.items = [self.switchButton,self.flexibleSpace, self.nextButton]
            if self.phoneTextStatus == "" || self.phoneTextStatus == "phone"{
                self.checkPhone()
                self.swithToPhone(usePhone: true)
            }else if self.phoneTextStatus == "email"{
                self.swithToPhone(usePhone: false)
            }
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if textField == self.nameTextField{
            let isEmptyName = (textField.text?.trimmingCharacters(in: .whitespaces).isEmpty)!
            self.isValidName = isEmptyName ? false : true
            self.checkNextButtonEnable()
        }else{
            self.errorLabel.isHidden = true
            if self.phoneTextStatus == "" || self.phoneTextStatus == "phone"{
                self.checkPhone()
            }else{//Email
                self.checkEmail()
            }
        }
    }
    
    //MARK: - Validate Phone
    func checkPhone(){
        let error = self.validatePhoneNumber(phoneNumber: self.phoneTextField.text)
        if error == ""{
            self.isValidPhone = true
            self.checkNextButtonEnable()
        }else if error == nil{
            self.isValidPhone = false
            self.checkNextButtonEnable()
        }else{
            self.errorLabel.text = error!
            self.errorLabel.isHidden = false
            self.isValidPhone = false
            self.checkNextButtonEnable()
        }
    }
    
    //TODO: Verify is this validation can be improve
    func validatePhoneNumber(phoneNumber:String?) -> String?{
        if let phone = phoneNumber{
            if phone.count < 8{
                return nil
            }else if phone.count > 8{
                return "Please, insert a valid phone number"
            }else if phone == "12345678"{
                return "Phone has already been taken"
            }else{
                return ""
            }
        }else{
            return nil
        }
    }
    
    //MARK: - Validate Email
    func checkEmail(){
        if let email = self.phoneTextField.text{
            if self.isValidEmail(testStr: email) {
                if email != "roy@123.com"{
                    self.isValidPhone = true
                    self.checkNextButtonEnable()
                    return
                }else{
                    self.errorLabel.text = "Email has already been taken"
                    self.errorLabel.isHidden = false
                }
            }
        }
        self.isValidPhone = false
        self.checkNextButtonEnable()
    }
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    //MARK: -
    func checkNextButtonEnable(){
        if self.nameTextField.isFirstResponder{
            self.nextButton.isEnabled = isValidName ? true : false
            self.nameImageCheck.isHidden = isValidName ? false : true
        }else{
            self.nextButton.isEnabled = isValidPhone ? true : false
            self.phoneImageCheck.isHidden = isValidPhone ? false : true
        }
    }
    
    
    
    func swithToPhone(usePhone:Bool){
        self.phoneTextField.placeholder = usePhone ? "Phone" : "Email"
        self.phoneTextField.keyboardType = usePhone ? UIKeyboardType.phonePad : UIKeyboardType.emailAddress
        self.switchButton.title = usePhone ? "Use email instead" : "Use phone instead"
        self.phoneTextStatus = usePhone ? "phone" : "email"
    }
}
