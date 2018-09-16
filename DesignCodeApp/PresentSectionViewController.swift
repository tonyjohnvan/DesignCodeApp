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
    
    let animateDurationTimeConst : TimeInterval = 0.6
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animateDurationTimeConst
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
        
        let moveUpTransform = CGAffineTransform(translationX: 0, y: -100)
        let scaleUpTransform = CGAffineTransform(scaleX: 2, y: 2)
        let removeFromViewTransform = moveUpTransform.concatenating(scaleUpTransform)
        
        destination.closeVisualEffectView.alpha = 0
        destination.closeVisualEffectView.transform = removeFromViewTransform
        
        destination.subheadVisualEffectView.alpha = 0
        destination.subheadVisualEffectView.transform = removeFromViewTransform
        
        let widthConstraint = destination.scrollView.widthAnchor.constraint(equalToConstant: 304)
        let heightConstraint = destination.scrollView.heightAnchor.constraint(equalToConstant: 248)
        let bottomConstraint = destination.scrollView.bottomAnchor.constraint(equalTo: destination.coverView.bottomAnchor)
        
        NSLayoutConstraint.activate([widthConstraint, heightConstraint, bottomConstraint])
        
        let translate = CATransform3DMakeTranslation(cellFrame.origin.x, cellFrame.origin.y, 0.0)
        let transform = CATransform3DConcat(translate, cellTransform)
        
        destination.view.layer.transform = transform
        destination.view.layer.zPosition = 999
        
        containerView.layoutIfNeeded()
        
        let animator = UIViewPropertyAnimator(duration: animateDurationTimeConst, dampingRatio: 0.7) {
            //Final State
            NSLayoutConstraint.deactivate([widthConstraint,heightConstraint,bottomConstraint])
            destination.view.layer.transform = CATransform3DIdentity
            containerView.layoutIfNeeded()
            
            
            destination.scrollView.layer.cornerRadius = 0
            
            destination.closeVisualEffectView.alpha = 1
            destination.closeVisualEffectView.transform = .identity
            
            destination.subheadVisualEffectView.alpha = 1
            destination.subheadVisualEffectView.transform = .identity
            
            //label transform
            let scaleTitleTransform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            let moveTitleTransform = CGAffineTransform(translationX: 30, y: 10)
            let titleTransform = scaleTitleTransform.concatenating(moveTitleTransform)
            
            destination.titleLable.transform = titleTransform
        }
        
        animator.addCompletion { (finished) in
            //Completion
            transitionContext.completeTransition(true)
        }
        
        animator.startAnimation()
    }
    

}
