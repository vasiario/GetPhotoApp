//
//  PhotosCollectionViewController.swift
//  PhotoAppWithUnsplash
//
//  Created by Павел Афанасьев on 29.09.2022.
//

import UIKit

class PhotosCollectionViewController: UICollectionViewController {
    
    
    private var networkDataFetcher = NetworkDataFetcher()
    private var networkDetailDataFetcher = NetworkDetailDataFetcher()
        
    // Используем таймер для того, чтобы запрос на сервер не улетал после каждой буквы в поисковой строке и сделаем зарежку
    private var timer: Timer?
    
    // Массив где будут храниться все загружаемые изображения
    private var photos = [UnsplasPhotos]()
    
    // Переменная где будет храниться вся информация с деталями по изображению
    private var photoDetails: DetailResults?
    
    // Отступы для настройки ячеек
    private let itemPerRow: CGFloat = 2
    private let sectionInserts = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    
    let destinationVC = DetailViewController()

    override func viewDidLoad() {
        setupCollectionView()
        setupSearchBar()
    }
    
    private func setupCollectionView() {
        self.collectionView.backgroundColor = .white
        self.collectionView.register(PhotosCell.self, forCellWithReuseIdentifier: PhotosCell.cellId)
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.layoutMargins =  UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        self.collectionView.contentInsetAdjustmentBehavior = .automatic
    }
    
    private func setupSearchBar() {
        let searchBar = UISearchBar()
        navigationItem.titleView = searchBar
        searchBar.delegate = self
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate

extension PhotosCollectionViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCell.cellId, for: indexPath) as! PhotosCell
        let unsplashPhoto = photos[indexPath.item]
        cell.unsplashPhoto = unsplashPhoto
        return cell
    }
    
    // Открываем по тапу на ячейку окно детальной информации и заполняем его данными
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let currentImage = photos[indexPath.item]
        let photoID = currentImage.id
        networkDetailDataFetcher.fetchData(photoId: photoID) { detailResult in
            guard let fetchedDetailsPhoto = detailResult else { return }
            self.photoDetails = fetchedDetailsPhoto
            self.destinationVC.incomePhotoDetails = self.photoDetails
            self.destinationVC.reloadLikeButton()
            self.navigationController?.pushViewController(self.destinationVC, animated: true)
        }
    }
}

// MARK: - UISearchBarDelegate

extension PhotosCollectionViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { (_) in
            // Поскольку ниже мы будем вызывать функцию в функции - для избежания утечек памяти делаем [weak self]
            self.networkDataFetcher.fetchData(searchTerm: searchText) { [weak self](searchResults) in
                guard let fetchedPhotos = searchResults else { return }
                self?.photos = fetchedPhotos.results
                self?.collectionView.reloadData()
            }
        })
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

// Для настройки каждой ячейки подпишем наш класс на протокол UICollectionViewDelegateFlowLayout
extension PhotosCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let photo = photos[indexPath.item]
        // Настройка размеров ячейки
        let paddingSpace = sectionInserts.left * (itemPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
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
