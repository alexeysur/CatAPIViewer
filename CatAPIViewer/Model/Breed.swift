//
//  Breed.swift
//  CatAPIViewer
//
//  Created by Alexey on 5/15/20.
//  Copyright © 2020 Alexey. All rights reserved.
//

import Foundation

struct Breed: Codable {
   let id: String
   let name: String
   let description: String
   let temperament: String
   let life_span: String
 
   enum CodingKeys: String, CodingKey {
       case id
       case name
       case description
       case temperament
       case life_span
   }
   
   init() {
       id = ""
       name = ""
       description = ""
       temperament = ""
       life_span = ""
   }
   
}
