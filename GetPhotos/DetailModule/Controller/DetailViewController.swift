//
//  DetailViewController.swift
//  GetPhotos
//
//  Created by vasiario on 13.06.2023.
//

import UIKit

// Протокол для передачи данных из DetailViewController
protocol DetailViewControllerProtocol: AnyObject {
  func sentData(details: DetailResults)
}

class DetailViewController: UIViewController {
  
  // Слабая ссылка на делегата DetailViewControllerProtocol
  weak var detailViewControllerDelegate: DetailViewControllerProtocol?
  
  // Экземпляр DetailView
  private let detailView = DetailView()
  
  // Флаг, указывающий, была ли нажата кнопка Like
  private var likeButtonIsTapped = false
  
  // Переменная для хранения полученных данных
  var incomePhotoDetails: DetailResults?
  
  // Модель данных для отображения деталей фото
  var unsplashPhoto: DetailResults! {
    didSet {
      let photosUrl = unsplashPhoto.urls["regular"]
      guard let imageUrl = photosUrl, let url = URL(string: imageUrl) else { return }
      // Загружаем фото из сети с помощью библиотеки SDWebImage
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
  
  // Настройка представлений
  private func setupViews() {
    view.addViews(detailView)
    
    // Заполнение деталей фото данными
    guard let incomeDetails = incomePhotoDetails else { return }
    detailView.downloadsCountLabel.text = String(incomeDetails.downloads)
    detailView.photoLocation.text = incomeDetails.location?.name
    detailView.photoMadeData.text = incomeDetails.created_at
    detailView.authorName.text = incomeDetails.user.name
    unsplashPhoto = incomeDetails
  }
  
  // Настройка жеста для кнопки Like
  private func setupGesture() {
    let tapOnLikeButton = UITapGestureRecognizer(target: self, action: #selector(likeButtonTapped))
    detailView.likeButton.addGestureRecognizer(tapOnLikeButton)
  }
  
  // Метод для сброса состояния кнопки Like
  func reloadLikeButton() {
    detailView.likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
    likeButtonIsTapped = false
  }
  
  // Обработчик нажатия кнопки Like
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
  
  // Установка ограничений для DetailView
  private func setConstraints() {
    NSLayoutConstraint.activate([
      detailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      detailView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      detailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      detailView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
    ])
  }
}
