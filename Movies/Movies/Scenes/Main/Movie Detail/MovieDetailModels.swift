//
//  MovieDetailModels.swift
//  Movies
//
//  Created by Carlos Villamizar on 10/14/20.
//  Copyright © 2020 Carlos Villamizar. All rights reserved.
//

import Foundation

enum MovieDetail {
    
    enum InitalData {
        struct Request {
        }
        struct Response {
            let movie: Movies
        }
        struct ViewModel {
            let movie: Movies
        }
    }
    
    enum Error {
        struct Request {
        }
        struct Response {
            var error: MovieDetailError
        }
        struct ViewModel {
            var error: MovieDetailError
        }
    }

}
