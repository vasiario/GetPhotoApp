//
//  SearchResults.swift
//  GetPhotos
//
//  Created by vasiario on 13.06.2023.
//

import UIKit

// Структура, представляющая результаты поиска
struct SearchResults: Decodable {
  let total: Int // Общее количество результатов
  let results: [UnsplasPhotos] // Массив фотографий, полученных в результате поиска
}

// Структура, представляющая информацию о фотографии на Unsplash
struct UnsplasPhotos: Decodable {
  let id: String // Идентификатор фотографии
  let width: Int // Ширина фотографии
  let height: Int // Высота фотографии
  let urls: [UrlKind.RawValue: String] // URL-адреса фотографии разных размеров
  let user: UserInfo // Информация о пользователе, загрузившем фотографию

  // Перечисление для различных типов URL-адресов фотографии
  enum UrlKind: String {
    case raw
    case full
    case regular
    case small
    case thumb
  }
}

// Структура, представляющая информацию о пользователе
struct UserInfo: Decodable {
  let name: String // Имя пользователя
}
