//
//  UIViewController+Veneer.swift
//  Pods
//
//  Created by Sam Watts on 25/01/2017.
//
//

import UIKit

public extension UIViewController {
    
    public func showVeneer(application: UIApplication = .shared) {
        guard application.veneerWindow == nil else {
            print("Error: unable to show veneer when one has already been shown")
            return
        }
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        window.windowLevel = UIWindowLevelStatusBar + 1
        
        window.rootViewController = VeneerRootViewController()
        
        window.makeKeyAndVisible()
        
        //store window to prevent it being removed on deinit
        application.veneerWindow = window
    }
    
    public func dismissVeneer(application: UIApplication = .shared) {
        guard let window = application.veneerWindow else {
            print("Warning: attempting to dismiss non visible veneer")
            return
        }
        
        UIView.animate(withDuration: 0.3, animations: {
            window.alpha = 0.0
        }) { _ in
            window.resignKey()
            application.veneerWindow = nil
        }
    }
}
