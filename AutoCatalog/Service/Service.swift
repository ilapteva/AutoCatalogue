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
    
    static func save(carObject: CarParams) {
        try! realm.write {
            realm.add(carObject)
        }
    }
    
    static func delete(carObject: CarParams) {
        try! realm.write {
            realm.delete(carObject)
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
