//
//  MovieDetailPresenter.swift
//  Movies
//
//  Created by Carlos Villamizar on 10/14/20.
//  Copyright © 2020 Carlos Villamizar. All rights reserved.
//

import Foundation

protocol MovieDetailPresentationLogic {
    func presentInitalData(response: MovieDetail.InitalData.Response)
}

class MovieDetailPresenter: MovieDetailPresentationLogic {
    weak var viewController: MovieDetailDisplayLogic?
    
    // MARK: - Present Inital Data
    func presentInitalData(response: MovieDetail.InitalData.Response) {
        let viewModel = MovieDetail.InitalData.ViewModel(movie: response.movie)
        viewController?.displayInitialData(viewModel: viewModel)
    }
}
