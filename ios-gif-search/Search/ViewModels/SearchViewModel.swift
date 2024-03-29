//
//  GifsViewModel.swift
//  ios-gif-search
//
//  Created by 동준 on 3/10/24.
//
//
import Foundation

class SearchViewModel: ObservableVMProtocol {
    typealias T = Gif
    let network = GifService()
    
    func fetchData(searchType: GifMenu, searchMenu: GifType) {
        network.fetchGifs(searchType: searchType.rawValue, searchMenu: searchMenu.rawValue, searchTerm: nil) { response, error in
            guard let gifs = response?.gifs else { return }
            let observable = Observable(gifs)
            self.storage = observable
        }
    }
    
    func setError(_ message: String) {   
        
    }
    
    var storage: Observable<[Gif]> = Observable([])
    
    var errorMessage: Observable<String?> = Observable(nil)
    
    var error: Observable<Bool> = Observable(false)
}



