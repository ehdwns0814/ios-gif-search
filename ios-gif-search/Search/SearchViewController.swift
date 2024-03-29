//
//  ViewController.swift
//  ios-gif-search
//
//  Created by 동준 on 2/25/24.
//

import UIKit

class SearchViewController: UIViewController {
    
    let homeView = HomeView()
    var viewModel = SearchViewModel()

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
     
        
        setupData()
        setupViews()
        setupLayouts()
    }
    
    func setupViews() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
//        setupBinding()
        
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
            homeView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2),
            
            collectionView.topAnchor.constraint(equalTo: homeView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    // MARK: - Helpers
    private func setupData() {
        viewModel.fetchData(searchType: .gif, searchMenu: .trending)
    }
    
    private func setupBinding(){
        viewModel.storage.bind { [weak self] _ in
            guard let self = self else { return }
            self.collectionView.reloadData()
        }
        
        //에러
        let message = "setupBinding - Binding error"
        viewModel.errorMessage = Observable(message)
        
        viewModel.error.bind { isSuccess in
            if isSuccess {
                print("DEBUG: success")
            } else {
                print("DEBUG: \(self.viewModel.errorMessage)")
            }
        }
    }
}

extension SearchViewController: UICollectionViewDelegate {
    
}

extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(viewModel.storage.value.count)
        return viewModel.storage.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GifCell.identifier, for: indexPath) as! GifCell
        
        viewModel.network.configure(gif: viewModel.storage.value[indexPath.row]) { image in
            guard let image = image else { return }
            cell.configure(image)
        }
        return cell
    } 
}

extension SearchViewController: UISearchTextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField.text != nil {
            
        }
        return true
    }
}