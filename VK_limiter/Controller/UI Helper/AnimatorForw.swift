//
//  AnimatorForw.swift
//  VK_limiter
//
//  Created by Aleksei Kanatev on 22.05.2020.
//  Copyright © 2020 Aleksei Kanatev. All rights reserved.
//
//


import UIKit

class AnimatorForw: NSObject, UIViewControllerAnimatedTransitioning {
    
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
        destination.view.transform = CGAffineTransform(translationX: source.view.bounds.width + 100, y: 0)
        
        UIView.animateKeyframes(withDuration: animationDur, delay: 0, options: .calculationModePaced, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.75, animations: {
                let translation = CGAffineTransform(translationX: transitionContext.containerView.frame.width, y: transitionContext.containerView.frame.height)
                let rotation = CGAffineTransform(rotationAngle: 2)
                source.view.transform = translation.concatenating(rotation)
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.4, animations: {
                // указываем точку вылета анимации
                let translation = CGAffineTransform(translationX: -transitionContext.containerView.frame.width, y: transitionContext.containerView.frame.height)
                let rotation = CGAffineTransform(rotationAngle: -2)
                destination.view.transform = translation.concatenating(rotation)
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.4, relativeDuration: 0.4, animations: {
                destination.view.transform = .identity
            })
        }) { finished in
            if finished && !transitionContext.transitionWasCancelled {
                source.view.transform = .identity
            }
            transitionContext.completeTransition(finished && !transitionContext.transitionWasCancelled)
        }
    }
}
