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
    private let apiManager = APIManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        getBreeds()
        tableView.reloadData()
    }

    func getBreeds() {
        apiManager.getBreeds() { [weak self] (breeds, error) in
            if let error = error {
                print("Get breeds error: \(error.localizedDescription)")
                return
            }
            
            
            guard let breeds = breeds  else { return }
            DispatchQueue.main.sync {
                self?.breeds = breeds
                self?.tableView.reloadData()
            }
   
        }
    }
    
  
    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return breeds.count
 
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellBreed", for: indexPath)
        
        cell.textLabel?.text = breeds[indexPath.row].name

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        valueToPass = breeds[indexPath.row]
   //     let destinationVC = DetailBreedViewController()
   //     destinationVC.dataBreed = valueToPass
   //     destinationVC.delegate = self
    //    navigationController?.pushViewController(destinationVC, animated: true)
        
        self.performSegue(withIdentifier: "DetailBreed", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailBreed" {
            let controller = segue.destination as! DetailBreedViewController
            controller.dataBreed = valueToPass
        }
    }
    
    
}
