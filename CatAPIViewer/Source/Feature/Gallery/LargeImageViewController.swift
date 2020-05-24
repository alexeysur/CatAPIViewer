//
//  LargeImageViewController.swift
//  CatAPIViewer
//
//  Created by Alexey on 5/10/20.
//  Copyright © 2020 Alexey. All rights reserved.
//

import UIKit

class LargeImageViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
 
    var imagesCats = [ImageCAT]()
    var passedContentOffset = IndexPath()
     
    private let jsonParser = JSONParser()
    let apiConfig = APIConfig()
    
    var myCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
      
        
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        myCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        myCollectionView.register(ImagePreviewCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        myCollectionView.isPagingEnabled = true
        
        myCollectionView.contentInsetAdjustmentBehavior = .never
        
        myCollectionView.autoresizingMask = UIView.AutoresizingMask(rawValue: UIView.AutoresizingMask.RawValue(UInt8(UIView.AutoresizingMask.flexibleWidth.rawValue) | UInt8(UIView.AutoresizingMask.flexibleHeight.rawValue)))
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
     
        myCollectionView.scrollToItem(at: passedContentOffset, at: .right, animated: true)
        
        self.view.addSubview(myCollectionView)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesCats.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ImagePreviewCollectionViewCell
    
        let url = imagesCats[indexPath.row].url
            
          jsonParser.fetchImage(from: url) { (imageData, error) in
                        if let data = imageData {
        
                            DispatchQueue.main.async {
                                cell.imgView.image = data
                                cell.imgView.contentMode = .scaleAspectFit
                            }
                        } else {
                                cell.imgView.image = UIImage(named: "catPlaceHolder")
                        }
                    }
            
              return cell
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        guard let flowLayout = myCollectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return}
        flowLayout.itemSize = myCollectionView.frame.size
      
        flowLayout.invalidateLayout()

        myCollectionView.collectionViewLayout.invalidateLayout()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        let offset = myCollectionView.contentOffset
        let width = myCollectionView.bounds.size.width

        let index = round(offset.x / width)
        let newOffset = CGPoint(x: index * size.width, y: offset.y)

        myCollectionView.setContentOffset(newOffset, animated: false)

        coordinator.animate(alongsideTransition: { (context) in
            self.myCollectionView.setContentOffset(newOffset, animated: false)

        },
            completion: nil)
        
    }
       
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        
        if UIDevice.current.orientation.isLandscape,
                   let layout = myCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                   let width = view.frame.width - 88
                   let height = view.frame.height
                   layout.itemSize = CGSize(width: width, height: height)
                   layout.invalidateLayout()
        } else if UIDevice.current.orientation.isPortrait,
                   let layout = myCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                   let width = view.frame.width
                   let height = view.frame.height - 88
                   layout.itemSize = CGSize(width: width , height: height)
                   layout.invalidateLayout()
        }
        
      }
}
    
