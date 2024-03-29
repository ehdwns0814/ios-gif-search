//
//  Observable.swift
//  ios-gif-search
//
//  Created by 동준 on 3/15/24.
//

import Foundation

class Observable<T> {
    typealias Listener = ((T) -> Void)
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    private var listener: Listener?
    
    func bind(_ listener: @escaping Listener) {
        listener(value)
        self.listener = listener
    }
}
