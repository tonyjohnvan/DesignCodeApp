//
//  DismissSectionViewController.swift
//  DesignCodeApp
//
//  Created by Fan Zhang on 9/15/18.
//  Copyright © 2018 Meng To. All rights reserved.
//

import UIKit

class DismissSectionViewController: NSObject, UIViewControllerAnimatedTransitioning {
    
    let animateDurationTimeConst : TimeInterval = 0.6
    
    var cellFrame : CGRect!
    var cellTransform : CATransform3D!
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animateDurationTimeConst
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let origin = transitionContext.viewController(forKey: .from) as! SectionViewController
        let containerView = transitionContext.containerView
        
        containerView.addSubview(origin.view)
        
        //Initial
        origin.view.setNeedsLayout()
        
        let animator = UIViewPropertyAnimator(duration: animateDurationTimeConst, dampingRatio: 1) {
            //Final State
            
            let widthConstraint = origin.scrollView.widthAnchor.constraint(equalToConstant: self.cellFrame.width)
            let heightConstraint = origin.scrollView.heightAnchor.constraint(equalToConstant: self.cellFrame.height)
            let bottomConstraint = origin.scrollView.bottomAnchor.constraint(equalTo: origin.coverView.bottomAnchor)
            
            let titleTopConstraint = origin.titleLable.topAnchor.constraint(equalTo: origin.titleLable.superview!.topAnchor, constant: 20)
            
            NSLayoutConstraint.activate([widthConstraint, heightConstraint, bottomConstraint, titleTopConstraint])
            
            origin.view.layoutIfNeeded()
            
            let translate = CATransform3DMakeTranslation(self.cellFrame.origin.x, self.cellFrame.origin.y, 0.0)
            let transform = CATransform3DConcat(translate, self.cellTransform)
            
            origin.view.layer.transform = transform
            origin.view.layer.zPosition = 999
            
            origin.scrollView.layer.cornerRadius = 14
            origin.scrollView.layer.shadowOpacity = 0.25
            origin.scrollView.layer.shadowOffset.height = 10
            origin.scrollView.layer.shadowRadius = 20
            
            let moveUpTransform = CGAffineTransform(translationX: 0, y: -100)
            let scaleUpTranform = CGAffineTransform(scaleX: 2, y: 2)
            let removeFromViewTransform = moveUpTransform.concatenating(scaleUpTranform)
            origin.closeVisualEffectView.alpha = 0
            origin.closeVisualEffectView.transform = removeFromViewTransform
            origin.subheadVisualEffectView.alpha = 0
            origin.subheadVisualEffectView.transform = removeFromViewTransform
            origin.titleLable.transform = .identity
        }
        
        animator.addCompletion { (finished) in
            //Completion
            origin.view.removeFromSuperview()
            transitionContext.completeTransition(true)
        }
        
        animator.startAnimation()
    }
    

}
