//
//  ShortMessageRM.swift
//  SOML
//
//  Created by Maple Yin on 2019/1/21.
//  Copyright © 2019 Maple.im. All rights reserved.
//

import Foundation
import RealmSwift


class ShortMessageRM: Object {
    
    @objc dynamic var messageId = UUID().uuidString
    @objc dynamic var createDate: NSDate? = nil
    @objc dynamic var modifyDate: NSDate? = nil
    @objc dynamic var content: String? = nil
    
    
    override static func primaryKey() -> String? {
        return "messageId"
    }
}
