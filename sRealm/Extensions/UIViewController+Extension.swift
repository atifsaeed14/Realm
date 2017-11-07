//
//  UIViewController+Extension.swift
//  ASSwift
//
//  Created by Atif Saeed on 6/13/17.
//  Copyright © 2017 AtifSaeed. All rights reserved.
//

import Foundation
import UIKit

// Time Delay Function
/*
 fileprivate var duration: Double = 0.65
 delay(duration) {
 navigationController.pushViewController(viewController, animated: false)
}*/

func delay(_ delay:Double, closure:@escaping ()->()) {
    DispatchQueue.main.asyncAfter(
        deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
}

extension UIViewController {
    
    func getCurrentVC(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        
        var rootVC = controller
        
        if rootVC == nil {
            rootVC = UIApplication.shared.keyWindow?.rootViewController
        }
        
        if rootVC?.presentedViewController == nil {
            return rootVC
        }
        
        if let presentedVC = rootVC?.presentedViewController {
            
            if presentedVC.isKind(of: UINavigationController.self) {
                let navigationController = presentedVC as! UINavigationController
                return navigationController.viewControllers.last!
            }
            
            if presentedVC.isKind(of: UITabBarController.self) {
                let tabBarController = presentedVC as! UITabBarController
                return tabBarController.selectedViewController!
            }
            
            return getCurrentVC(controller: presentedVC)
        }
        
        return nil
    }
    
}
