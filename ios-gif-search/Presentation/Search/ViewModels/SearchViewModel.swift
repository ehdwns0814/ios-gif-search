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
    let network = GifService()
    
    func fetchData(searchType: GifType, searchMenu: GifContent) {
        network.fetchGifs(searchType: searchType.rawValue, searchMenu: searchMenu.rawValue, searchTerm: nil) { [weak self] response, error in
            guard let self = self, let gifs = response?.gifs else { return }
            storage.value = gifs
        }
    }
    
    func setError(_ message: String) {   
        
    }
    
    var storage: Observable<[T]> = Observable([])
    
    var errorMessage: Observable<String?> = Observable(nil)
    
    var error: Observable<Bool> = Observable(false)
}



