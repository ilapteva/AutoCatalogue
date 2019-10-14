//
//  Cars.swift
//  AutoCatalog
//
//  Created by Ира on 11/10/2019.
//  Copyright © 2019 Irina Lapteva. All rights reserved.
//

import Foundation
import RealmSwift

class CarParams: Object {
    @objc dynamic var year: String = ""
    @objc dynamic var mark: String = ""
    @objc dynamic var model: String = ""
    @objc dynamic var type: String = ""
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
