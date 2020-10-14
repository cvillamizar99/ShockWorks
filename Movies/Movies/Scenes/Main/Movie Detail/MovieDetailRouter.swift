//
//  MovieDetailRouter.swift
//  Movies
//
//  Created by Carlos Villamizar on 10/14/20.
//  Copyright © 2020 Carlos Villamizar. All rights reserved.
//

import Foundation

@objc protocol MovieDetailRoutingLogic {
    
}

protocol MovieDetailDataPassing {
    var dataStore: MovieDetailDataStore? { get }
}

class MovieDetailRouter: NSObject, MovieDetailRoutingLogic, MovieDetailDataPassing {
    weak var viewController: MovieDetailViewController?
    var dataStore: MovieDetailDataStore?
  
    // MARK: - Routing

    // MARK: - Navigation
    
}
