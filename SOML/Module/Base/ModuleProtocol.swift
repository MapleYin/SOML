//
//  ModuleProtocol.swift
//  SOML
//
//  Created by Maple Yin on 2018/12/17.
//  Copyright © 2018 Maple.im. All rights reserved.
//

import UIKit

struct ModuleOpenType: OptionSet {
    let rawValue: UInt
    
    static let push = ModuleOpenType(rawValue: 1)
    static let show = ModuleOpenType(rawValue: 2)
}

protocol Module {
    
    /// Module name
    var name: String { get }
    
    /// Current Active Controller
    var activeController: UIViewController { get }
    
    var openType: ModuleOpenType { get }
    
    
    /// Open a Module
    ///
    /// - Parameter from: open from controller
    /// - Returns: to controller
    func open(from: UIViewController) -> UIViewController
    
    
    /// Deal with Url
    ///
    /// - Parameter url: url string
    /// - Returns: can open or not
    func canOpen(with url: String) -> Bool
    
    
    /// Open with Url
    ///
    /// - Parameter url: url string
    /// - Returns: to controller
    func open(with url: String) -> UIViewController

}
