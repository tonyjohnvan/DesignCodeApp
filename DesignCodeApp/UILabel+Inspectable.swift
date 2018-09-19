//
//  UILabel+Inspectable.swift
//  DesignCodeApp
//
//  Created by Fan Zhang on 9/18/18.
//  Copyright © 2018 Meng To. All rights reserved.
//

import UIKit

extension UILabel {
    
    @IBInspectable var shadowOffSetY: CGFloat {
        set { layer.shadowOffset.height = newValue}
        get {return layer.shadowOffset.height}
    }
    @IBInspectable var shadowRadius: CGFloat {
        set { layer.shadowRadius = newValue }
        get { return layer.shadowRadius }
    }
    @IBInspectable var shadowOpacity: CGFloat {
        set { layer.shadowOpacity = Float(newValue) }
        get { return CGFloat(layer.shadowOpacity) }
    }
    
}
