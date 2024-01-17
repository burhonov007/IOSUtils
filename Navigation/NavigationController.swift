//
//  NavigationController.swift
//  IOSUtils
//
//  Created by The WORLD on 17.01.2024.
//

//MARK: CustomNavController with custom PUSH/POP transition

import UIKit

class CustomNavController: UINavigationController {
    
    let gradientImg = UIImageView(image: UIImage(named: "main_gradient"))
    let dotsImg = UIImageView(image: UIImage(named: "main_dots"))
    let diamondImg = UIImageView(image: UIImage(named: "main_diamonds"))
    private var interactionController: UIPercentDrivenInteractiveTransition?
    private var edgeSwipeGestureRecognizer: UIScreenEdgePanGestureRecognizer?
    private var toVC: UIViewController?
    private var fromVC: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        view.addSubview(gradientImg)
        view.addSubview(dotsImg)
        view.addSubview(diamondImg)
        view.sendSubviewToBack(diamondImg)
        view.sendSubviewToBack(dotsImg)
        view.sendSubviewToBack(gradientImg)
        diamondImg.addParallax(minRelativeValue: -30, maxRelativeValue: 30)
        
        edgeSwipeGestureRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        edgeSwipeGestureRecognizer!.edges = .left
        view.addGestureRecognizer(edgeSwipeGestureRecognizer!)
        
        gradientImg.snp.makeConstraints { $0.edges.equalToSuperview() }
        dotsImg.snp.makeConstraints { $0.top.leading.trailing.equalToSuperview() }
        diamondImg.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(-75)
            make.trailing.equalToSuperview().inset(-146)
        }
        setupNavBarAppearance()
    }
    
    @objc func handleSwipe(_ gestureRecognizer: UIScreenEdgePanGestureRecognizer) {
        let gestureX = gestureRecognizer.translation(in: gestureRecognizer.view!).x
        let gestureWidth = gestureRecognizer.view!.bounds.size.width
        let percent = gestureX / gestureWidth
        
        if gestureRecognizer.state == .began {
            interactionController = UIPercentDrivenInteractiveTransition()
            if viewControllers.count > 1 { fromVC = viewControllers.last }
            popViewController(animated: true)
            if viewControllers.last != viewControllers.first { toVC = viewControllers.last }
        } else if gestureRecognizer.state == .changed {
            interactionController?.update(percent)
            toVC?.view.alpha = percent
        } else if gestureRecognizer.state == .ended {
            if gestureX > 0 { fromVC?.view.frame.origin.x = gestureX + fromVC!.view.frame.origin.x }
            if percent > 0.3 && gestureRecognizer.state != .cancelled {
                interactionController?.finish()
                toVC?.view.alpha = 1.0
            } else {
                UIView.animate(withDuration: percent) {
                    self.fromVC?.view.frame.origin.x = gestureWidth
                }
                interactionController?.cancel()
            }
            interactionController = nil
            toVC = nil
            fromVC = nil
        }
        
    }
    
    private func setupNavBarAppearance() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = .clear
        navBarAppearance.shadowColor = .clear
        navBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationBar.standardAppearance = navBarAppearance
        navigationBar.scrollEdgeAppearance = navBarAppearance
        navigationBar.compactAppearance = navBarAppearance
    }
}


extension CustomNavController: UINavigationControllerDelegate {
    
    public func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CustomAnimation(operation: operation)
    }
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactionController
    }

}
