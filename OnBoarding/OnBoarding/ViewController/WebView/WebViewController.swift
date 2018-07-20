//
//  WebViewController.swift
//  OnBoarding
//
//  Created by Roy Quesada on 7/20/18.
//  Copyright © 2018 Roy Quesada. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {
    
    var openURL:URL!

    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.webView.loadRequest(URLRequest(url: openURL))
    }
    
    @IBAction func backHandler(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
