//
//  ApiNetworkCall.swift
//  PrepCrypto
//
//  Created by suryansh Bisen on 12/08/22.
//

import Foundation

class ApiNetworkCall {
    
    static func apiCall<T: Decodable>(_ type: T.Type, url: URLRequest, complition: @escaping (Result<T, Error>) -> Void){
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: url) { data, response, error in
            
            print(data?.description as Any)
            print(data.debugDescription)
            
            do{
                let deocder = JSONDecoder()
                let decodableResponce = try deocder.decode(type.self, from: data!)
                
                complition(Result.success(decodableResponce))
                
                print(decodableResponce)
            }catch{
                print(error)
                complition(Result.failure(error))
            }
            
            
        }
        
        dataTask.resume()
    }

    
}
