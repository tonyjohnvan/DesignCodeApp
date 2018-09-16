//
//  PresentSectionViewController.swift
//  DesignCodeApp
//
//  Created by Fan Zhang on 9/15/18.
//  Copyright © 2018 Meng To. All rights reserved.
//

import UIKit

class PresentSectionViewController: NSObject, UIViewControllerAnimatedTransitioning {
    
    var cellFrame : CGRect!
    var cellTransform : CATransform3D!
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let destination = transitionContext.viewController(forKey: .to) as! SectionViewController
        let containerView = transitionContext.containerView
        
        containerView.addSubview(destination.view)
        
        //Initianl State
        destination.scrollView.layer.cornerRadius = 14
        destination.scrollView.layer.shadowOpacity = 0.25
        destination.scrollView.layer.shadowOffset.height = 10
        destination.scrollView.layer.shadowRadius = 20
        
        let widthConstraint = destination.scrollView.widthAnchor.constraint(equalToConstant: 304)
        let heightConstraint = destination.scrollView.heightAnchor.constraint(equalToConstant: 248)
        let bottomConstraint = destination.scrollView.bottomAnchor.constraint(equalTo: destination.coverView.bottomAnchor)
        
        NSLayoutConstraint.activate([widthConstraint, heightConstraint, bottomConstraint])
        
        let translate = CATransform3DMakeTranslation(cellFrame.origin.x, cellFrame.origin.y, 0.0)
        let transform = CATransform3DConcat(translate, cellTransform)
        
        destination.view.layer.transform = transform
        destination.view.layer.zPosition = 999
        
        containerView.layoutIfNeeded()
        
        let animator = UIViewPropertyAnimator(duration: 5, dampingRatio: 0.7) {
            //Final State
            destination.scrollView.layer.cornerRadius = 0
            NSLayoutConstraint.deactivate([widthConstraint,heightConstraint,bottomConstraint])
            destination.view.layer.transform = CATransform3DIdentity
            containerView.layoutIfNeeded()
        }
        
        animator.addCompletion { (finished) in
            //Completion
            transitionContext.completeTransition(true)
        }
        
        animator.startAnimation()
    }
    

}
