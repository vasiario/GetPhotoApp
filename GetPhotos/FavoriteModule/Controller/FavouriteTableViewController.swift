//
//  FavoriteTableViewController.swift
//  PhotoAppWithUnsplash
//
//  Created by Павел Афанасьев on 12.10.2022.
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
    
    private func setupTableView() {
        tableView.register(FavouriteTableViewCell.self, forCellReuseIdentifier: FavouriteTableViewCell.cellId)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favouritePhotoArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavouriteTableViewCell.cellId, for: indexPath) as! FavouriteTableViewCell
        let currentImage = favouritePhotoArray[indexPath.row]
        cell.authorName.text = currentImage.user.name
        cell.unsplashPhoto = currentImage
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension FavouriteTableViewController: DetailViewControllerProtocol {
    func sentData(details: DetailResults) {
        favouritePhotoArray.append(details)
        tableView.reloadData()
    }
}

//MARK: - UITableViewDelegate

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
