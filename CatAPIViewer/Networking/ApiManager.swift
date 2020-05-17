//
//  ApiManager.swift
//  CatAPIViewer
//
//  Created by Alexey on 5/7/20.
//  Copyright © 2020 Alexey. All rights reserved.
//

import UIKit

class APIManager {
//    private let apiKey = "1333c8f6-fa50-4689-94ff-42b566bc2aed"
//    let limit = "100"
//    let page = "1"
//    let urlStringGetBreeds = "https://api.thecatapi.com/v1/breeds?x-api-key="
//    let urlStringGetImages = "https://api.thecatapi.com/v1/images/search?x-api-key="
//    let urlStringGetBreed = "https://api.thecatapi.com/v1/images/search?breed_ids="
//    
//     func getBreeds(completion: @escaping (_ breeds: [Breed]?, _ error: Error?) -> Void) {
//        getJSONFromURL(urlString: urlStringGetBreeds + apiKey) { (data, error) in
//            guard let data = data, error == nil else {
//                print("Failed to get data")
//                return completion(nil, error)
//            }
//            self.createBreedsObjectWith(json: data, completion: { (breeds, error) in
//                if let error = error {
//                    print("Failed to convert data")
//                    return completion(nil, error)
//                }
//                return completion(breeds, nil)
//            })
//        }
//    }
    
//    func getImages(completion: @escaping (_ imagesCats: [ImageCAT]?, _ error: Error?) -> Void) {
//        getJSONFromURL(urlString: urlStringGetImages + apiKey + "&limit=" + limit) { (data, error) in
//            guard let data = data, error == nil else {
//                print("Failed to get data")
//                return completion(nil, error)
//            }
//            self.createImagesObjectWith(json: data, completion: { (imagesCats, error) in
//                if let error = error {
//                    print("Failed to convert data")
//                    return completion(nil, error)
//                }
//                return completion(imagesCats, nil)
//            })
//
//
//        }
//    }
    
//    func getImageBreedForDescription(breedID: String, completion: @escaping (_ imageURL: String?, _ error: Error?) -> Void) {
//
//        getJSONFromURL(urlString: urlStringGetBreed + breedID) { (data, error) in
//             guard let data = data, error == nil else {
//                 print("Failed to get data 😢")
//                 return completion(nil, error)
//             }
//              let aliy_json = String(decoding: data, as: UTF8.self)
//       //       let draftURL = aliy_json.components(separatedBy: "url\":\"").last?.components(separatedBy: ",").first
//              let imageURL = aliy_json.components(separatedBy: "url\":\"").last?.components(separatedBy: "\"").first
//              return completion(imageURL, nil)
//        }
//
//    }
    
//    func fetchImage(from urlString: String, completion: @escaping (_ data: Data?) -> ()) {
//        let session = URLSession.shared
//
//        guard let url = URL(string: urlString) else {
//            print("Error: Cannot create URL from string")
//            return
//        }
//        let urlRequest = URLRequest(url: url)
//        let dataTask = session.dataTask(with: urlRequest) { (data, response, error) in
//            if error != nil {
//                print("Error fetching the image!")
//                completion(nil)
//            } else {
//                completion(data)
//            }
//
//        }
//        dataTask.resume()
//    }
    
}

extension APIManager {
//private func getJSONFromURL(urlString: String, completion: @escaping (_ data: Data?, _ error: Error?) -> Void) {
//    guard let url = URL(string: urlString) else {
//        print("Error: Cannot create URL from string")
//        return
//    }
//    let urlRequest = URLRequest(url: url)
//    let task = URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
//        guard error == nil else {
//            print("Error calling api")
//            return completion(nil, error)
//        }
//        guard let responseData = data else {
//            print("Data is nil")
//            return completion(nil, error)
//        }
//        completion(responseData, nil)
//    }
//    task.resume()
//}

//private func createBreedsObjectWith(json: Data, completion: @escaping (_ data: [Breed]?, _ error: Error?) -> Void) {
//        do {
//            let decoder = JSONDecoder()
//         //   decoder.keyDecodingStrategy = .convertFromSnakeCase
//            let breeds = try decoder.decode([Breed].self, from: json)
//            return completion(breeds, nil)
//        } catch let error {
//            print("Error creating breeds from JSON because: \(error.localizedDescription)")
//            return completion(nil, error)
//        }
//    }

//private func createImagesObjectWith(json: Data, completion: @escaping (_ data: [ImageCAT]?, _ error: Error?) -> Void) {
//        do {
//            let decoder = JSONDecoder()
//         //   decoder.keyDecodingStrategy = .convertFromSnakeCase
//            let imagesCats = try decoder.decode([ImageCAT].self, from: json)
//            return completion(imagesCats, nil)
//        } catch let error {
//            print("Error creating images from JSON because: \(error.localizedDescription)")
//            return completion(nil, error)
//        }
//}

//    private func createObjectFromJSON<T: Codable>(json: Data, completion: @escaping (_ data: T?, _ error: Error?) -> Void) {
//            do {
//                let decoder = JSONDecoder()
//             //   decoder.keyDecodingStrategy = .convertFromSnakeCase
//                let obj = try decoder.decode(T.self, from: json)
//                return completion(obj, nil)
//            } catch let error {
//                print("Error creating images from JSON because: \(error.localizedDescription)")
//                return completion(nil, error)
//            }
//    }
//
    
}
