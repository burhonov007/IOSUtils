//
//  CustomAnimation.swift
//  IOSUtils
//
//  Created by The WORLD on 17.01.2024.
//

// MARK: Custom PUSH/POP animation

import UIKit

class CustomAnimation: NSObject, UIViewControllerAnimatedTransitioning {

    private let operation: UINavigationController.Operation
    private let duration: TimeInterval

    init(operation: UINavigationController.Operation, duration: TimeInterval = 0.3) {
        self.operation = operation
        self.duration = duration
        super.init()
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }

    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.view(forKey: .from), let toView = transitionContext.view(forKey: .to) else { return }
        let container = transitionContext.containerView
        
        if operation == .push {
            toView.frame.origin = CGPoint(x: toView.frame.width, y: 0)
            container.addSubview(toView)
        } else if operation == .pop {
            container.insertSubview(toView, belowSubview: fromView)
        }
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut) {
            if self.operation == .push {
                fromView.alpha = 0.0
                toView.frame.origin = CGPoint(x: 0, y: 0)
            } else if self.operation == .pop {
                toView.alpha = 1.0
                fromView.frame.origin.x = fromView.frame.width
            }
        } completion: { _ in
            let success = !transitionContext.transitionWasCancelled
            if !success {
                toView.removeFromSuperview()
            }
            transitionContext.completeTransition(success)
        }


    }
}

// MARK: USAGE

///extension CustomNavController: UINavigationControllerDelegate {
//
///    public func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
///        return CustomAnimation(operation: operation)
///    }
//
///   func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
///        return interactionController
///    }
///
///}
