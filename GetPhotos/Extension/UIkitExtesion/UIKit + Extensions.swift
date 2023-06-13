//
//  UIKit + Extensions.swift
//  GetPhotos
//
//  Created by vasiario on 13.06.2023.
//

import UIKit

extension UIView {

  func addViews(_ view: UIView){
    self.addSubview(view)
    view.translatesAutoresizingMaskIntoConstraints = false
  }

  func setUpLabel(text: String, fontSize: CGFloat) -> UILabel {
    let label = UILabel()
    label.text = text
    label.font = Resources.Fonts.avenirNextRegular(with: fontSize)
    return label
  }
}
