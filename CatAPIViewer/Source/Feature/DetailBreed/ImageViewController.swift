//
//  ImageViewController.swift
//  CatAPIViewer
//
//  Created by Alexey on 5/4/20.
//  Copyright © 2020 Alexey. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {

  //  var listOfImagesCat = [imagesCAT]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
   func showActivityIndicatory(uiView: UIView) {
        let container: UIView = UIView()
        container.frame = CGRect(x: 0, y: 0, width: 80, height: 80) // Set X and Y whatever you want
        container.backgroundColor = .clear

    // let activityView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    let activityView = UIActivityIndicatorView(style: .large)
        activityView.center = self.view.center
        activityView.startAnimating()


        container.addSubview(activityView)
        self.view.addSubview(container)
        activityView.startAnimating()
    }
    
}
