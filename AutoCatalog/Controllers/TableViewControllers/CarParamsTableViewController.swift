//
//  CarParamsViewController.swift
//  AutoCatalog
//
//  Created by Ира on 16/10/2019.
//  Copyright © 2019 Irina Lapteva. All rights reserved.
//

import Foundation
import UIKit



class CarParamsTableViewController: UITableViewController {

        private var allCellsTextField = [UITextField]()
        var car: CarParams?
        private let reuseIdentifier = "paramsCell"
        private let placeholders = ["Brand", "Release Year", "Model", "Car Body"]

        
        override func viewDidLoad() {
            super.viewDidLoad()

            // Do any additional setup after loading the view.
        }
        
        
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
            guard let brand = allCellsTextField[0].text, let releaseYear = allCellsTextField[1].text, let model = allCellsTextField[2].text, let carBody = allCellsTextField[3].text else { return }
            if car == nil {
                var maxId = realm.objects(CarParams.self).map{$0.id}.max() ?? 0
                maxId = maxId + 1
        
                
                let newCar = CarParams(id: maxId, brand: brand, releaseYear: releaseYear, model: model,carBody: carBody)
                    ServiceRealm.save(carObject: newCar)
                
                navigationController?.popViewController(animated: true)
                
            } else {
                guard let updatedCar = realm.objects(CarParams.self).filter("id == \(car!.id)").first else { return }
                try! realm.write {
                    updatedCar.brand = brand
                    updatedCar.model = model
                    updatedCar.carBody = carBody
                    updatedCar.releaseYear = releaseYear
                }
                navigationController?.popViewController(animated: true)
                }
        }
}

    

    extension CarParamsTableViewController {
        
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 4
        }
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! CarParamsTableViewCell
            let placeholder = placeholders[indexPath.row]
            cell.paramsTextField.placeholder = placeholder
            allCellsTextField.append(cell.paramsTextField)

            if car != nil {
                switch indexPath.row {
                case 0:
                    cell.paramsTextField.text = car!.brand
                case 1:
                    cell.paramsTextField.text = car!.releaseYear
                case 2:
                    cell.paramsTextField.text = car!.model
                case 3:
                    cell.paramsTextField.text = car!.carBody
                default:
                    print("default")
                }
            }
            
            return cell
        }
}
