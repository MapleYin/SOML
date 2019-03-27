//
//  RealmDAO.swift
//  SOML
//
//  Created by Maple Yin on 2019/1/24.
//  Copyright © 2019 Maple.im. All rights reserved.
//

import Foundation
import RealmSwift

public class RealmDAO : NSObject, DBDAOProtocol {
    
    let objectClass: Object.Type
    
    public required init?(tableName: String) {
        guard let aClass = NSClassFromString(tableName) as? Object.Type else {
            DBDAO.sharedInstance.logMsg(msg: "tableName:\(tableName) not exist")
            return nil
        }
        
        self.objectClass = aClass
    }
    
    static func realmObject() -> Realm? {
        do {
            let realm = try Realm()
            return realm
        } catch let error as NSError {
            DBDAO.sharedInstance.logMsg(msg: "CreateRealmObjecFailed", error: error)
            return nil
        }
    }
    
    static func write(realm: Realm, block: ()->()) {
        do {
            if realm.isInWriteTransaction {
                block()
            } else {
                try realm.write {
                    block()
                }
            }
        } catch let error as NSError {
            DBDAO.sharedInstance.logMsg(msg: "RealmWriteFailed:\(error)", error: error)
        }
    }
    
    func _query(predicate: NSPredicate? = nil, sortDescriptors: [NSSortDescriptor]? = nil, limit: Int? = nil) -> [Any]? {
        guard let realm = RealmDAO.realmObject() else {
            return nil;
        }
        var result = realm.objects(objectClass.self)
        
        if let p = predicate {
            result = result.filter(p)
        }
        
        if let descriptors = sortDescriptors {
            var sorts = [SortDescriptor]()
            for s in descriptors {
                if let key = s.key {
                    sorts.append(SortDescriptor(keyPath: key, ascending: s.ascending))
                }
            }
            result = result.sorted(by: sorts)
        }
        
        var list = [Any]()
        var count = result.count
        if let _limit = limit, _limit != 0, _limit < count{
            count = _limit
        }
        
        for i in 0..<count {
            if let info = result[i].yy_modelToJSONObject() {
                list.append(info)
            }
        }
        return list
    }
}

public extension RealmDAO {
    
    public func query() -> [Any]? {
        return self._query()
    }
    
    public func query(primaryKey: String) -> Dictionary<String, Any>?{
        guard let realm = RealmDAO.realmObject() else {
            return nil
        }
        if let object = realm.object(ofType: objectClass.self, forPrimaryKey: primaryKey) {
            if let info = object.yy_modelToJSONObject() as? Dictionary<String, Any> {
                return info
            }
        }
        return nil
    }
    
    public func query(predicate: NSPredicate?) -> [Any]? {
        return self._query(predicate: predicate)
    }
    
    public func query(predicate: NSPredicate?, limit: Int) -> [Any]? {
        return self._query(predicate: predicate,limit: limit)
    }
    
    public func query(sortDescriptors: [NSSortDescriptor]) -> [Any]? {
        return self._query(sortDescriptors: sortDescriptors)
    }
    
    public func query(sortDescriptors: [NSSortDescriptor], limit: Int) -> [Any]? {
        return self._query(sortDescriptors: sortDescriptors,  limit:limit)
    }
    
    public func query(predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]) -> [Any]? {
        return self._query(predicate: predicate, sortDescriptors: sortDescriptors)
    }
    
    public func query(predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor], limit: Int) -> [Any]? {
        return self._query(predicate: predicate, sortDescriptors: sortDescriptors, limit:limit)
    }
    
    @discardableResult public func insert(info: Dictionary<String, Any>?) -> [Dictionary<String, Any>]? {
        return self.insert(info: info, incrementalUpdate: false)
    }
    
    @discardableResult public func insert(info: Dictionary<String, Any>?, incrementalUpdate: Bool) -> [Dictionary<String, Any>]? {
        if let i = info {
            return self.insert(list: [i], incrementalUpdate:incrementalUpdate)
        }
        return nil
    }
    
    @discardableResult public func insert(list: [Dictionary<String, Any>]?) -> [Dictionary<String, Any>]? {
        return self.insert(list: list, incrementalUpdate: false)
    }
    
    @discardableResult public func insert(list: [Dictionary<String, Any>]?,incrementalUpdate: Bool) -> [Dictionary<String, Any>]? {
        guard let l = list else {
            return nil
        }
        
        guard let realm = RealmDAO.realmObject() else {
            return nil
        }
        
        var newDataList = [Dictionary<String, Any>]()
        RealmDAO.write(realm: realm) {
            for (_, info) in l.enumerated() {
                guard let key = objectClass.primaryKey() else {
                    DBDAO.sharedInstance.logMsg(msg: "Insert failed,\(objectClass.self) not found primaryKey)")
                    continue
                }
                guard let primaryKey = info[key] else {
                    DBDAO.sharedInstance.logMsg(msg: "Insert failed,\(info) not find primaryKey \(key)")
                    continue
                }
                if let object = realm.object(ofType: objectClass.self, forPrimaryKey: primaryKey) {
                    if incrementalUpdate {
                        var _info = info
                        _info[key] = nil
                        object.yy_modelSet(with: _info)
                        continue
                    }
                } else {
                    newDataList.append(info)
                }
                
                if let result = objectClass.yy_model(with: info) {
                    realm.add(result, update:true)
                }
            }
        }
        return newDataList
    }
    
    public func update(primaryKey: String?, info: Dictionary<String, Any>?) {
        guard let primaryKeyName = objectClass.primaryKey() else {
            DBDAO.sharedInstance.logMsg(msg: "Update failed,\(objectClass.self) not found primaryKey)")
            return
        }
        guard let infoPrimaryKey = primaryKey,let dic = info else {
            DBDAO.sharedInstance.logMsg(msg: "Update failed,primaryKey or info must not be nil)")
            return
        }
        
        guard let realm = RealmDAO.realmObject() else {
            return
        }
        
        guard let object = realm.object(ofType: objectClass.self, forPrimaryKey: infoPrimaryKey) else {
            DBDAO.sharedInstance.logMsg(msg: "Update failed,\(infoPrimaryKey) object not found in \(objectClass.self)")
            return
        }
        
        RealmDAO.write(realm: realm) {
            var _info = dic
            _info[primaryKeyName] = nil
            object.yy_modelSet(with: _info)
        }
        
    }
    
    public func update(predicate: NSPredicate?, keyPath: String?, value: Any?) {
        guard let k = keyPath else {
            return
        }
        
        guard let realm = RealmDAO.realmObject() else {
            return
        }
        var result = realm.objects(objectClass.self)
        if let p = predicate {
            result = result.filter(p)
        }
        
        RealmDAO.write(realm: realm) {
            result.setValue(value, forKeyPath:k)
        }
    }
    
    public func delete(primaryKey: String?) {
        guard let key = primaryKey else {
            return
        }
        guard let realm = RealmDAO.realmObject() else {
            return
        }
        if let object = realm.object(ofType: objectClass.self, forPrimaryKey: key) {
            RealmDAO.write(realm: realm) {
                realm.delete(object)
            }
        }
    }
    
    public func delete(predicate: NSPredicate?) {
        guard let realm = RealmDAO.realmObject() else {
            return
        }
        var result = realm.objects(objectClass.self)
        if let p = predicate {
            result = result.filter(p)
        }
        RealmDAO.write(realm: realm) {
            realm.delete(result)
        }
    }
    
    func delete() {
        self.delete(predicate:nil)
    }
}



extension RealmDAO {
    
    static func realmFilePath() -> URL? {
        let cache = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first!
        
        guard let cachePath = URL(string:cache) else {
            return nil
        }
        let realmPath = cachePath.appendingPathComponent("RealmDB");
        
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: realmPath.absoluteString) == false {
            try? fileManager.createDirectory( atPath: realmPath.absoluteString,
                                              withIntermediateDirectories: true,
                                              attributes: nil )
        }
        
        return realmPath
    }
    
    public static func config() {
        
        var config = Realm.Configuration(
            schemaVersion: 1000,
            migrationBlock: { migration, oldSchemaVersion in
                
        })
        
        if let realmPath = self.realmFilePath() {
            config.fileURL = realmPath.appendingPathComponent("soml.realm")
        }
        Realm.Configuration.defaultConfiguration = config
        
    }
    
    public static func deleteAll() {
        guard let realm = RealmDAO.realmObject() else {
            return
        }
        RealmDAO.write(realm: realm) {
            realm.deleteAll()
        }
    }
    
    public static func deleteAllRealmFiles() {
        
        if let realmPath = RealmDAO.realmFilePath()?.absoluteString {
            do {
                let filePaths = try FileManager.default.contentsOfDirectory(atPath: realmPath)
                for filePath in filePaths {
                    try FileManager.default.removeItem(atPath: "\(realmPath)/\(filePath)")
                }
            } catch let error as NSError {
                DBDAO.sharedInstance.logMsg(msg: "Realm:DeleteFileFailed", error: error)
            }
        }
    }
}
