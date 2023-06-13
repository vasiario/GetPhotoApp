//
//  PhotosCell.swift
//  PhotoAppWithUnsplash
//
//  Created by Павел Афанасьев on 04.10.2022.
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
    
    var unsplashPhoto: UnsplasPhotos! {
        didSet {
            let photosUrl = unsplashPhoto.urls["regular"]
            guard let imageUrl = photosUrl, let url = URL(string: imageUrl) else { return }
            // Загружаем с помощью внешней библиотеки SDWebImage фото из сети
            photosImageView.sd_setImage(with: url)
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
        // Обнуляем изображение для целей отсутствия наслоения изображений при использование переиспользуемых ячеек
        photosImageView.image = nil
    }
    
    private func setupImageView() {
        addViews(photosImageView)
        
        NSLayoutConstraint.activate([
            photosImageView.topAnchor.constraint(equalTo: self.topAnchor),
            photosImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            photosImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            photosImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
