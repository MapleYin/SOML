//
//  PostManager.swift
//  SOML
//
//  Created by Maple Yin on 2018/12/31.
//  Copyright © 2018 Maple.im. All rights reserved.
//

import UIKit

class PostManager {
    
    static let shared = PostManager()
    private var postList: [PostModel] = []
    
    private var newPostEventList: [()->Void] = []
    
    init() {
        if let data = ShortMessageService.shared.fetch() {
            self.postList =  PostModel(JSON: data);
        }
    }
}

// MARK: - Operation
extension PostManager {
    
    func save(model: PostModel, notify: Bool = true) {
        self.postList.insert(model, at: 0)
        ShortMessageService.shared.insert(message: model)
        
        self.newPostEventList.forEach { (eventHandle) in
            eventHandle()
        }
    }
    
    func removeItem(at index: Int) -> Bool {
        guard index >= 0 && index < self.postList.count else {
            return false
        }
        let model = self.postList.remove(at: index)
        ShortMessageService.shared.delete(messageID: model.messageId as String)
        return true
    }
}


extension PostManager {
    func addNewPostEventHandler(_ handler:@escaping ()->Void) {
        self.newPostEventList.append(handler)
    }
}

// MARK: - Read
extension PostManager {
    
    func numberOfItem() -> Int {
        return self.postList.count
    }
    
    func itemAt(index: Int) -> PostModel? {
        guard index >= 0 && index < self.postList.count else {
            return nil
        }
        
        return self.postList[index]
    }
}
