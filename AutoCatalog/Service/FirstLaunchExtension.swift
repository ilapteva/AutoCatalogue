//
//  FirtLaunchExtension.swift
//  AutoCatalog
//
//  Created by Ира on 16/10/2019.
//  Copyright © 2019 Irina Lapteva. All rights reserved.
//

import Foundation
import UIKit

extension UserDefaults {
    func isFirstLaunch() -> Bool {
        for (key, value) in UserDefaults.standard.dictionaryRepresentation() {
            print("\(key) = \(value) \n")
        }
        if !UserDefaults.standard.bool(forKey: "HasAtLeastLaunchedOnce") {
            UserDefaults.standard.set(true, forKey: "HasAtLeastLaunchedOnce")
            UserDefaults.standard.synchronize()
            return true
        }
        return false
    }
}
