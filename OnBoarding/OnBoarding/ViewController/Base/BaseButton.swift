//
//  BaseButton.swift
//  OnBoarding
//
//  Created by Roy Quesada on 8/20/18.
//  Copyright © 2018 Roy Quesada. All rights reserved.
//

import UIKit

class BaseButton: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

class ConfirmButton: BaseButton{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    // For storyboard
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    // For programatically
    convenience init(frame: CGRect, image: UIImage) {
        self.init(frame: frame)
        configure()
    }
    
    func configure(){
        self.backgroundColor = Config.GlobalConstants.MainColor
        self.layer.cornerRadius = 24
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.clear.cgColor
    }
}
