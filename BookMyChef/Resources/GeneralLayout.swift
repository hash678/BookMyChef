//
//  GeneralLayout.swift
//  BookMyChef
//
//  Created by Hassan Abbasi on 09/11/2019.
//  Copyright © 2019 Rove. All rights reserved.
//

import Foundation
import UIKit


extension UIViewController {
    
    func hideWeirdAssNavigationShadow(){
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    
    static func swizzlePresent() {
        
        let orginalSelector = #selector(present(_: animated: completion:))
        let swizzledSelector = #selector(swizzledPresent)
        
        guard let orginalMethod = class_getInstanceMethod(self, orginalSelector), let swizzledMethod = class_getInstanceMethod(self, swizzledSelector) else{return}
        
        let didAddMethod = class_addMethod(self,
                                           orginalSelector,
                                           method_getImplementation(swizzledMethod),
                                           method_getTypeEncoding(swizzledMethod))
        
        if didAddMethod {
            class_replaceMethod(self,
                                swizzledSelector,
                                method_getImplementation(orginalMethod),
                                method_getTypeEncoding(orginalMethod))
        } else {
            method_exchangeImplementations(orginalMethod, swizzledMethod)
        }
        
    }
    
    @objc
    private func swizzledPresent(_ viewControllerToPresent: UIViewController,
                                 animated flag: Bool,
                                 completion: (() -> Void)? = nil) {
        if #available(iOS 13.0, *) {
            if viewControllerToPresent.modalPresentationStyle == .automatic {
                viewControllerToPresent.modalPresentationStyle = .fullScreen
            }
        }
        swizzledPresent(viewControllerToPresent, animated: flag, completion: completion)
    }
}

class PagingCollectionViewLayout: UICollectionViewFlowLayout {
    
    var velocityThresholdPerPage: CGFloat = 2
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = collectionView else { return proposedContentOffset }
        
        let pageLength: CGFloat
        let approxPage: CGFloat
        let currentPage: CGFloat
        let speed: CGFloat
        
        if scrollDirection == .horizontal {
            pageLength = self.itemSize.width + self.minimumLineSpacing
            approxPage = collectionView.contentOffset.x / pageLength
            speed = velocity.x
        } else {
            pageLength = self.itemSize.height + self.minimumLineSpacing
            approxPage = collectionView.contentOffset.y / pageLength
            speed = velocity.y
        }
        
        if speed < 0 {
            currentPage = ceil(approxPage)
        } else if speed > 0 {
            currentPage = floor(approxPage)
        } else {
            currentPage = round(approxPage)
        }
        
        guard speed != 0 else {
            if scrollDirection == .horizontal {
                return CGPoint(x: currentPage * pageLength, y: 0)
            } else {
                return CGPoint(x: 0, y: currentPage * pageLength)
            }
        }
        
        var nextPage: CGFloat = currentPage + (speed > 0 ? 1 : -1)
        
        let increment = speed / velocityThresholdPerPage
        nextPage += (speed < 0) ? ceil(increment) : floor(increment)
        
        if scrollDirection == .horizontal {
            return CGPoint(x: nextPage * pageLength, y: 0)
        } else {
            return CGPoint(x: 0, y: nextPage * pageLength)
        }
    }
}

class GeneralLayout{
    
    static func backgroundWithOverlay(overlayColor:UIColor, overlayOpacity:CGFloat, image:UIImage) -> UIView{
        let b = UIView()
        b.translatesAutoresizingMaskIntoConstraints = false
        
        let backgroundImage = UIImageView(image: image)
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        backgroundImage.contentMode = .scaleAspectFill
        b.addSubview(backgroundImage)
        backgroundImage.leftAnchor.constraint(equalTo: b.leftAnchor).isActive = true
        backgroundImage.rightAnchor.constraint(equalTo: b.rightAnchor).isActive = true
        backgroundImage.bottomAnchor.constraint(equalTo: b.bottomAnchor).isActive = true
        backgroundImage.topAnchor.constraint(equalTo: b.topAnchor).isActive = true
        
        let overlay = UIView()
        overlay.translatesAutoresizingMaskIntoConstraints = false
        overlay.backgroundColor = overlayColor.withAlphaComponent(overlayOpacity)
        
        
        b.addSubview(overlay)
        overlay.leftAnchor.constraint(equalTo: b.leftAnchor).isActive = true
        overlay.rightAnchor.constraint(equalTo: b.rightAnchor).isActive = true
        overlay.bottomAnchor.constraint(equalTo: b.bottomAnchor).isActive = true
        overlay.topAnchor.constraint(equalTo: b.topAnchor).isActive = true
        
        return b
        
    }
    static func addOverlay(overlayColor:UIColor, overlayOpacity:CGFloat,view:UIView){
        let overlay = UIView()
        overlay.translatesAutoresizingMaskIntoConstraints = false
        overlay.backgroundColor = overlayColor.withAlphaComponent(overlayOpacity)
        view.addSubview(overlay)
        overlay.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        overlay.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        overlay.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        overlay.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        
        
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
