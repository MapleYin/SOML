//
//  ShortMessageService.swift
//  SOML
//
//  Created by Maple Yin on 2019/1/24.
//  Copyright © 2019 Maple.im. All rights reserved.
//

import Foundation


class ShortMessageService: DataBaseService {
    
    static let shared = ShortMessageService()
    
    init() {
        super.init(tableName: "ShortMessage")
    }
    
    @discardableResult
    func insert(message: PostModel) -> [[String: Any]]? {
        return self.dbDAO.insert(info: message.toJSON())
    }
    
    
    func fetch() -> [[String: Any]]? {
        if let data = self.dbDAO.query() as? [[String: Any]] {
            return data
        }
        
        return nil
    }
    
    
    func delete(messageID: String) {
        self.dbDAO.delete(primaryKey: messageID)
    }
}
