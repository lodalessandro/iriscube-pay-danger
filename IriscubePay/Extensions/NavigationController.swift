//
//  NavigationController.swift
//  IriscubePay
//
//  Created by Lorenzo Barranco on 01/09/2020.
//  Copyright © 2020 Lorenzo Barranco. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    var embeddedInClearNavigationController: UINavigationController {
        let navigationController = UINavigationController(navigationBarClass: ClearNavigationBar.self, toolbarClass: nil)
        navigationController.viewControllers = [self]
        return navigationController
    }
}

final class ClearNavigationBar: UINavigationBar {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    
    private func setup() {
        setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        shadowImage = UIImage()
        isTranslucent = true
        tintColor = .white
        
    }
}
