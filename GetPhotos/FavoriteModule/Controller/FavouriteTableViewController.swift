//
//  FavoriteTableViewController.swift
//  GetPhotos
//
//  Created by vasiario on 13.06.2023.
//

import UIKit

class FavouriteTableViewController: UITableViewController {
  
  private let detailViewController = DetailViewController()
  private var networkDetailDataFetcher = NetworkDetailDataFetcher()
  
  var favouritePhotoArray = [DetailResults]()
  private var favouritePhotoDetails: DetailResults?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupTableView()
  }
  
  // MARK: - Setup
  
  private func setupTableView() {
    tableView.register(FavouriteTableViewCell.self, forCellReuseIdentifier: FavouriteTableViewCell.cellId)
    tableView.delegate = self
    tableView.dataSource = self
  }
  
  // MARK: - Table View Data Source
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return favouritePhotoArray.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: FavouriteTableViewCell.cellId, for: indexPath) as! FavouriteTableViewCell
    let currentImage = favouritePhotoArray[indexPath.row]
    cell.authorName.text = currentImage.user.name
    cell.unsplashPhoto = currentImage

    // Создаем кнопку удаления
        let deleteButton = UIButton(type: .system)
        deleteButton.setImage(UIImage(systemName: "trash"), for: .normal)
        deleteButton.tintColor = .red
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped(_:)), for: .touchUpInside)

        // Устанавливаем тег кнопки, чтобы знать, какую ячейку нужно удалить
        deleteButton.tag = indexPath.row

        // Добавляем кнопку удаления в ячейку
        cell.accessoryView = deleteButton

    return cell
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100
  }

//  таргет кнопки удаления
  @objc func deleteButtonTapped(_ sender: UIButton) {
      let indexPath = IndexPath(row: sender.tag, section: 0)

    favouritePhotoArray.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
  }
}


// MARK: - DetailViewControllerProtocol

extension FavouriteTableViewController: DetailViewControllerProtocol {
  func sentData(details: DetailResults) {
    favouritePhotoArray.append(details)
    tableView.reloadData()
  }
}

// MARK: - UITableViewDelegate

extension FavouriteTableViewController {
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let currentPhoto = favouritePhotoArray[indexPath.row]
    let photoID = currentPhoto.id
    networkDetailDataFetcher.fetchData(photoId: photoID) { [weak self] detailResult in
      guard let fetchedDetailsPhoto = detailResult else { return }
      let destinationVC = DetailViewController()
      destinationVC.incomePhotoDetails = fetchedDetailsPhoto
      self?.navigationController?.pushViewController(destinationVC, animated: true)
    }
  }
}
