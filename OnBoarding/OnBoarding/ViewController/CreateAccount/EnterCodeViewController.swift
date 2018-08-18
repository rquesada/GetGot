//
//  EnterCodeViewController.swift
//  OnBoarding
//
//  Created by Roy Quesada on 7/20/18.
//  Copyright © 2018 Roy Quesada. All rights reserved.
//

import UIKit

class EnterCodeViewController: OBBaseViewController, UITextFieldDelegate {

    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var brandIcon: UIImageView!
    @IBOutlet weak var codeTextField: UITextField!
    
    var toolbar: UIToolbar!
    var nextButton: UIBarButtonItem!
    var phone:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.brandIcon.image = Config.sharedInstance.appIcon
        let customButton = UIButton()
        customButton.frame = CGRect(x:0, y:0, width:60, height:25)
        customButton.setTitle("Next", for: .normal)
        customButton.backgroundColor = Config.GlobalConstants.MainColor
        customButton.layer.cornerRadius = 18.0
        customButton.setTitleColor(Config.GlobalConstants.DisableColor, for: UIControlState.disabled)
        customButton.setTitleColor(Config.GlobalConstants.MainFontColor, for: UIControlState.normal)
        customButton.addTarget(self, action: #selector(nextHandler), for: .touchUpInside)
        self.nextButton = UIBarButtonItem(customView: customButton)
        self.nextButton.isEnabled = false
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let frame = CGRect(x: 0.0, y: 0.0, width: 375, height: 50)
        self.toolbar = UIToolbar(frame: frame)
        self.toolbar.barStyle = UIBarStyle.default
        self.toolbar.items = [flexibleSpace,self.nextButton]
        self.toolbar.sizeToFit()
        self.codeTextField.inputAccessoryView = self.toolbar
        self.codeTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.subTitleLabel.text = "Enter it below to verify \(phone!)"
        self.codeTextField.becomeFirstResponder()
    }
    @objc func nextHandler(){
        if self.codeTextField.text == "1234"{
            self.showErrorMessage()
        }else{
            debugPrint("Go to Password")
            self.performSegue(withIdentifier: "passwordSegue", sender: nil)
        }
    }
    
    func showErrorMessage(){
        let message  = "The code enter is invalid. Try Again."
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    @IBAction func backHandler(_ sender: Any) {
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didReceiveHandler(_ sender: UIBarButtonItem) {
        let optionMenu = UIAlertController(title: nil, message: "Didn't receive SMS?", preferredStyle: .actionSheet)
        let deleteAction = UIAlertAction(title: "Resend SMS", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            //TODO: Add animation
            debugPrint("Resend")
        })
        let saveAction = UIAlertAction(title: "Use email instead", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            debugPrint("use email")
            //TODO: set correctly the email focus
            self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            debugPrint("Cancel")
        })
        
        optionMenu.addAction(deleteAction)
        optionMenu.addAction(saveAction)
        optionMenu.addAction(cancelAction)
        
        if let popoverController = optionMenu.popoverPresentationController{
            popoverController.sourceView = self.view
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        self.present(optionMenu, animated: true, completion: nil)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        self.nextButton.isEnabled = textField.text != "" ? true : false
    }
}
