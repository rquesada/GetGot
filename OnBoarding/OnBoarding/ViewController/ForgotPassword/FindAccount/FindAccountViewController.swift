//
//  FincAccountViewController.swift
//  OnBoarding
//
//  Created by Roy Quesada on 7/23/18.
//  Copyright © 2018 Roy Quesada. All rights reserved.
//

import UIKit

class FindAccountViewController: OBBaseViewController {
    
    @IBOutlet weak var moreInfoLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var searchButton: ConfirmButton!
    
    var doneButton: UIBarButtonItem!
    var flexibleSpace: UIBarButtonItem!
    var toolbar: UIToolbar!
    var upButtonItem: UIBarButtonItem!
    var downButtonItem: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.usernameTextField.layer.borderWidth = 0.5
        self.usernameTextField.layer.cornerRadius = 5
        self.usernameTextField.layer.borderColor = UIColor.lightGray.cgColor
        
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
        self.usernameTextField.inputAccessoryView = toolbar
        
        self.usernameTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.usernameTextField.becomeFirstResponder()
    }
    
    @objc func upHandler(){
        debugPrint("Up")
    }
    
    @objc func downHandler(){
        debugPrint("Down")
    }
    
    @objc func doneHandler(){
        self.usernameTextField.resignFirstResponder()
    }

    @IBAction func backHandler(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func searchHandler(_ sender: Any) {
        self.showMoreInfoError(isError: false)
        
        if self.usernameTextField.text == "12345678"{
            self.showError(isError:true)
        }else if self.usernameTextField.text == ""{
            self.showMoreInfoError(isError: true)
        }else{
            self.performSegue(withIdentifier: "wantResetSegue", sender: nil)
        }
    }
    
    func showError(isError:Bool){
        self.errorLabel.isHidden = isError ? false : true
        self.titleLabel.isHidden = isError ? true : false
    }
    
    func showMoreInfoError(isError:Bool){
        self.moreInfoLabel.isHidden = isError ? false : true
        self.usernameTextField.layer.borderWidth = 0.5
        self.usernameTextField.layer.cornerRadius = 5
        self.usernameTextField.layer.borderColor = isError ? UIColor.red.cgColor : UIColor.lightGray.cgColor
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        showError(isError: false)
    }
}
