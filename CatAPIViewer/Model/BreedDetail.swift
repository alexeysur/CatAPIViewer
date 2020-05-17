//
//  BreedDetail.swift
//  CatAPIViewer
//
//  Created by Alexey on 5/17/20.
//  Copyright © 2020 Alexey. All rights reserved.
//

import Foundation

struct BreedDetail: Codable {
    let breeds: [Breed]?
    let url: String?
    
   enum CodingKeys: String, CodingKey {
       case breeds = "breeds"
       case url = "url"
   }
   
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        breeds = try container.decodeIfPresent([Breed].self, forKey: .breeds)
        url = try container.decodeIfPresent(String.self, forKey: .url)
    }
}
