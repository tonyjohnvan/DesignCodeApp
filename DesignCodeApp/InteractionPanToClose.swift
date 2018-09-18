//
//  InteractionPanToClose.swift
//  DesignCodeApp
//
//  Created by Fan Zhang on 9/18/18.
//  Copyright © 2018 Meng To. All rights reserved.
//

import UIKit

class InteractionPanToClose: UIPercentDrivenInteractiveTransition {
    @IBOutlet weak var viewController: UIViewController!
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var dialogView: UIView!
    
    
    var gestureRecognizer : UIPanGestureRecognizer!
    
    func setGestureRecognizer () {
        gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handle))
        scrollView.addGestureRecognizer(gestureRecognizer)
        gestureRecognizer.delegate = self
    }
    
    @objc func handle(_ gesture : UIPanGestureRecognizer) {
        
    }
    
}

extension InteractionPanToClose : UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
