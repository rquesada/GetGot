//
//  ViewController.swift
//  OnBoarding
//
//  Created by Roy Quesada on 7/19/18.
//  Copyright © 2018 Roy Quesada. All rights reserved.
//

import UIKit

class ViewController: OBBaseViewController {
    
    @IBOutlet weak var menuRightConstraint: NSLayoutConstraint!
    @IBOutlet weak var menuLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var slideMenuView: UIView!
    
    var vm:MainViewModel?
    var menuIsVisible = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.vm = MainViewModel()
        self.checkLatestVersion()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.showNavigationBar()
    }
    
    @IBAction func logoutHandler(_ sender: Any) {
        self.showLogin()
    }
    
    
    @IBAction func profileHandler(_ sender: Any) {
        self.performSegue(withIdentifier: "profileSegue", sender: nil)
    }
    
    @IBAction func showMenuHandler(_ sender: Any) {
        self.menuLeftConstraint.constant = menuIsVisible ? -240 : 0
        menuIsVisible = !menuIsVisible
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    func showLogin(){
        //Show GetStarted
        let storyboard = UIStoryboard(name: "GetStarted", bundle: nil)
        let controller: GetStartedViewController = storyboard.instantiateViewController(withIdentifier: "GetStartedID") as! GetStartedViewController
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func isLogin() -> Bool{
        //ToDo: Implement Funcionality
        return true
    }
    
    func checkLatestVersion(){
        self.vm?.isLastestVersion(completion: { isUpdated in
            if isUpdated{
                if !self.isLogin(){
                    self.showLogin()
                }
            }else{
                let errorVC = ErrorHandler.errorAlertController(message: "GetGot requiere an update")
                self.present(errorVC, animated: true, completion: nil)
            }
        })
    }
}

