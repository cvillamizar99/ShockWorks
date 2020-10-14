//
//  MainWorker.swift
//  Movies
//
//  Created by Carlos Villamizar on 10/13/20.
//  Copyright © 2020 Carlos Villamizar. All rights reserved.
//

import Foundation

protocol MainServiceProtocol {
    func getMovies(completion: @escaping (Result<Movies, MainError>) -> Void)
}

class MainWorker {
    var mainService: MainServiceProtocol?
    
    init(mainService: MainServiceProtocol) {
        self.mainService = mainService
    }
    
    func getMovies(completion: @escaping (Result<Movies, MainError>) -> Void) {
        mainService?.getMovies(completion: { result in
            completion(result)
        })
    }
}
