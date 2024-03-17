//
//  ViewController.swift
//  ios-gif-search
//
//  Created by 동준 on 2/25/24.
//

import UIKit

class SearchViewController: UIViewController {
    
    let homeView = HomeView()
    let network = GifNetwork(type: .search)

    var viewModel = GifListViewModel()

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
        
    override func viewDidLoad() {
        super.viewDidLoad()
     
        setupViews()
        setupLayouts()
        
        viewModel.gifModels.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }

    }
    
    func setupViews() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
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
    
    func fetchGifs(for searchText: String) {
        guard let url = network.searchUrlBuilder(searchTerm: searchText, type: "gifs") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let err = error {
                print("Error fetching from Giphy: ", err.localizedDescription)
            }
            guard let data = data else { return }
                    
            do {
                let gifs = try JSONDecoder().decode([Gifs].self, from: data)
                self.viewModel.gifModels.value = gifs.compactMap({
                    
                })
            } catch {
                
            }
        }.resume()
    }
    
}

extension SearchViewController: UICollectionViewDelegate {
    
}

extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(viewModel.numberOfItems())
        return viewModel.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GifCell.identifier, for: indexPath) as! GifCell
//        cell.gif = viewModel.gifAtIndex(indexPath.row)
        return cell
    } 
}

extension SearchViewController: UISearchTextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField.text != nil {
            fetchGifs(for: textField.text!)
        }
        return true
    }
}
