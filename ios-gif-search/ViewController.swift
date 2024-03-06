//
//  ViewController.swift
//  ios-gif-search
//
//  Created by 동준 on 2/25/24.
//

import UIKit

class ViewController: UIViewController {

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
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .black
        self.view.addSubview(searchBar)
        self.view.addSubview(menuStack)
        self.view.addSubview(collectionView)
        
        let safeArea = self.view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 5),
            searchBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 50),
            
            menuStack.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 5),
            menuStack.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            menuStack.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            menuStack.heightAnchor.constraint(equalToConstant: 50),
            
            collectionView.topAnchor.constraint(equalTo: menuStack.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
}

extension ViewController: UICollectionViewDelegate {
    
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GifCell.identifier, for: indexPath) as! GifCell
        return cell
    } 
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField.text != nil {
            print(textField.text!)
        }
        return true
    }
}
