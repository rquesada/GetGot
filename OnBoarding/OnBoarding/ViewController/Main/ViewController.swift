//
//  ViewController.swift
//  OnBoarding
//
//  Created by Roy Quesada on 7/19/18.
//  Copyright © 2018 Roy Quesada. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if !isLogin(){
            //Show GetStarted
            let storyboard = UIStoryboard(name: "GetStarted", bundle: nil)
            let controller: GetStartedViewController = storyboard.instantiateViewController(withIdentifier: "GetStartedID") as! GetStartedViewController
            self.present(controller, animated: true, completion: nil)
        }
    }

    func isLogin() -> Bool{
        //ToDo: Implement Funcionality
        return false
    }
}

