//
//  RowDataRealm.swift
//  htmlParser
//
//  Created by FE Team TV on 9/7/16.
//  Copyright © 2016 courses. All rights reserved.
//

import Foundation
import RealmSwift

class RowDataRealm: Object {
    
    dynamic var id = 0
    dynamic var title = ""
    dynamic var label = ""
    dynamic var format = ""
    dynamic var country = ""
    dynamic var released = 0
    dynamic var genre = ""
    dynamic var price = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    func IncrementaID() -> Int{
        let realm = try! Realm()
        let RetNext: NSArray = Array(realm.objects(RowDataRealm).sorted("id"))
        let last = RetNext.lastObject
        if RetNext.count > 0 {
            let valor = last?.valueForKey("id") as? Int
            return valor! + 1
        } else {
            return 1
        }
    }
    
    func isPrimaryKey(id: Int) -> Bool {
        let realm = try! Realm()
        if Array(realm.objects(RowDataRealm).filter("id = \(id)")).count > 0 {
            return false }
        return true
    }
    
}
