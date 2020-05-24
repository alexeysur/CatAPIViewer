//
//  GalleryCollectionViewController.swift
//  CatAPIViewer
//
//  Created by Alexey on 5/6/20.
//  Copyright © 2020 Alexey. All rights reserved.
//

import UIKit

let imgCache = NSCache<NSString, NSData>()

class GalleryCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    var imagesCats = [ImageCAT]()
    
    private let jsonParser = JSONParser()
    let apiConfig = APIConfig()
    
    @IBOutlet weak var collectionView: UICollectionView!
    private let reuseIdentifier = "imageCatCell"
    private let sectionInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    private let itemPerRow: CGFloat = 3
    
    var passedContentOffset = IndexPath()
    var myCollectionView: UICollectionView!
   
    var page: Int = 1
        
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "ImageCatCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)

        self.collectionView.contentInsetAdjustmentBehavior = .never

        getImagesForGallery()
    }
  
    func getImagesForGallery() {
        
        let jsonURL = apiConfig.fetchURL(with: .images, parameters:
            ["x_api_key" : apiConfig.apiKey,
             "limit" : apiConfig.limit,
             "page"  : String(page)])
        
         jsonParser.downloadData(of: ImageCAT.self, from: jsonURL!) { (result) in
                switch result {
                case .failure(let error):
                    if error is DataError {
                        print("DataError = \(error)")
                    } else {
                        print(error.localizedDescription)
                    }
                case .success(let imagesCats):
                 DispatchQueue.main.sync {
                    self.imagesCats = self.imagesCats + imagesCats
                    self.collectionView.reloadData()
                      
                 }
                    
                }
                
            }
    }

  
    //MARK: - CollectionView Methods
    override func viewDidAppear(_ animated: Bool) {
        collectionView.reloadData()
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesCats.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ImageCatCollectionViewCell
        cell.layer.cornerRadius = 5
        cell.layer.borderWidth = 0.5
        cell.layer.borderColor = Color.main.cgColor
        
          let url = imagesCats[indexPath.row].url
            
        jsonParser.fetchImage(from: url) { (imageData, error) in
                      if let data = imageData {
                       
                          DispatchQueue.main.async {
                            cell.imageView.image = data
                            cell.imageView.contentMode = .scaleAspectFill
                            cell.activityIndecator.stopAnimating()
                            cell.activityIndecator.isHidden = true
                          }
                      } else {
                            cell.imageView.image = UIImage(named: "catPlaceHolder")
                            cell.activityIndecator.stopAnimating()
                            cell.activityIndecator.isHidden = true
                          
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
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    override func viewWillLayoutSubviews() {
      super.viewWillLayoutSubviews()
      collectionView.collectionViewLayout.invalidateLayout()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = LargeImageViewController()
        vc.imagesCats = imagesCats
        vc.passedContentOffset = indexPath
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item == (imagesCats.count-1) {
               page += 1
               getImagesForGallery()
        }
    }
    
}
