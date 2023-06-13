//
//  NetworkDetailServise.swift
//  GetPhotos
//
//  Created by vasiario on 13.06.2023.
//

import UIKit

class NetworkDetailServise {

  // MARK: - Search Requests for Photo details in DetailViewController

  // Функция для отправки запроса данных о фотографии по URL
  func request(photoId: String, completion: @escaping (Data?, Error?) -> Void) {
    guard let url = prepareURL(photoId: photoId) else { return }
    var request = URLRequest(url: url)
    request.allHTTPHeaderFields = prepareHeader()
    request.httpMethod = "GET"
    let task = createDataTask(from: request, completion: completion)
    task.resume()
  }

  // Функция для подготовки URL для запроса данных о фотографии
  private func prepareURL(photoId: String) -> URL? {
    let urlString = "https://api.unsplash.com/photos/" + photoId
    guard let preparedURL = URL(string: urlString) else { return nil }
    return preparedURL
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
      DispatchQueue.main.async {
        completion(data, error)
      }
    }
  }
}
