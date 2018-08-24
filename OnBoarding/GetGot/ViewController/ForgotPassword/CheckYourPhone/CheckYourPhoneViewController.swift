//
//  CheckYourPhoneViewController.swift
//  OnBoarding
//
//  Created by Roy Quesada on 7/23/18.
//  Copyright © 2018 Roy Quesada. All rights reserved.
//

import UIKit

class CheckYourPhoneViewController: OBBaseViewController {

    @IBOutlet weak var codeTextField: UITextField!
    @IBOutlet weak var submitButton: ConfirmButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    var doneButton: UIBarButtonItem!
    var flexibleSpace: UIBarButtonItem!
    var toolbar: UIToolbar!
    var upButtonItem: UIBarButtonItem!
    var downButtonItem: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.codeTextField.layer.borderWidth = 0.5
        self.codeTextField.layer.cornerRadius = 5
        self.codeTextField.layer.borderColor = UIColor.lightGray.cgColor
        
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
        self.downButtonItem.isEnabled = false
        
        self.flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        
        let frame = CGRect(x: 0.0, y: 0.0, width: 375, height: 50)
        self.toolbar = UIToolbar(frame: frame)
        self.toolbar.barStyle = UIBarStyle.default
        self.toolbar.items = [self.upButtonItem,self.downButtonItem ,self.flexibleSpace, self.doneButton]
        self.toolbar.sizeToFit()
        self.codeTextField.inputAccessoryView = toolbar

        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.bordered, target: self, action: #selector(backHandler))
        self.navigationItem.leftBarButtonItem = newBackButton
        self.title = "Reset Password"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.codeTextField.becomeFirstResponder()
    }
    
    @objc func upHandler(){
        debugPrint("Up")
    }
    
    @objc func downHandler(){
        debugPrint("Down")
    }
    
    @objc func doneHandler(){
        self.codeTextField.resignFirstResponder()
    }

    @objc func backHandler(){
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func submitHandler(_ sender: Any) {
        self.codeTextField.layer.borderColor = UIColor.lightGray.cgColor
        self.errorLabel.isHidden = true
        
        let textCode = self.codeTextField.text
        
        if textCode == "" {
            self.codeTextField.layer.borderColor = UIColor.red.cgColor
        }else if self.codeTextField.text == "12345678"{
            self.codeTextField.layer.borderColor = UIColor.red.cgColor
            self.errorLabel.isHidden = false
        }else{
            self.performSegue(withIdentifier: "resetSegue", sender: nil)
        }
    }
    
    func showError(isError:Bool){
        self.codeTextField.layer.borderColor = isError ? UIColor.red.cgColor : UIColor.lightGray.cgColor
    }
    
    @IBAction func dintReceive(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
}
