//
//  NetworkService.swift
//  GetPhotos
//
//  Created by vasiario on 13.06.2023.
//

import UIKit

class NetworkService {

  // MARK: - Search Requests from start View Controller

  // Функция для отправки запроса данных по URL
  func request(searchTerm: String, completion: @escaping (Data?, Error?) -> Void) {
    let params = prepareParams(searchTerm: searchTerm)
    let url = createURL(params: params)
    var request = URLRequest(url: url!)
    request.allHTTPHeaderFields = prepareHeader()
    request.httpMethod = "GET"
    let task = createDataTask(from: request, completion: completion)
    task.resume()
  }

  // Функция для подготовки параметров запроса
  private func prepareParams(searchTerm: String?) -> [String: String] {
    var params = [String: String]()
    params["query"] = searchTerm
    params["page"] = String(1)
    params["per_page"] = String(30)
    return params
  }

  // Функция для создания URL с использованием URLComponents
  private func createURL(params: [String: String]) -> URL? {
    var components = URLComponents()
    components.scheme = "https"
    components.host = "api.unsplash.com"
    components.path = "/search/photos"
    components.queryItems = params.map { URLQueryItem(name: $0, value: $1) }
    return components.url
  }

  // Функция для подготовки заголовка запроса - с кодом авторизации
  private func prepareHeader() -> [String: String]? {
    var header = [String: String]()
    header["Authorization"] = "Client-ID BiO51U9-KINVo6s68HN0ZgauwODybopLJYoVakbdzFw"
    return header
  }

  // Функция для создания URLSessionDataTask
  private func createDataTask(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
    return URLSession.shared.dataTask(with: request) { data, response, error in
      // Вызываем completion в главном потоке для обновления пользовательского интерфейса
      DispatchQueue.main.async {
        completion(data, error)
      }
    }
  }
}
