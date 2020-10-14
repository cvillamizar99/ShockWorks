//
//  UINavigationController+CE.swift
//  Movies
//
//  Created by Carlos Villamizar on 13/10/20.
//  Copyright © 2020 Carlos Villamizar. All rights reserved.
//

import UIKit

extension UINavigationController {
    func removeViewController(_ controller: UIViewController.Type) {
        if let viewController = viewControllers.first(where: { $0.isKind(of: controller.self) }) {
            viewController.removeFromParent()
        }
    }
        
    func clearBackground(){
        
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.isTranslucent = true
        self.navigationBar.backgroundColor = .clear
        self.view.backgroundColor = .clear
    }
    
    func setBackground(){
        
        let color: UIColor = #colorLiteral(red: 0.8906330466, green: 0.8615425229, blue: 0.923473537, alpha: 1)
        
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.isTranslucent = false
        self.navigationBar.backgroundColor = color
        self.navigationBar.barTintColor = color
        self.view.backgroundColor = color
    }
}
