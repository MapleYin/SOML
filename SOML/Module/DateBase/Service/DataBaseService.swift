//
//  DataBaseService.swift
//  SOML
//
//  Created by Maple Yin on 2019/1/21.
//  Copyright © 2019 Maple.im. All rights reserved.
//

import Foundation
import RealmSwift


class DataBaseService {
    
    let dbDAO: DBDAOProtocol

    static func initDB() {
        DBDAO.sharedInstance.initDB()
    }
    
    static func deleteDBFile() {
        DBDAO.sharedInstance.deleteDBFiles()
    }
    
    
    
    init(tableName: String) {
        self.dbDAO = DBDAO.sharedInstance.dbDAO(tableName: "SOML.\(tableName)RM")!
    }

}
