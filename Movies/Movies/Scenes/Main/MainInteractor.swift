//
//  MainInteractor.swift
//  Movies
//
//  Created by Carlos Villamizar on 10/13/20.
//  Copyright © 2020 Carlos Villamizar. All rights reserved.
//

import Foundation

protocol MainBusinessLogic {
    func loadInitialData(request: Main.LoadInitialData.Request)
    func showMovieDetail(request: Main.Detail.Request)
}

protocol MainDataStore {
    var movie: Movies? { get set }
}

class MainInteractor: MainBusinessLogic, MainDataStore {
    var presenter: MainPresentationLogic?
    var worker = MainWorker(mainService: MoviesAPI())
    var movie: Movies?
    
    // MARK: - Load initial data
    func loadInitialData(request: Main.LoadInitialData.Request) {
        worker.getMovies{ [weak self] result in
            switch result {
            case .success(let response):
                self?.presenter?.presentMovies(response: [response])
            case let .failure(error):
                let response = Main.Error.Response(error: error)
                self?.presenter?.presentError(response: response)
            }
        }
    }
    
    // MARK: - Show Movie Detail
    func showMovieDetail(request: Main.Detail.Request) {
        movie = request.movie
        let response = Main.Detail.Response()
        presenter?.presentMovieDetail(response: response)
    }
}
