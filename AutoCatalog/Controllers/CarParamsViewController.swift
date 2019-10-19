//
//  CarParamsViewController.swift
//  AutoCatalog
//
//  Created by Ира on 16/10/2019.
//  Copyright © 2019 Irina Lapteva. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class CarParamsViewController: UIViewController {
    
    var carParams: Results<CarParams>?
           let realm = try! Realm()
           var selectedCategory: Category? {
               didSet{
                   loadItems()
               }
           }
    
    @IBOutlet weak var brandField: UITextField!
    
    
    @IBOutlet weak var releaseYearField: UITextField!
    
    
    @IBOutlet weak var modelField: UITextField!
    
    
    @IBOutlet weak var carBodyField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func saveButton(_ sender: UIButton) {
    }
    
}
