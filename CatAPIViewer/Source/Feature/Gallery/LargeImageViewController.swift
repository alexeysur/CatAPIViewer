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
   
        myCollectionView.contentInsetAdjustmentBehavior = .automatic
        
        
     //   myCollectionView.autoresizingMask = UIView.AutoresizingMask(rawValue: UIView.AutoresizingMask.RawValue(UInt8(UIView.AutoresizingMask.flexibleWidth.rawValue) | UInt8(UIView.AutoresizingMask.flexibleHeight.rawValue)))
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
        print("url = \(url)")
            
          jsonParser.fetchImage(from: url) { (imageData, error) in
                        if let data = imageData {
                         
              //            cell.activityIndecator.startAnimating()
                            DispatchQueue.main.async {
                                cell.imgView.image = data
                                cell.imgView.contentMode = .scaleAspectFit
                          //      collectionView.reloadData()
                               //self.cell.activityIndecator.stopAnimating()
                        //        self.cell.activityIndecator.isHidden = true
                            }
                        } else {
                                cell.imgView.image = UIImage(named: "catPlaceHolder")
                           //     self.activityIndecator.stopAnimating()
                         //       self.activityIndecator.isHidden = true
                            
                        }
                    }
            
              return cell }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        guard let flowLayout = myCollectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return}
        flowLayout.itemSize = myCollectionView.bounds.size

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
    //        self.myCollectionView.reloadData()
            self.myCollectionView.setContentOffset(newOffset, animated: false)
            
        },
            completion: nil)
        
      }
}
    
