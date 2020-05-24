//
//  AppConfing.swift
//  CatAPIViewer
//
//  Created by Alexey on 5/15/20.
//  Copyright © 2020 Alexey. All rights reserved.
//

import Foundation

enum paragraph: String {
    case breeds = "breeds"
    case images = "images/search"
  
}

final class APIConfig {
    let apiKey = "API KEY"
    let limit = "100"
    let page = 1
    let breed_ids = "breed_ids"
    let host = "api.thecatapi.com"
    
    var baseURL: URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = host
        return urlComponents
    }
    
    func fetchURL<T: LosslessStringConvertible>(with resources: paragraph, parameters: [String: T ]) -> URL? {
        var urlComponents = baseURL
        print(resources)
        urlComponents.path = "/v1/\(resources.rawValue)"
        urlComponents.setQueryItems(with: parameters)
        guard let url = urlComponents.url else {
            print("Error create url")
            return nil
        }
        
        return url
       
    }
    
}

extension URLComponents {
    mutating func setQueryItems<T: LosslessStringConvertible>(with parameters: [String: T]) {
                      self.queryItems = parameters.map { URLQueryItem(name: $0.key, value: String($0.value)) }
                  }
}

