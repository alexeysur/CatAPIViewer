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
    
    private var breedDetail: BreedDetail?
    private let apiConfig = APIConfig()

    private let jsonParser = JSONParser()

    @IBOutlet weak var imageBreed: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var lblTemperament: UILabel!
    @IBOutlet weak var lblLifeSpan: UILabel!
    @IBOutlet weak var activityIndecator: UIActivityIndicatorView!
    
    weak var delegate: BreedsTableViewController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblName.text = dataBreed.name
        lblTemperament.text = dataBreed.temperament
        lblLifeSpan.text = dataBreed.life_span
        descriptionTextView.text = dataBreed.description
      
        setup()
        
        getImagefromURL(from: dataBreed.id)
    }
    
    func setup() {
  
        activityIndecator.centerXAnchor.constraint(equalTo: imageBreed.centerXAnchor).isActive = true
        activityIndecator.centerYAnchor.constraint(equalTo: imageBreed.centerYAnchor).isActive = true
        
        activityIndecator.isHidden = false
        activityIndecator.startAnimating()

    }
    
   func getImagefromURL(from breedID: String?) {
    let jsonURL = apiConfig.fetchURL(with: .images, parameters: [apiConfig.breed_ids: breedID!])
    
    jsonParser.downloadData(of: BreedDetail.self, from: jsonURL!) { (result) in
                switch result {
                case .failure(let error):
                    if error is DataError {
                        print("DataError = \(error)")
                    } else {
                        print(error.localizedDescription)
                    }
                case .success(let breedDetail):
                 DispatchQueue.main.sync {
                       self.breedDetail = breedDetail[0]
                       self.setImageToImageView(from: (self.breedDetail?.url)!)
                    
                 }
                    
                }
                
            }
    
    
   }

    func setImageToImageView(from urlImage: String) {
        jsonParser.fetchImage(from: urlImage) { (imageData, error) in
            if let data = imageData {
                DispatchQueue.main.async {
                    self.imageBreed.image = data
                    
                    self.activityIndecator.stopAnimating()
                    self.activityIndecator.isHidden = true
                }
            } else {
                print("Error loading image!")
            }
        }
    }
    
}
