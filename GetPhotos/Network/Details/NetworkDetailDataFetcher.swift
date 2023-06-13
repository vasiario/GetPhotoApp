//
//  NatworkDetailDataFetcher.swift
//  GetPhotos
//
//  Created by vasiario on 13.06.2023.
//

import UIKit

class NetworkDetailDataFetcher {
    
    var networkDetailService = NetworkDetailServise()

    func fetchData(photoId: String, complition: @escaping (DetailResults?) -> ()){
        networkDetailService.request(photoId: photoId) { (data, error) in
            if let error = error {
                print(error.localizedDescription)
                complition(nil)
            }
            let decode = self.decodeJSON(type: DetailResults.self, from: data)
            complition(decode)
        }
    }

    // Универсальная функция позволяющая использовать любую модель данных, должна быть подписана под протокол Decodable
    func decodeJSON<T:Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = from else {return nil}
        do {
            let objects = try decoder.decode(type.self, from: data)
            return objects
        } catch let error {
            print(error)
            return nil
        }
    }
}


