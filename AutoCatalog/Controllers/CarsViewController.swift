//
//  CarsViewController.swift
//  AutoCatalog
//
//  Created by Ира on 11/10/2019.
//  Copyright © 2019 Irina Lapteva. All rights reserved.
//

import Foundation
import RealmSwift

class CarsTableViewController: SwipeTableViewController {
    
    var carParams: Results<CarParams>?
        let realm = try! Realm()
        var selectedCategory: Category? {
            didSet{
                loadItems()
            }
        }
        
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            tableView.separatorStyle = .none
            
        }
        
        override func viewWillAppear(_ animated: Bool) {
            
            
            let colorHex = "01122D"
            
            title = selectedCategory?.name
            
            updateNavBar(withHexCode: colorHex)
        }
        
    //    override func viewWillDisappear(_ animated: Bool) {
    //     updateNavBar(withHexCode: "004F78")
    //    }
        
        //MARK: - Nav Bar Setup Methods
        
        func updateNavBar(withHexCode colorHexCode: String){
            guard let navBar = navigationController?.navigationBar else {fatalError("Navigation Controller Doesn't Exist!")}
            guard let navBarColor = UIColor(named: colorHexCode) else {fatalError()}
            
//            navBar.tintColor = ContrastColorOf(navBarColor, returnFlat: true)
            
//            navBar.barTintColor = navBarColor
//
//            navBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: ContrastColorOf(navBarColor, returnFlat: true)]
//
//            searchBar.barTintColor = navBarColor
        }

        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return carParams?.count ?? 1
        }
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = super.tableView(tableView, cellForRowAt: indexPath)
            
            cell.textLabel?.font = UIFont(name: "Helvetica Neue", size: 18.0)
            
            if let item = carParams?[indexPath.row] {
            
            cell.textLabel?.text = item.mark
                
//                if let color = UIColor(hexString: selectedCategory!.color)?.lighten(byPercentage: CGFloat(indexPath.row)/CGFloat(todoItems!.count)) {
//                    cell.backgroundColor = color
//                   cell.textLabel?.textColor =  ContrastColorOf(color, returnFlat: true)
                }
            
            
//            cell.accessoryType = item.done ? .checkmark : .none
//            } else {
//                cell.textLabel?.text = "No Car Parameters Added"
//            }
            
            return cell
        }
        
//        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//            if let item = carParams?[indexPath.row] {
//                do{
//                    try realm.write {
//                        //realm.delete(item)
//                        item.done = !item.done
//                    }
//                } catch{
//                    print("Error checking items, \(error)")
//                }
//            }
//
//            tableView.reloadData()
//
//
//            tableView.deselectRow(at: indexPath, animated: true)
//        }
        
        //MARK: - Add new items
        
        @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
            
            var textField = UITextField()
            let alert = UIAlertController(title: "Add new car parameters", message: "", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "Add Parameters", style: .default) { (action) in
                //what will happen once the user clicks  Add Item button on our UIAlert
                
                if let currentCategory = self.selectedCategory{
                    do{
                    try self.realm.write{
                        let newItem = CarParams()
                        newItem.mark = textField.text!
                        newItem.year = textField.text!
                        newItem.model = textField.text!
                        newItem.type = textField.text!
                        currentCategory.items.append(newItem)
                        }
                    } catch{
                        print("Error saving new items, \(error)")
                    }
                }
                self.tableView.reloadData()
            }
            
            alert.addTextField { (alertTextField) in
                alertTextField.placeholder = "Add new car"
                textField = alertTextField
                
                
            }
            alert.addAction(action)
            
            present(alert, animated: true, completion: nil)
        }
        
     
        func loadItems(){

            carParams = selectedCategory?.items.sorted(byKeyPath: "name", ascending: true)

            tableView.reloadData()
        }
        
        
        //MARK: - Delete Data From Swipe
        
        override func updateModel(at indexPath: IndexPath) {
            
            if let itemsForDeletion = self.carParams?[indexPath.row] {
                do {
                    try self.realm.write {
                        self.realm.delete(itemsForDeletion)
                    }
                } catch {
                    print ("Error deleting item, \(error)")
                }
                
            }
        }
        
}
