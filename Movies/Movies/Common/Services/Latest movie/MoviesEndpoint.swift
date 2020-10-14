//
//  MoviesEndpoint.swift
//  Movies
//
//  Created by Carlos Villamizar on 13/10/20.
//  Copyright © 2020 Carlos Villamizar. All rights reserved.

import Foundation
import Alamofire

enum MoviesEndpoint {
    case latest
}

extension MoviesEndpoint: IEndpoint {
    var method: HTTPMethod {
        switch self {
        case .latest:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .latest:
            return "latest"
        }
    }
    
    var parameter: Parameters? {
        switch self {
        case .latest:
            return nil
        }
    }
    
    var header: HTTPHeaders? {
        switch self {
        case .latest:
            return nil
        }
    }
    
    var encoding: ParameterEncoding {
        return JSONEncoding.default
    }
}
