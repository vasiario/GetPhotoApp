//
//  PhotosCell.swift
//  GetPhotos
//
//  Created by vasiario on 13.06.2023.
//

import UIKit
import SDWebImage

class PhotosCell: UICollectionViewCell {

  static let cellId = "PhotosCell"

  private let photosImageView: UIImageView = {
    let image = UIImage()
    let photoImage = UIImageView(image: image)
    photoImage.backgroundColor = .gray
    photoImage.contentMode = .scaleAspectFill
    return photoImage
  }()

  var unsplashPhoto: UnsplasPhotos? {
    didSet {
      let photosUrl = unsplashPhoto?.urls["regular"]
      guard let imageUrl = photosUrl, let url = URL(string: imageUrl) else { return }
      photosImageView.sd_setImage(with: url)  // Используем SDWebImage для загрузки фото из сети
    }
  }

  override init(frame: CGRect) {
    super.init(frame: frame)

    setupImageView()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    photosImageView.image = nil  // Обнуляем изображение для предотвращения наложения изображений при использовании переиспользуемых ячеек
  }

  private func setupImageView() {
    addSubview(photosImageView)  // Вместо addViews используем addSubview

    photosImageView.translatesAutoresizingMaskIntoConstraints = false  // Устанавливаем флаг `translatesAutoresizingMaskIntoConstraints` в false, чтобы использовать Auto Layout

    NSLayoutConstraint.activate([
      photosImageView.topAnchor.constraint(equalTo: self.topAnchor),
      photosImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      photosImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      photosImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
    ])
  }
}
