//
//  ViewController.swift
//  AutoCatalog
//
//  Created by Ира on 11/10/2019.
//  Copyright © 2019 Irina Lapteva. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryTableViewController: SwipeTableViewController {

    let realm = try! Realm()
    
    var categories: Results<Category>?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
        tableView.separatorStyle = .none
        
    }
    
    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
       
        
        if let category = categories?[indexPath.row] {
        
        cell.textLabel?.text = category.name
            
        cell.textLabel?.font = UIFont(name: "Helvetica Neue", size: 18.0)
            
//            guard let categoryColor = UIColor.black else {fatalError()}
//
//        cell.backgroundColor = categoryColor
            
//        cell.textLabel?.textColor = ContrastColorOf(categoryColor, returnFlat: true)
            
        }
        
        return cell
    }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
            let alert = UIAlertController(title: "Add new car", message: "", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "Add", style: .default) { (action) in
                //what will happen once the user clicks  Add Item button on our UIAlert
                
                let newCategory = Category()
                newCategory.name = textField.text!
//                newCategory.color = UIColor.flatNavyBlue().hexValue()
//                print(UIColor.flatNavyBlueDark().hexValue())
                self.save(category: newCategory)
                
                
        }
            alert.addTextField { (field) in
                textField.placeholder = "Create new car"
                textField = field
            }
            
            alert.addAction(action)
            
            present(alert, animated: true, completion: nil)
    }
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToParams", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! CarsTableViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
    
    //MARK: - TableView Data Manipulation Methods
    
    func save(category: Category) {
        
        do{
            try realm.write {
                realm.add(category)
            }
        } catch{
            print ("Error saving context, \(error)")
            
        }
        tableView.reloadData()
    }
    
    func loadCategories(){
    
        categories = realm.objects(Category.self)

        tableView.reloadData()
    }
    
    //MARK: - Delete Data From Swipe
    
    override func updateModel(at indexPath: IndexPath) {
        
        if let categoriesForDeletion = self.categories?[indexPath.row] {
        do {
            try self.realm.write {
                self.realm.delete(categoriesForDeletion)
            }
        } catch {
            print ("Error deleting category, \(error)")
        }

    }
    }
}

