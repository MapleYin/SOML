//
//  Router.swift
//  SOML
//
//  Created by Maple Yin on 2018/12/17.
//  Copyright © 2018 Maple.im. All rights reserved.
//

import UIKit

class Router {
    
    static let shared = Router()
    
    private var moduleList: [String : Module] = [:]
    
    private var currentActiveModule: Module?
    
    private var currentNavigation: UINavigationController?
    
    /// Register a Module
    ///
    /// - Parameter module: moudle
    func register(with module: Module) {
        self.moduleList[module.name] = module
    }
    
    
    /// Get a Module
    ///
    /// - Parameter name: module name
    /// - Returns: module
    func get(module name: String) -> Module? {
        return self.moduleList[name]
    }
    
    
}



// MARK: - Controller Push
extension Router {
    func open(module name: String) {
        guard let module = self.moduleList[name],
         let currentActiveModule = self.currentActiveModule else {
            return
        }
        
        let controller = module.open(from: currentActiveModule.activeController)
        
        if module.openType.contains(.push) {
            self.currentNavigation?.pushViewController(controller, animated: true)
        } else {
            self.currentNavigation?.present(controller, animated: true, completion: nil)
        }
    }
}
