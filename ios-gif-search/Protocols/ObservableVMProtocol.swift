//
//  ObservableVMProtocol.swift
//  ios-gif-search
//
//  Created by 동준 on 3/26/24.
//

import Foundation

protocol ObservableVMProtocol {
    associatedtype T = Gif
    
    func fetchData(searchType: GifMenu, searchMenu: GifType)
    
    func setError(_ message: String)
    
    var storage: Observable<[T]> { get set }
    
    var errorMessage: Observable<String?> { get set }
    
    var error: Observable<Bool> { get set }
}
