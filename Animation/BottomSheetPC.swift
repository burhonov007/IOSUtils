//
//  BottomSheetPC.swift
//  IOSUtils
//
//  Created by The WORLD on 17.01.2024.
//

//  MARK: Custom Bottom Sheet with dimmed background

import UIKit

final class BottomSheetPC: UIPresentationController {
    
    override var shouldPresentInFullscreen: Bool { false }

    private lazy var dimmView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        view.addGestureRecognizer(tapRecognizer)
        return view
    }()

    private lazy var tapRecognizer: UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        return recognizer
    }()

    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()

        guard let containerView = containerView, let presentedView = presentedView else { return }
        guard let screenHeight = UIApplication.shared.windows.first?.frame.height else { return }
        
        let minHeight = containerView.bounds.height / 3
        let maxHeight = containerView.bounds.height - containerView.bounds.height / 4
        var computableHeight = screenHeight > 740.0 ? 34.0 : 0.0
        
        if let vc = presentedViewController as? ComputableView {
            computableHeight += vc.computableHeight()
        }
        let height = min(max(computableHeight, minHeight), maxHeight)

        presentedView.translatesAutoresizingMaskIntoConstraints = false
        dimmView.translatesAutoresizingMaskIntoConstraints = false

        containerView.addSubview(dimmView)
        containerView.addSubview(presentedView)

        dimmView.alpha = 0
        performAlongsideTransitionIfPossible {
            self.dimmView.alpha = 1
        }

        dimmView.snp.makeConstraints { $0.edges.equalToSuperview() }
        presentedView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(height)
        }
    }

    override func presentationTransitionDidEnd(_ completed: Bool) {
        if !completed {
            dimmView.removeFromSuperview()
            presentedView?.removeFromSuperview()
        }
    }

    override func dismissalTransitionWillBegin() {
        super.dismissalTransitionWillBegin()

        performAlongsideTransitionIfPossible {
            self.dimmView.alpha = 0
        }
    }

    private func performAlongsideTransitionIfPossible(_ animation: @escaping () -> Void ) {
        guard let coordinator = presentedViewController.transitionCoordinator else {
            animation()
            return
        }

        coordinator.animate { _ in
            animation()
        }
    }

    @objc private func handleTap(_ sender: UITapGestureRecognizer) {
        presentingViewController.dismiss(animated: true)
    }
}

// MARK: Protocol for compute height for BottomSheetPC

protocol ComputableView {
    func computableHeight() -> CGFloat
}

// MARK: USAGE

///extension MapInfoVC: ComputableView {
///    func computableHeight() -> CGFloat {
///        view.layoutIfNeeded()
///        let height = scrollView.contentSize.height + 130
///        return height
///    }
///}


// MARK: USAGE

///extension MapInfoVC: UIViewControllerTransitioningDelegate {
///    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
///        BottomSheetPC(presentedViewController: presented, presenting: presenting ?? source)
///    }
///}
