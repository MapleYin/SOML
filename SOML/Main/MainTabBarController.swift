//
//  MainTabBarController.swift
//  SOML
//
//  Created by Yin,Heng on 2018/8/23.
//  Copyright © 2018年 Maple.im. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class MainTabBarController: ASTabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabbar()
    }
}


// MARK: - UI
extension MainTabBarController {
    func setupTabbar() {
        var viewControllers: [UIViewController] = []
        
        // TimeLine
        viewControllers.append(ASNavigationController(rootViewController: TimeLineViewController()))
        
        self.viewControllers = viewControllers
    }
}
