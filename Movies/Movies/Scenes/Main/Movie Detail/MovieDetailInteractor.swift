//
//  MovieDetailInteractor.swift
//  Movies
//
//  Created by Carlos Villamizar on 10/14/20.
//  Copyright © 2020 Carlos Villamizar. All rights reserved.
//

import Foundation

protocol MovieDetailBusinessLogic {
    func loadInitialData(request: MovieDetail.InitalData.Request)
}

protocol MovieDetailDataStore {
    var movie: Movies? { get set }
}

class MovieDetailInteractor: MovieDetailBusinessLogic, MovieDetailDataStore {
    var presenter: MovieDetailPresentationLogic?
    var movie: Movies?
    
    func loadInitialData(request: MovieDetail.InitalData.Request) {
        guard let movie = movie else { return }
        let response = MovieDetail.InitalData.Response(movie: movie)
        self.presenter?.presentInitalData(response: response)
    }
}
