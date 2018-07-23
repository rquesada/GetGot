//
//  FincAccountViewController.swift
//  OnBoarding
//
//  Created by Roy Quesada on 7/23/18.
//  Copyright © 2018 Roy Quesada. All rights reserved.
//

import UIKit

class FindAccountViewController: UIViewController {
    
    @IBOutlet weak var moreInfoLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    var doneButton: UIBarButtonItem!
    var flexibleSpace: UIBarButtonItem!
    var toolbar: UIToolbar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchButton.backgroundColor = UIUtils.GlobalConstants.MainColor
        self.searchButton.layer.cornerRadius = 24
        self.searchButton.layer.borderWidth = 2
        self.searchButton.layer.borderColor = UIColor.clear.cgColor
        
        self.usernameTextField.layer.borderWidth = 0.5
        self.usernameTextField.layer.cornerRadius = 5
        self.usernameTextField.layer.borderColor = UIColor.lightGray.cgColor
        
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
        self.usernameTextField.inputAccessoryView = toolbar
        
        self.usernameTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.usernameTextField.becomeFirstResponder()
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
