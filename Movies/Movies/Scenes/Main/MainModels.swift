//
//  MainModels.swift
//  Movies
//
//  Created by Carlos Villamizar on 10/13/20.
//  Copyright © 2020 Carlos Villamizar. All rights reserved.
//

import Foundation

enum Main {
    
    enum LoadInitialData {
        struct Request {
        }
        struct Response: Codable {
            let status: Bool
            let statusCode: Int
            let responseDescription: String
            let data: [Movies]
            
            enum CodingKeys: String, CodingKey {
                case status, statusCode
                case responseDescription = "description"
                case data
            }
        }
        
        struct ViewModel {
            let movies: [Movies]
        }
    }
    
    enum Detail {
        struct Request {
            let movie: Movies
        }
        struct Response {
        }
        struct ViewModel {
        }
    }
    
    enum Error {
        struct Request {
        }
        struct Response {
            var error: MainError
        }
        struct ViewModel {
            var error: MainError
        }
    }
}
