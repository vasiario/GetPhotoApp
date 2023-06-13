//
//  UIKit + Extensions.swift
//  GetPhotos
//
//  Created by vasiario on 13.06.2023.
//

import UIKit

extension UIView {

  // Метод для добавления подпредставления к текущему представлению
  func addViews(_ view: UIView){
    self.addSubview(view)
    view.translatesAutoresizingMaskIntoConstraints = false
  }

  // Метод для настройки метки (UILabel) с заданным текстом и размером шрифта
  func setUpLabel(text: String, fontSize: CGFloat) -> UILabel {
    let label = UILabel()
    label.text = text
    label.font = Resources.Fonts.avenirNextRegular(with: fontSize)
    return label
  }
}
