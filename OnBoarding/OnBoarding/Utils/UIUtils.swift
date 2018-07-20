//
//  UIUtils.swift
//  OnBoarding
//
//  Created by Roy Quesada on 7/19/18.
//  Copyright © 2018 Roy Quesada. All rights reserved.
//

import UIKit


class UIUtils: NSObject {
    struct GlobalConstants {
        // Constant define here.
        static let MainColor: UIColor = UIColor(red: 42.0/255.0, green: 163.0/255.0, blue: 239.0/255.0, alpha: 1.0)
        static let MainFontColor: UIColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        static let DisableColor: UIColor = UIColor(red: 155.0/255.0, green: 203.0/255.0, blue: 232.0/255.0, alpha: 1.0)
    }

}

extension NSMutableAttributedString {
    
    public func setAsLink(textToFind:String, linkURL:String) -> Bool {
        
        let foundRange = self.mutableString.range(of: textToFind)
        if foundRange.location != NSNotFound {
            self.addAttribute(.link, value: linkURL, range: foundRange)
            return true
        }
        return false
    }
}
