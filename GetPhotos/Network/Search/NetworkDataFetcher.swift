//
//  NetworkDataFetcher.swift
//  GetPhotos
//
//  Created by vasiario on 13.06.2023.
//

import UIKit

class NetworkDataFetcher {

  var networkService = NetworkService()

  // Функция для получения данных с сервера по заданному поисковому запросу
  func fetchData(searchTerm: String, completion: @escaping (SearchResults?) -> ()) {
    networkService.request(searchTerm: searchTerm) { (data, error) in
      if let error = error {
        print(error.localizedDescription)
        completion(nil)
      }
      let decodedData = self.decodeJSON(type: SearchResults.self, from: data)
      completion(decodedData)
    }
  }

  // Универсальная функция для декодирования JSON-данных в объект заданного типа
  func decodeJSON<T: Decodable>(type: T.Type, from data: Data?) -> T? {
    let decoder = JSONDecoder()
    guard let data = data else { return nil }
    do {
      let decodedObjects = try decoder.decode(type.self, from: data)
      return decodedObjects
    } catch let error {
      print(error)
      return nil
    }
  }
}
