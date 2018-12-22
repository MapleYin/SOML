//
//  TimeLineViewController.swift
//  SOML
//
//  Created by Maple Yin on 2018/12/22.
//  Copyright © 2018 Maple.im. All rights reserved.
//

import AsyncDisplayKit

class TimeLineViewController: ASViewController<ASDisplayNode> {
    
    let tableNode = ASTableNode(style: .plain)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupNavigationData()
        self.setupTabbarData()
    }
}


// MARK: - UI
extension TimeLineViewController {
    
    // base setting
    
    func setupNavigationData() {
        self.title = "SOML"
    }
    
    func setupTabbarData() {
        self.tabBarItem.title = "TimeLine"
    }
    
    func setupTableNode() {
        
    }
}
