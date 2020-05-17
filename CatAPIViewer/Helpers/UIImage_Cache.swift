//
//  UIImage_Cache.swift
//  CatAPIViewer
//
//  Created by Alexey on 5/15/20.
//  Copyright © 2020 Alexey. All rights reserved.
//
import Foundation
import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    
    func loadImage(urlString: String) {
        let url = URL(string: urlString)
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlString as NSString) {
            self.image = imageFromCache
            return
        }
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if let response = data {
                DispatchQueue.main.async {
                    let imageToCache = UIImage(data: response)
                    imageCache.setObject(imageToCache!, forKey: urlString as NSString)
                    self.image = imageToCache
                    
                }
            }
        }.resume()
    }
    
    
}
