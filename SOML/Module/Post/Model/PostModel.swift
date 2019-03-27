//
//  PostModel.swift
//  SOML
//
//  Created by Maple Yin on 2018/12/31.
//  Copyright © 2018 Maple.im. All rights reserved.
//

import Foundation
import ObjectMapper

class PostModel: Mappable {
    
    var messageId: NSString = UUID().uuidString as NSString
    var content: NSString = ""
    var createDate: NSDate = NSDate()
    var modifyDate: NSDate = NSDate()
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        messageId <- map["messageId"]
        content <- map["content"]
        createDate <- map["createDate"]
        modifyDate <- map["modifyDate"]
    }
}
