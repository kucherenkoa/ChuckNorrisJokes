//
//  NetworkService.swift
//  ChuckNorrisJokes
//
//  Created by Andrei Kucherenko on 29.12.2019.
//  Copyright © 2019 Andrei Kucherenko. All rights reserved.
//

import Foundation
import Alamofire

class NetworkService {
    
    func fetchJokes (jokesNumbers: Int, completion: @escaping (JokesResponse?) -> Void ) {
        let jokesURL = "http://api.icndb.com/jokes/random/\(jokesNumbers)"
        
        AF.request(jokesURL, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseData { (dataResponse) in
            if let error = dataResponse.error {
                print("Error recieved requesting data: \(error.localizedDescription)")
                completion(nil)
            }
            guard let data = dataResponse.data else { return }
            
            let decoder = JSONDecoder()
            do {
                let objects = try decoder.decode(JokesResponse.self, from: data)
                completion(objects)
            } catch  let jsonError {
                print("Failed to decode JSON", jsonError)
                completion(nil)
            }
            
        }
  
    }

}
