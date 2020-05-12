//
//  GalleryCollectionViewController.swift
//  CatAPIViewer
//
//  Created by Alexey on 5/6/20.
//  Copyright © 2020 Alexey. All rights reserved.
//

import UIKit

class GalleryCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    var imagesCats = [ImageCAT]()
    
    private let apiManager = APIManager()
    @IBOutlet weak var collectionView: UICollectionView!
    private let reuseIdentifier = "imageCatCell"
    private let sectionInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    private let itemPerRow: CGFloat = 3
    var largeImage = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "ImageCatCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
       
        self.collectionView.contentInsetAdjustmentBehavior = .never
        
        getImagesForGallery()
    }
  
    func getImagesForGallery() {
           apiManager.getImages() { [weak self] (imagesCats, error) in
               if let error = error {
                   print("Get breeds error: \(error.localizedDescription)")
                   return
               }
               
               
               guard let imagesCat = imagesCats  else { return }
               DispatchQueue.main.sync {
                   self?.imagesCats = imagesCat
                  self?.collectionView.reloadData()
               }
      
           }
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
      
  
    //MARK: - Collection
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("Count imagesCats = \(imagesCats.count)")
        return imagesCats.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ImageCatCollectionViewCell
        cell.layer.cornerRadius = 5
        cell.layer.borderWidth = 0.5
        cell.layer.borderColor = UIColor .red.cgColor
        
        let url = imagesCats[indexPath.row].url
        fetchImage(from: url) { (imageData) in
                  if let data = imageData {
                      DispatchQueue.main.async {
                        cell.imageView.image = UIImage(data: data)
                        cell.imageView.contentMode = .scaleAspectFill
                      }
                  } else {
                        cell.imageView.image = UIImage(named: "catPlaceHolder")
                      
                  }
              }
      
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemPerRow


        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    override func viewWillLayoutSubviews() {
      super.viewWillLayoutSubviews()
      collectionView.collectionViewLayout.invalidateLayout()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         largeImage = imagesCats[indexPath.row].url
        
        self.performSegue(withIdentifier: "DetailImage", sender: self)
    }
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
             if segue.identifier == "DetailImage" {
                 let controller = segue.destination as! LargeImageViewController
                controller.largeImageURL = largeImage
             }
         }

}
