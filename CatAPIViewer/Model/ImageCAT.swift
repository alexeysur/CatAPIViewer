//
//  ImageCAT.swift
//  CatAPIViewer
//
//  Created by Alexey on 5/15/20.
//  Copyright © 2020 Alexey. All rights reserved.
//

import Foundation

struct ImageCAT: Codable {
    let id: String
    let url: String
    
    enum CodingKeys: String, CodingKey {
           case id
           case url
    }
       
       init() {
           id = ""
           url = ""
       }
}
