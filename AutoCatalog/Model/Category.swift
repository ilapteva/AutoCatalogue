//
//  Category.swift
//  AutoCatalog
//
//  Created by Ира on 11/10/2019.
//  Copyright © 2019 Irina Lapteva. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<CarParams>()
}
