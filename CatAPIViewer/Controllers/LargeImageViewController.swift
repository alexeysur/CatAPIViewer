//
//  LargeImageViewController.swift
//  CatAPIViewer
//
//  Created by Alexey on 5/10/20.
//  Copyright © 2020 Alexey. All rights reserved.
//

import UIKit
import Photos

class LargeImageViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var largeImage: UIImageView!
    var largeImageURL = String()
    
    var myCollectionView: UICollectionView!
    var imgArray = [UIImage]()
    var passedContentOffset = IndexPath()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.view.backgroundColor = UIColor.black
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        myCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        myCollectionView.register(ImageCatCollectionViewCell.self, forCellWithReuseIdentifier: "LargImage")
        myCollectionView.isPagingEnabled = true
        myCollectionView.scrollToItem(at: passedContentOffset, at: .left, animated: true)
        
        self.view.addSubview(myCollectionView)
        
     //   myCollectionView.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.RawValue(Unit8(UIViewAutoresizing.flexibleWidth.rawValue) | //UInt8(UIViewAutoresizing.flexibleHeight.rawValue)))
        
       
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgArray.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LargeImage", for: indexPath) as! ImageCatCollectionViewCell
        cell.imageView.image = imgArray[indexPath.row]
        
        return cell
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        
    }
    
    
    
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(true)
//        DispatchQueue.main.async {
//            self.fetchImage(from: self.largeImageURL) { (imageData) in
//                if let data = imageData {
//                    DispatchQueue.main.async {
//                      self.largeImage.image = UIImage(data: data)
//                        self.largeImage.contentMode = .scaleAspectFit
//                    }
//                } else {
//                      self.largeImage.image = UIImage(named: "catPlaceHolder")
//
//                }
//            }
//        }
//    }
//
//   func fetchImage(from urlString: String, completion: @escaping (_ data: Data?) -> ()) {
//           let session = URLSession.shared
//
//           guard let url = URL(string: urlString) else {
//               print("Error: Cannot create URL from string")
//               return
//           }
//           let urlRequest = URLRequest(url: url)
//           let dataTask = session.dataTask(with: urlRequest) { (data, response, error) in
//               if error != nil {
//                   print("Error fetching the image!")
//                   completion(nil)
//               } else {
//                   completion(data)
//               }
//
//           }
//           dataTask.resume()
//       }
       
    
    
}
