//
//  MainRouter.swift
//  Movies
//
//  Created by Carlos Villamizar on 10/13/20.
//  Copyright © 2020 Carlos Villamizar. All rights reserved.
//

import Foundation

@objc protocol MainRoutingLogic {
    func routeToMovieDetail()
}

protocol MainDataPassing {
    var dataStore: MainDataStore? { get }
}

class MainRouter: NSObject, MainRoutingLogic, MainDataPassing {
    weak var viewController: MainViewController?
    var dataStore: MainDataStore?
  
    // MARK: - Routing
    func routeToMovieDetail() {
        navigateToMovieDetail(source: viewController!, destination: GeneralRoute.detailMovie)
    }
    
    // MARK: - Navigation
    func navigateToMovieDetail(source: MainViewController, destination: GeneralRoute) {
        guard let movieDetailVC = destination.scene as? MovieDetailViewController else { return }
        
        var destinationDS = movieDetailVC.router?.dataStore
        passDataToMovieDetail(source: dataStore!, destination: &destinationDS!)
        
        source.navigationController?.pushViewController(movieDetailVC, animated: true)
    }
    
    // MARK: - Passing data
    func passDataToMovieDetail(source: MainDataStore, destination: inout MovieDetailDataStore) {
        destination.movie = source.movie
    }
}
