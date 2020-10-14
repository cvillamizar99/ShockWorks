//
//  Movies.swift
//  Movies
//
//  Created by Carlos Villamizar on 10/13/20.
//  Copyright © 2020 Carlos Villamizar. All rights reserved.
//

import Foundation

struct Movies : Codable{
    let poster_path     : String?
    let title           : String?
    let overview        : String?
    let release_date    : String?
    let vote_count      : Int?
}
