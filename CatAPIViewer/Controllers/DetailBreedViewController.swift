//
//  DetailBreedViewController.swift
//  CatAPIViewer
//
//  Created by Alexey on 5/6/20.
//  Copyright © 2020 Alexey. All rights reserved.
//

import UIKit

class DetailBreedViewController: UIViewController {
    var dataBreed = Breed()
    var urlImageBreed = String()
    private let apiManager = APIManager()

    @IBOutlet weak var imageBreed: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var lblTemperament: UILabel!
    @IBOutlet weak var lblLifeSpan: UILabel!
    
    weak var delegate: BreedsTableViewController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblName.text = dataBreed.name
        lblTemperament.text = dataBreed.temperament
        lblLifeSpan.text = dataBreed.life_span
        descriptionTextView.text = dataBreed.description
      
        getImagefromURL(from: dataBreed.id)
    }
    
    
   func getImagefromURL(from breedID: String?) {
           apiManager.getImageBreedForDescription(breedID: breedID!, completion: { [weak self] (imageURL, error) in
               if let error = error {
                   print("Get url for image of breed error: \(error)")
                   return
               }
               
               guard let breedID = breedID else {return}
               print("Current Image URL: \(breedID)")
               DispatchQueue.main.sync {
                self?.urlImageBreed = imageURL!
                self?.setImageToImageView()
               }
           })
   }

    func fetchImage(from urlString: String, completion: @escaping (_ data: Data?) -> ()) {
        let session = URLSession.shared
       
        guard let url = URL(string: urlString) else {
            print("Error: Cannot create URL from string")
            return
        }
        let urlRequest = URLRequest(url: url)
        let dataTask = session.dataTask(with: urlRequest) { (data, response, error) in
            if error != nil {
                print("Error fetching the image!")
                completion(nil)
            } else {
                completion(data)
            }
            
        }
        dataTask.resume()
    }
    
    func setImageToImageView() {
        fetchImage(from: urlImageBreed) { (imageData) in
            if let data = imageData {
                DispatchQueue.main.async {
                    self.imageBreed.image = UIImage(data: data)
                }
            } else {
                print("Error loading image!")
            }
        }
    }
    
}
