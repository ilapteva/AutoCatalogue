//
//  CarViewController.swift
//  AutoCatalog
//
//  Created by Ира on 16/10/2019.
//  Copyright © 2019 Irina Lapteva. All rights reserved.
//

import Foundation
import UIKit

class CarTableViewController: UITableViewController {
        var allCars: [CarParams]?
        var selectedCar: CarParams?
        let reuseIdentifier = "carCell"
  
    
        override func viewDidLoad() {
            super.viewDidLoad()
            
            settingsForFirstLaunch()
            allCars = Array(realm.objects(CarParams.self))
            
        }
        
        private func settingsForFirstLaunch() {
            if UserDefaults.standard.isFirstLaunch() {
                let firstCar = CarParams(id: 1, brand: "Skoda", releaseYear: "1996", model: "Octavia", carBody: "Sedan")
                let secondCar = CarParams(id: 2, brand: "Ford", releaseYear: "1998", model: "Focus", carBody: "Hatchback")
                let thirdCar = CarParams(id: 3, brand: "Kia", releaseYear: "2000", model: "Rio", carBody: "Sedan")
                
                let cars = [firstCar, secondCar, thirdCar]
            
                for car in cars {
                    ServiceRealm.save(carObject: car)
                }
            }
        }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            

            allCars = Array(realm.objects(CarParams.self))
            tableView.reloadData()
            
        }

    @IBAction func addCarButton(_ sender: UIBarButtonItem) {
        
        selectedCar = nil
        performSegue(withIdentifier: "goToParams", sender: self)
    }
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToParams" {
            if let carVC = segue.destination as? CarParamsTableViewController
            {
                guard let selectedCar = selectedCar else { return }
                carVC.car = selectedCar
            }
        }
    }
}

extension CarTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allCars?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! CarTableViewCell
        guard let car = allCars?[indexPath.row] else { return  UITableViewCell() }
        cell.brandLabel.text = car.brand
        cell.modelLabel.text = car.model
        cell.yearLabel.text = car.releaseYear
        cell.carBodyLabel.text = car.carBody

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCar = allCars?[indexPath.row]
        performSegue(withIdentifier: "goToParams", sender: self)
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            ServiceRealm.delete(carObject: allCars![indexPath.row])
            allCars?.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
}

