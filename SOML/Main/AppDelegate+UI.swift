//
//  AppDelegate+UI.swift
//  SOML
//
//  Created by Yin,Heng on 2018/8/23.
//  Copyright © 2018年 Maple.im. All rights reserved.
//

import AsyncDisplayKit

extension AppDelegate {
    func setupUI() {
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        self.window?.rootViewController = MainTabBarController()
        self.window?.makeKeyAndVisible()
    }
}

