//
//  GifsViewModel.swift
//  ios-gif-search
//
//  Created by 동준 on 3/10/24.
//
//
import Foundation
import UIKit

struct GifListViewModel {
    var gifModels: Observable<[GifViewModel]> = Observable([])
}

extension GifListViewModel {
    var numberOfItemsInSection: Int {
        return 1
    }
    
    func numberOfItems() -> Int {
        return gifModels.value!.count
    }
    
    func gifAtIndex(_ index: Int, completion: @escaping (UIImage?) -> Void) {
        guard index < gifModels.value?.count ?? 0 else {
            completion(nil)
            return
        }
        
        let gifViewModel = gifModels.value![index]
        gifViewModel.fetchImage { image in
            completion(image)
        }
    }
}

struct GifViewModel {
    let url: String
}

extension GifViewModel {
    func fetchImage(completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: url) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil, let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            completion(image)
        }.resume()
    }
}

