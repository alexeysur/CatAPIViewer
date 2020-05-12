//
//  Model.swift
//  CatAPIViewer
//
//  Created by Alexey on 5/5/20.
//  Copyright © 2020 Alexey. All rights reserved.
//

import Foundation

struct Breed: Codable {
    let id: String
    let name: String
    let description: String
    let temperament: String
    let origin: String //country
    let life_span: String
  
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case temperament
        case origin
        case life_span
    }
    
    init() {
        id = ""
        name = ""
        description = ""
        temperament = ""
        origin = ""
        life_span = ""
    }
    
 }


struct ImageCAT: Codable {
    let id: String
    let url: String
    let width: Int
    let height: Int
    
    enum CodingKeys: String, CodingKey {
           case id
           case url
           case width
           case height
       }
       
       init() {
           id = ""
           url = ""
           width = 0
           height = 0
       }
}

//struct Breeds: Codable {
//    var listOfBreeds: [Breed]
//}
//
//struct imagesCAT {
//    var listOfImagesCats: [ImageCAT]
//}
