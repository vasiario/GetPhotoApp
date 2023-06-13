//
//  NetworkDataFetcher.swift
//  GetPhotos
//
//  Created by vasiario on 13.06.2023.
//

import UIKit

class NetworkDataFetcher {
    
    var networkService = NetworkService()
    
    func fetchData(searchTerm: String, complition: @escaping (SearchResults?) -> ()){
        networkService.request(searchTerm: searchTerm) { (data, error) in
            if let error = error {
                print(error.localizedDescription)
                complition(nil)
            }
            let decode = self.decodeJSON(type: SearchResults.self, from: data)
            complition(decode)
        }
    }
    
    // Универсальная функция для использования любой модели данных,должна быть подписана под протокол Decodable
    func decodeJSON<T:Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = from else { return nil}
        do {
            let objects = try decoder.decode(type.self, from: data)
            return objects
        } catch let error {
            print(error)
            return nil
        }
    }
}
