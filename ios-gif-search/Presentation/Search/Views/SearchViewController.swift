//
//  ViewController.swift
//  ios-gif-search
//
//  Created by 동준 on 2/25/24.
//

import UIKit

final class SearchViewController: UIViewController {
    
    let homeView = HomeView()
    private var viewModel = SearchViewModel(giphyOperation: GiphyService(apiProvider: ProviderImplementation()))

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 2
        layout.itemSize = CGSize(width: (view.frame.size.width - layout.minimumInteritemSpacing) / 2, height: 100)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .black
        collectionView.register(GifCell.self, forCellWithReuseIdentifier: GifCell.identifier)
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupLayouts()
        setupData()
    }
    
    func setupViews() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        setupBinding()
        
        homeView.searchBar.searchTextField.delegate = self
        homeView.searchBar.searchTextField.placeholder = "Search Gifs"
        homeView.searchBar.returnKeyType = .search
        
        view.backgroundColor = .black
        view.addSubview(homeView)
        view.addSubview(collectionView)
        
        homeView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupLayouts() {
        NSLayoutConstraint.activate([
            homeView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            homeView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            homeView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            homeView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.15),
            
            collectionView.topAnchor.constraint(equalTo: homeView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    // MARK: - Helpers
    private func setupData() {
        viewModel.fetchTrendingGif()
    }
    
    private func setupBinding() {
        viewModel.gifUrlStorage.subscribe { [weak self] _ in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
}

extension SearchViewController: UICollectionViewDelegate {
    
}

extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let urlCount = viewModel.gifUrlStorage.value?.count else { return 0 }
        return urlCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GifCell.identifier, for: indexPath) as! GifCell
        
        guard let urls = viewModel.gifUrlStorage.value else { return cell }
        
        cell.configure(with: urls[indexPath.row].mediaResource.imageURL)

        return cell
    } 
}

extension SearchViewController: UISearchTextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField.text != nil {
            guard let searchedText = textField.text else { return false }
            viewModel.fetchSearchedGif(query: searchedText)
        }
        return true
    }
}
