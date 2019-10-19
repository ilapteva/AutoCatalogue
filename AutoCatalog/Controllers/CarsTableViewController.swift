////
////  CarsViewController.swift
////  AutoCatalog
////
////  Created by Ира on 11/10/2019.
////  Copyright © 2019 Irina Lapteva. All rights reserved.
////
//
//import Foundation
//import RealmSwift
//
//class CarsTableViewController: SwipeTableViewController {
//    
// 
//    var carParams: Results<CarParams>?
//        let realm = try! Realm()
//        var selectedCategory: Category? {
//            didSet{
//                loadItems()
//            }
//        }
//        
//        
//        override func viewDidLoad() {
//            super.viewDidLoad()
//        }
//        
//        override func viewWillAppear(_ animated: Bool) {
//            
//            title = selectedCategory?.name
//        }
//                        
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return carParams?.count ?? 1
//    }
//    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//        let cell = super.tableView(tableView, cellForRowAt: indexPath)
//        
//        cell.textLabel?.font = UIFont(name: "Helvetica Neue", size: 18.0)
//        
//        if let item = carParams?[indexPath.row] {
//        
//        cell.textLabel?.text = item.brand
//        }
//
//        return cell
//    }
//    
//    //MARK: - Add new items
//    
//    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
//        
//        var textField = UITextField()
//        let alert = UIAlertController(title: "Add new car parameters", message: "", preferredStyle: .alert)
//        
//        let action = UIAlertAction(title: "Add Parameters", style: .default) { (action) in
//            //what will happen once the user clicks  Add Item button on our UIAlert
//            
//            if let currentCategory = self.selectedCategory{
//                do{
//                try self.realm.write{
//                    let newItem = CarParams()
//                    newItem.brand = textField.text!
////                    newItem.releaseYear = textField.text!
////                    newItem.model = textField.text!
////                    newItem.carBody = textField.text!
//                    currentCategory.items.append(newItem)
//                    }
//                } catch{
//                    print("Error saving new items, \(error)")
//                }
//            }
//            self.tableView.reloadData()
//        }
//        
//        alert.addTextField { (alertTextField) in
//            alertTextField.placeholder = "Add new car"
//            textField = alertTextField
//            
//            
//        }
//        alert.addAction(action)
//        
//        present(alert, animated: true, completion: nil)
//    }
//    
// 
//    func loadItems(){
//
//        carParams = selectedCategory?.items.sorted(byKeyPath: "name", ascending: true)
//
//        tableView.reloadData()
//    }
//    
//    
//    //MARK: - Delete Data From Swipe
//    
//    override func updateModel(at indexPath: IndexPath) {
//        
//        if let itemsForDeletion = self.carParams?[indexPath.row] {
//            do {
//                try self.realm.write {
//                    self.realm.delete(itemsForDeletion)
//                }
//            } catch {
//                print ("Error deleting item, \(error)")
//            }
//            
//        }
//    }
//    
//}
//
