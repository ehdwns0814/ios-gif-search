//
//  GifsViewModel.swift
//  ios-gif-search
//
//  Created by 동준 on 3/10/24.
//
//
import Foundation

final class SearchViewModel {
    typealias T = Gif
    
    private let giphyOperation: GiphyOperation
    var gifUrlStorage: Observable<[T]> = Observable([])
    private let network = GiphyService(apiProvider: ProviderImplementation())
    
    init(giphyOperation: GiphyOperation) {
        self.giphyOperation = giphyOperation
    }
    
    func fetchSearchedGif(query: String) {
        network.searchGif(type: .gif, query: query, offset: 0) { [weak self] result in 
            switch result {
            case .success(let gifBundle):
                self?.gifUrlStorage.value = gifBundle.gifs
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchTrendingGif() {
        network.fetchTrendingGif(type: .gif, offset: 0) { [weak self] result in
            switch result {
            case .success(let gifBundle):
                self?.gifUrlStorage.value = gifBundle.gifs
            case .failure(let error):
                print(error)
            }
        }
    }
}



