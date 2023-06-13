//
//  Resources.swift
//  GetPhotos
//
//  Created by vasiario on 13.06.2023.
//

import UIKit

enum Resources {

  /**
   Названия полей, используемых в приложении.
   */
  enum FieldsName: String, CaseIterable {
    case id = "id"
    case description = "описание"
    case authorName = "Автор:"
    case madeDate = "Дата создания:"
    case location = "Местоположение:"
    case downloads = "Скачиваний:"
  }

  /**
   Шрифты, используемые в приложении.
   */
  enum Fonts {

    /**
     Возвращает шрифт Avenir Next с заданным размером.

     - Parameter size: Размер шрифта.
     - Returns: Шрифт Avenir Next с заданным размером.
     */
    static func avenirNextRegular(with size: CGFloat) -> UIFont? {
      UIFont(name: "HelveticaNeue", size: size)
    }
  }
}
