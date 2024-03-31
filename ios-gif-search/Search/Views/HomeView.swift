//
//  HomeView.swift
//  ios-gif-search
//
//  Created by 동준 on 3/10/24.
//

import UIKit

final class HomeView: UIView {
    let searchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.searchTextField.placeholder = "Search Gif"
        bar.returnKeyType = .search
        bar.backgroundColor = .white
        bar.translatesAutoresizingMaskIntoConstraints = false
        return bar
    }()
    
    let menuStack: UIStackView = {
        let stack =  UIStackView()
        let trendingButton = UIButton()
        trendingButton.setTitle("Trending", for: .normal)
        trendingButton.backgroundColor = .systemPurple
        trendingButton.layer.cornerRadius = 10
        trendingButton.clipsToBounds = true
        
        stack.addArrangedSubview(trendingButton)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        addSubview(searchBar)
        addSubview(menuStack)
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            searchBar.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 50),
            
            menuStack.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 5),
            menuStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            menuStack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            menuStack.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
