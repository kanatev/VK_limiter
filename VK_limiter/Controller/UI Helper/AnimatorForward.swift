//
//  AnimatorForward.swift
//  VK_limiter
//
//  Created by Aleksei Kanatev on 16.05.2020.
//  Copyright © 2020 Aleksei Kanatev. All rights reserved.
//

import UIKit

class AnimatorForward: NSObject, UIViewControllerAnimatedTransitioning {
    
    private let animationDur: TimeInterval = 1
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animationDur
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
         guard let source = transitionContext.viewController(forKey: .from),
            let destination = transitionContext.viewController(forKey: .to) else { return }
        
        transitionContext.containerView.addSubview(destination.view)
        source.view.frame = transitionContext.containerView.frame
        destination.view.frame = transitionContext.containerView.frame
        destination.view.transform = CGAffineTransform(translationX: 0, y: -source.view.bounds.height)
        
        UIView.animate(withDuration: animationDur) {
            destination.view.transform = .identity
        }
        
        UIView.animate(withDuration: animationDur, animations: {
            destination.view.transform = .identity
        }) { completed in
            transitionContext.completeTransition(completed)
        }
        
    }
    
    
}
