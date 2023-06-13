//
//  FavoriteTableViewCell.swift
//  PhotoAppWithUnsplash
//
//  Created by Павел Афанасьев on 12.10.2022.
//

import UIKit

class FavouriteTableViewCell: UITableViewCell {
        
    static let cellId = "FavouriteTableViewCell"
    
    var photoImage: UIImageView = {
        let image = UIImage(named: "test")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    var authorName: UILabel = {
        let label = UILabel()
        label.text = "Author Name"
        label.font = .systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    var unsplashPhoto: DetailResults! {
        didSet {
            let photosUrl = unsplashPhoto.urls["regular"]
            guard let imageUrl = photosUrl, let url = URL(string: imageUrl) else { return }
            // Загружаем с помощью внешней библиотеки SDWebImage фото из сети
            photoImage.sd_setImage(with: url)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addViews(photoImage)
        addViews(authorName)
        
        NSLayoutConstraint.activate([
            photoImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            photoImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            photoImage.heightAnchor.constraint(equalToConstant: 90),
            photoImage.widthAnchor.constraint(equalToConstant: 90),
            
            authorName.centerYAnchor.constraint(equalTo: photoImage.centerYAnchor),
            authorName.leadingAnchor.constraint(equalTo: photoImage.trailingAnchor, constant: 10)
        ])
    }
}
