//
//  ErrorHandler.swift
//  GetGot
//
//  Created by Roy Quesada on 9/10/18.
//  Copyright © 2018 Roy Quesada. All rights reserved.
//

import UIKit

class ErrorHandler: NSObject {
    
    class func errorAlertController(message: String) -> UIViewController {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        return alert
    }
}
