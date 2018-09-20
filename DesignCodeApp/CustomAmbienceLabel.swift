//
//  CustomAmbienceLabel.swift
//  DesignCodeApp
//
//  Created by fanzhang on 9/20/18.
//  Copyright © 2018 Meng To. All rights reserved.
//

import UIKit
import Ambience

class CustomAmbienceLabel: UILabel {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func ambience(_ notification: Notification) {
        
        super.ambience(notification)
        
        guard let currentState = notification.userInfo?["currentState"] as? AmbienceState else { return }
        
        if Ambience.forcedState == nil {
            text = "Auto"
        } else {
            switch currentState {
            case .contrast: text = ""
            case .invert: text = "Dark Mode"
            case .regular: text = "Off"
            }
        }
    }

}
