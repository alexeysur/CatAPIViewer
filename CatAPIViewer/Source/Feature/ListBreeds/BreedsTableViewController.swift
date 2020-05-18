//
//  BreedsTableViewController.swift
//  CatAPIViewer
//
//  Created by Alexey on 5/6/20.
//  Copyright © 2020 Alexey. All rights reserved.
//

import UIKit


class BreedsTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    @IBOutlet weak var tableView: UITableView!
    var breeds = [Breed]()
    var valueToPass = Breed()
    private let heightRow = 44
    
    private let jsonParser = JSONParser()
    let apiConfig = APIConfig()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        getBreeds()
        tableView.reloadData()
    }

    func getBreeds() {
        let jsonURL = apiConfig.fetchURL(with: .breeds, parameters: ["x_api_key" : apiConfig.apiKey])
      
        jsonParser.downloadData(of: Breed.self, from: jsonURL!) { (result) in
               switch result {
               case .failure(let error):
                   if error is DataError {
                       print("DataError = \(error)")
                   } else {
                       print(error.localizedDescription)
                   }
               case .success(let breeds):
                DispatchQueue.main.sync {
                    BreedService.breeds = breeds
                    self.tableView.reloadData()
                     
                }
                   
               }
               
           }
    }
    
  
    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return BreedService.breeds.count
 
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellBreed", for: indexPath)
        
        cell.textLabel?.text = BreedService.breeds[indexPath.row].name

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(heightRow)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        valueToPass = BreedService.breeds[indexPath.row]
        self.performSegue(withIdentifier: "DetailBreed", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailBreed" {
            let controller = segue.destination as! DetailBreedViewController
            controller.dataBreed = valueToPass
        }
    }
    
    
}
