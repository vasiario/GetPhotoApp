//
//  DetailResults.swift
//  GetPhotos
//
//  Created by vasiario on 13.06.2023.
//

import UIKit

// Структура, представляющая детальные результаты с информацией о фотографии
struct DetailResults: Decodable {
  let id: String
  let urls: [UrlKind.RawValue: String]
  let location: Location? // Дополнительная информация о местоположении фотографии
  let downloads: Int
  let created_at: String
  let user: User // Информация о пользователе, загрузившем фотографию

  // Перечисление для различных типов URL-адресов фотографии
  enum UrlKind: String {
    case raw
    case full
    case regular
    case small
    case thumb
  }
}

// Структура, представляющая информацию о местоположении фотографии
struct Location: Decodable {
  let name: String?
}

// Структура, представляющая информацию о пользователе
struct User: Decodable {
  let name: String
}
