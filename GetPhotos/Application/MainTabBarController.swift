//
//  MainTabBarController.swift
//  GetPhotos
//
//  Created by vasiario on 13.06.2023.
//

import UIKit

class MainTabBarController: UITabBarController {

    private let photosVC = PhotosCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
    private let favoriteVC = FavouriteTableViewController()

    override func viewDidLoad() {
        super.viewDidLoad()

        viewControllers = [
            setupNavigationController(for: photosVC, with: "PHOTOS", with: UIImage(systemName: "photo")!),
            setupNavigationController(for: favoriteVC, with: "FAVORITE", with: UIImage(systemName: "star")!)
        ]

        photosVC.destinationVC.detailViewControllerDelegate = favoriteVC
    }

    private func setupNavigationController (for rootViewController: UIViewController, with title: String, with image: UIImage) -> UINavigationController{
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.title = title
        navigationVC.tabBarItem.image = image
        return navigationVC
    }
}
