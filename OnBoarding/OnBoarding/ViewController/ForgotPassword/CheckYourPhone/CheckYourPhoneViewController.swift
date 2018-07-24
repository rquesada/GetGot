//
//  CheckYourPhoneViewController.swift
//  OnBoarding
//
//  Created by Roy Quesada on 7/23/18.
//  Copyright © 2018 Roy Quesada. All rights reserved.
//

import UIKit

class CheckYourPhoneViewController: UIViewController {

    @IBOutlet weak var codeTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.submitButton.backgroundColor = UIUtils.GlobalConstants.MainColor
        self.submitButton.layer.cornerRadius = 24
        self.submitButton.layer.borderWidth = 2
        self.submitButton.layer.borderColor = UIColor.clear.cgColor
        
        self.codeTextField.layer.borderWidth = 0.5
        self.codeTextField.layer.cornerRadius = 5
        self.codeTextField.layer.borderColor = UIColor.lightGray.cgColor

        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.bordered, target: self, action: #selector(backHandler))
        self.navigationItem.leftBarButtonItem = newBackButton
        self.title = "Reset Password"
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
