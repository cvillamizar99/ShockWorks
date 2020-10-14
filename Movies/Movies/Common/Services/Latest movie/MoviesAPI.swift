//
//  MoviesAPI.swift
//  Movies
//
//  Created by Carlos Villamizar on 13/10/20.
//  Copyright © 2020 Carlos Villamizar. All rights reserved.
//

import Foundation

class MoviesAPI: MainServiceProtocol {
    func getMovies(completion: @escaping (Result<Movies, MainError>) -> Void) {
        NetworkService.share.request(endpoint: MoviesEndpoint.latest) { result in
            switch result {
            case .success:
                do {
                    let data = try result.get()
                    let response = try JSONDecoder().decode(Movies.self, from: data!)
                    completion(.success(response))
                } catch let error {
                    completion(.failure(.parse(error)))
                }
            case .failure(let error):
                completion(.failure(.network(error)))
            }
        }
    }
}
