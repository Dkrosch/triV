//
//  ReplaceCurrentViewController.swift
//  GConnect
//
//  Created by Michael Tanakoman on 08/08/21.
//

import UIKit

extension UINavigationController {
    func replaceCurrentViewControllerWith(viewController: UIViewController, animated: Bool) {
        var controllers = viewControllers
        controllers.removeLast()
        controllers.removeLast()
        controllers.append(viewController)
        setViewControllers(controllers, animated: animated)
    }
    
    func replaceCurrentViewControllerWith2(viewController: UIViewController, animated: Bool) {
        var controllers = viewControllers
        controllers.removeLast()
        controllers.removeLast()
        controllers.removeLast()
        controllers.append(viewController)
        setViewControllers(controllers, animated: animated)
    }
}
