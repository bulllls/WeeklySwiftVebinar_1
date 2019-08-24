//
//  PhotosCollectionViewController.swift
//  WeeklySwift#1(PhotosLibrary)
//
//  Created by Ruslan on 8/24/19.
//  Copyright © 2019 Ruslan Filistovich. All rights reserved.
//

import UIKit

class PhotosCollectionViewController: UICollectionViewController {
    
    
    var networkDataFetcher = NetworkDataFetcher()
    private var timer: Timer?
    
    private var photos = [UnsplashPhoto]()
    
    private var selectedImages = [UIImage]()
    
    private let itemsPerRow: CGFloat = 2
    private let sectionInserts = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    
    private lazy var addBarButtonItem: UIBarButtonItem = {
        return UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addBarButtonTapped))
    }()
    
    private lazy var actionBarButtonItem: UIBarButtonItem = {
       return UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(actionBarButtonTapped))
    }()
    
    private var numberOfSelectedPhotos: Int {
        return collectionView.indexPathsForSelectedItems?.count ?? 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        undateNavButtonsState()
        collectionView.backgroundColor = .white
        setupNavigationBar()
        setupCollectionView()
        setupSearchBar()
    }
    
    private func undateNavButtonsState() {
        addBarButtonItem.isEnabled = numberOfSelectedPhotos > 0
        actionBarButtonItem.isEnabled = numberOfSelectedPhotos > 0
    }
    
    func refresh() {
        self.selectedImages.removeAll()
        self.collectionView.selectItem(at: nil, animated: true, scrollPosition: [])
        undateNavButtonsState()
    }
    
    // MARK: - NavigationItems action
    @objc private func addBarButtonTapped() {
        print(#function)
    }
    
    @objc private func actionBarButtonTapped(sender: UIBarButtonItem) {
        print(#function)
        
//        let shareController = UIActivityViewController(activityItems: selectedImages, applicationActivities: nil)
//
//
//        shareController.completionWithItemsHandler = { _, bool, _, _ in
//            if bool {
//                self.refresh()
//            }
//        }
//
//        shareController.popoverPresentationController?.barButtonItem = sender
//        shareController.popoverPresentationController?.permittedArrowDirections = .any
//        present(shareController, animated: true, completion: nil)
    }
    
    // MARK: - Setup UI Elements
    
    private func setupCollectionView() {
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "CellId")
    }
    
    private func setupNavigationBar() {
        let titleLabel = UILabel()
        titleLabel.text = "PHOTOS"
        titleLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        titleLabel.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: titleLabel)
        
        navigationItem.rightBarButtonItems = [actionBarButtonItem, addBarButtonItem]
    }
    
    private func setupSearchBar() {
        let seacrhController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = seacrhController
        seacrhController.hidesNavigationBarDuringPresentation = false
        seacrhController.obscuresBackgroundDuringPresentation = false
        seacrhController.searchBar.delegate = self
    }
    
    // MARK: - UICollecionViewDataSource, UICollecionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellId", for: indexPath)
        cell.backgroundColor = .red
        return cell
    }

}

// MARK: - UISearchBarDelegate

extension PhotosCollectionViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            self.networkDataFetcher.fetchImages(searchTerm: searchText) { [weak self] (searchResults) in
                guard let fetchedPhotos = searchResults else { return }
                self?.photos = fetchedPhotos.results
                self?.collectionView.reloadData()
                self?.refresh()
            }
        })
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension PhotosCollectionViewController: UICollectionViewDelegateFlowLayout {
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let photo = photos[indexPath.item]
//        let paddingSpace = sectionInserts.left * (itemsPerRow + 1)
//        let availableWidth = view.frame.width - paddingSpace
//        let widthPerItem = availableWidth / itemsPerRow
//        let height = CGFloat(photo.height) * widthPerItem / CGFloat(photo.width)
//        return CGSize(width: widthPerItem, height: height)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return sectionInserts
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return sectionInserts.left
//    }
}
