//
//  MainPresenter.swift
//  Movies
//
//  Created by Carlos Villamizar on 10/13/20.
//  Copyright © 2020 Carlos Villamizar. All rights reserved.
//

import Foundation

protocol MainPresentationLogic {
    func presentMovies(response: [Movies])
    func presentMovieDetail(response: Main.Detail.Response)
    func presentError(response: Main.Error.Response)
}

class MainPresenter: MainPresentationLogic {
    weak var viewController: MainDisplayLogic?
    
    // MARK: - Present BeneficiaryList
    func presentMovies(response: [Movies]) {
        let viewModel = Main.LoadInitialData.ViewModel(movies: response)
        viewController?.displayInitialData(viewModel: viewModel)
    }
    
    // MARK: - Present Detail Movie
    func presentMovieDetail(response: Main.Detail.Response) {
        let viewModel = Main.Detail.ViewModel()
        viewController?.displayMovieDetail(viewModel: viewModel)
    }
    
    // MARK: - Present Error
    func presentError(response: Main.Error.Response) {
        let viewModel = Main.Error.ViewModel(error: response.error)
        viewController?.displayError(viewModel: viewModel)
    }
}
