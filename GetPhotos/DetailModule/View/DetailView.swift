//
//  DetailView.swift
//  PhotoAppWithUnsplash
//
//  Created by Павел Афанасьев on 27.10.2022.
//

import UIKit
import SDWebImage

class DetailView: UIView {
    
    private lazy var downloadsLabel = setUpLabel(text: "Скачиваний:", fontSize: 15)
    lazy var downloadsCountLabel = setUpLabel(text: "", fontSize: 15)
    private lazy var photoLocationLabel = setUpLabel(text: "Местоположение:", fontSize: 15)
    lazy var photoLocation = setUpLabel(text: "", fontSize: 15)
    private lazy var madeDate = setUpLabel(text: "Дата создания:", fontSize: 15)
    lazy var photoMadeData = setUpLabel(text: "", fontSize: 15)
    private lazy var author = setUpLabel(text: "Автор:", fontSize: 15)
    lazy var authorName = setUpLabel(text: "", fontSize: 15)
        
    var photoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage())
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    var likeButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 15, height: 15))
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        [downloadsLabel, downloadsCountLabel, photoLocationLabel, photoLocation, madeDate, photoMadeData, author, authorName, likeButton, photoImageView].forEach{ addViews($0) }
        
        photoLocation.numberOfLines = 0
    }
}

//MARK: - Set Constraints

extension DetailView {
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            downloadsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            downloadsLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            
            downloadsCountLabel.leadingAnchor.constraint(equalTo: downloadsLabel.trailingAnchor, constant: 10),
            downloadsCountLabel.bottomAnchor.constraint(equalTo: downloadsLabel.bottomAnchor),
            
            photoLocationLabel.leadingAnchor.constraint(equalTo: downloadsLabel.leadingAnchor),
            photoLocationLabel.topAnchor.constraint(equalTo: photoLocation.topAnchor),
            
            photoLocation.leadingAnchor.constraint(equalTo: photoLocationLabel.trailingAnchor, constant: 10),
            photoLocation.bottomAnchor.constraint(equalTo: downloadsLabel.topAnchor, constant:  -10),
            photoLocation.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            madeDate.leadingAnchor.constraint(equalTo: downloadsLabel.leadingAnchor),
            madeDate.bottomAnchor.constraint(equalTo: photoLocationLabel.topAnchor,constant: -10),
            
            photoMadeData.leadingAnchor.constraint(equalTo: madeDate.trailingAnchor, constant: 10),
            photoMadeData.bottomAnchor.constraint(equalTo: madeDate.bottomAnchor),
            
            author.leadingAnchor.constraint(equalTo: downloadsLabel.leadingAnchor),
            author.bottomAnchor.constraint(equalTo: madeDate.topAnchor, constant: -10),
            
            authorName.leadingAnchor.constraint(equalTo: author.trailingAnchor, constant: 10),
            authorName.bottomAnchor.constraint(equalTo: author.bottomAnchor),
            
            likeButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            likeButton.bottomAnchor.constraint(equalTo: author.topAnchor, constant: -10),
            
            photoImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            photoImageView.topAnchor.constraint(equalTo: topAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant:  -5),
            photoImageView.bottomAnchor.constraint(equalTo: likeButton.topAnchor, constant: -20)
        ])
    }
}
