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
    
    static func customNextButton( target: Any?, action: Selector) -> UIBarButtonItem{
        let baseButton = BaseButton()
        baseButton.frame = CGRect(x:0, y:0, width:60, height:25)
        baseButton.setTitle("Next", for: .normal)
        baseButton.backgroundColor = Config.GlobalConstants.MainColor
        baseButton.layer.cornerRadius = 18.0
        baseButton.setTitleColor(Config.GlobalConstants.DisableColor, for: UIControlState.disabled)
        baseButton.setTitleColor(Config.GlobalConstants.MainFontColor, for: UIControlState.normal)
        baseButton.addTarget(target, action: action, for: .touchUpInside)
        return UIBarButtonItem(customView: baseButton)
    }

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
