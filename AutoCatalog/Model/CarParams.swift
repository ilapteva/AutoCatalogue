//
//  Cars.swift
//  AutoCatalog
//
//  Created by Ира on 11/10/2019.
//  Copyright © 2019 Irina Lapteva. All rights reserved.
//

import RealmSwift

class CarParams: Object {
    
    @objc dynamic var id = 0
    @objc dynamic var brand: String = ""
    @objc dynamic var releaseYear: String = ""
    @objc dynamic var model: String = ""
    @objc dynamic var carBody: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(id: Int, brand: String, releaseYear: String, model: String, carBody: String) {
        self.init()
        self.id = id
        self.brand = brand
        self.releaseYear = releaseYear
        self.model = model
        self.carBody = carBody
        
    }
    
}



