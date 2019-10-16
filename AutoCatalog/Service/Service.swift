//
//  Service.swift
//  AutoCatalog
//
//  Created by Ира on 16/10/2019.
//  Copyright © 2019 Irina Lapteva. All rights reserved.
//


import RealmSwift

let realm = try! Realm()

class ServiceRealm {
    
    static func save(autoObject: CarParams) {
        try! realm.write {
            realm.add(autoObject)
        }
    }
    
    static func delete(autoObject: CarParams) {
        try! realm.write {
            realm.delete(autoObject)
        }
    }
    
    static func deleteAll() {
        try! realm.write {
            realm.deleteAll()
        }
    }
    
    static func getData() -> [CarParams] {
        
        return Array(realm.objects(CarParams.self))
        
    }

}
