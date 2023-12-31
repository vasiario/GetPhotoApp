//
//  PhotosCollectionViewController.swift
//  GetPhotos
//
//  Created by vasiario on 13.06.2023.
//

import UIKit

class PhotosCollectionViewController: UICollectionViewController {
  
  private var networkDataFetcher = NetworkDataFetcher()
  private var networkDetailDataFetcher = NetworkDetailDataFetcher()
  
  private var timer: Timer?  // Таймер для задержки запроса
  
  private var photos = [UnsplasPhotos]()  // Массив загруженных фотографий
  private var photoDetails: DetailResults?  // Детали выбранной фотографии
  
  private let itemPerRow: CGFloat = 2  // Количество ячеек в строке
  private let sectionInserts = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)  // Отступы между ячейками
  
  let destinationVC = DetailViewController()
  
  override func viewDidLoad() {
    setupCollectionView()
    setupSearchBar()
  }
  
  private func setupCollectionView() {
    collectionView.backgroundColor = .white
    collectionView.register(PhotosCell.self, forCellWithReuseIdentifier: PhotosCell.cellId)
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.layoutMargins = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    collectionView.contentInsetAdjustmentBehavior = .automatic
  }
  
  private func setupSearchBar() {
    let searchBar = UISearchBar()
    searchBar.delegate = self
    navigationItem.titleView = searchBar
  }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate

extension PhotosCollectionViewController {
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return photos.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCell.cellId, for: indexPath) as? PhotosCell
    let unsplashPhoto = photos[indexPath.item]
    cell?.unsplashPhoto = unsplashPhoto
    if let cell {
      return cell
    }
    return UICollectionViewCell()
  }
  
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let currentImage = photos[indexPath.item]
    let photoID = currentImage.id
    
    networkDetailDataFetcher.fetchData(photoId: photoID) { [weak self] detailResult in
      guard let fetchedDetailsPhoto = detailResult else { return }
      
      self?.photoDetails = fetchedDetailsPhoto
      self?.destinationVC.incomePhotoDetails = self?.photoDetails
      self?.destinationVC.reloadLikeButton()
      
      if let navigationController = self?.navigationController {
        if navigationController.viewControllers.contains(self!.destinationVC) {
          navigationController.popToViewController(self!.destinationVC, animated: true)
        } else {
          navigationController.pushViewController(self!.destinationVC, animated: true)
        }
      }
    }
  }
}

// MARK: - UISearchBarDelegate

extension PhotosCollectionViewController: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    timer?.invalidate()  // Сбрасываем предыдущий таймер, чтобы не делать лишние запросы
    
    timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { [weak self] (_) in
      self?.networkDataFetcher.fetchData(searchTerm: searchText) { [weak self] (searchResults) in
        guard let fetchedPhotos = searchResults else { return }
        self?.photos = fetchedPhotos.results
        self?.collectionView.reloadData()
      }
    })
  }
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    searchBar.resignFirstResponder()  // Скрыть клавиатуру по нажатию на кнопку Search на клавиатуре
  }
}
// MARK: - UICollectionViewDelegateFlowLayout

extension PhotosCollectionViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let photo = photos[indexPath.item]
    let paddingSpace = sectionInserts.left * (itemPerRow + 1)
    let availableWidth = collectionView.frame.width - paddingSpace
    let widthPerItem = availableWidth / itemPerRow
    let height = CGFloat(photo.height) * widthPerItem / CGFloat(photo.width)
    return CGSize(width: widthPerItem, height: height)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return sectionInserts
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return sectionInserts.left
  }
}
