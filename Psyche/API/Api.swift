//
//  File.swift
//  Psyche
//
//  Created by Madhukar Raj on 1/16/19.
//  Copyright © 2019 ASU. All rights reserved.
//

import Foundation

class Apicall: GalleryViewController {
    enum Result<Value> {
        case success(Value)
        case failure(Error)
    }
    
   class func getRequest(for userId: Int, completion: ((Result<[GalleryStruct]>) -> Void)?) {
        let url = URL(string: "https://test-psyche.ws.asu.edu/wp-json/psyche/v1/gallery")!
        let request = URLRequest(url: url)        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) { (responseData, response, responseError) in
            DispatchQueue.main.async {
                if let error = responseError {
                    completion?(.failure(error))
                } else if let jsonData = responseData {
                    let decoder = JSONDecoder()
                    do {
                        let galleryData = try decoder.decode([GalleryStruct].self, from: jsonData)
                        completion?(.success(galleryData))
                    } catch {
                        completion?(.failure(error))
                    }
                } else {
                    let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Data was not retrieved from request"]) as Error
                    completion?(.failure(error))
                }
            }
        }
        
        task.resume()
    }

}

