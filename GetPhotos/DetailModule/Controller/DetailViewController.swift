//
//  DetailViewController.swift
//  PhotoAppWithUnsplash
//
//  Created by Павел Афанасьев on 27.10.2022.
//

import UIKit

protocol DetailViewControllerProtocol: AnyObject {
    func sentData(details: DetailResults)
}

class DetailViewController: UIViewController {
    
    weak var detailViewControllerDelegate: DetailViewControllerProtocol?
    
    private let detailView = DetailView()
    
    private var likeButtonIsTapped = false
    
    var incomePhotoDetails: DetailResults?
    
    var unsplashPhoto: DetailResults! {
        didSet {
            let photosUrl = unsplashPhoto.urls["regular"]
            guard let imageUrl = photosUrl, let url = URL(string: imageUrl) else { return }
            // Загружаем с помощью внешней библиотеки SDWebImage фото из сети
            detailView.photoImageView.sd_setImage(with: url)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupViews()
        setConstraints()
        setupGesture()
    }
    
//    override func viewDidDisappear(_ animated: Bool) {
//        super.viewDidDisappear(animated)
//
//        reloadLikeButton()
//    }
    
    private func setupViews() {
        view.addViews(detailView)
        
        guard let incomeDetails = incomePhotoDetails else { return }
        detailView.downloadsCountLabel.text = String(incomeDetails.downloads)
        detailView.photoLocation.text = incomeDetails.location?.name
        detailView.photoMadeData.text = incomeDetails.created_at
        detailView.authorName.text = incomeDetails.user.name
        unsplashPhoto = incomeDetails
    }
    
    private func setupGesture() {
        let tapOnLikeButton = UITapGestureRecognizer(target: self, action: #selector (likeButtonTapped))
        detailView.likeButton.addGestureRecognizer(tapOnLikeButton)
    }
    
    func reloadLikeButton() {
        detailView.likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        likeButtonIsTapped = false
    }
    
    @objc func likeButtonTapped() {
        guard let incomeDetails = incomePhotoDetails else { return }
        if !likeButtonIsTapped {
            detailView.likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            likeButtonIsTapped = true
            detailViewControllerDelegate?.sentData(details: incomeDetails)
            print(incomeDetails.user.name)

        } else {
            detailView.likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
            likeButtonIsTapped = false
        }
    }
}

//MARK: - Set Constraints

extension DetailViewController {
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            detailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            detailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            detailView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
