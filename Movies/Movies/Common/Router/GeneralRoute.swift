//
//  GeneralRoute.swift
//  Movies
//
//  Created by Carlos Villamizar on 13/10/20.
//  Copyright © 2020 Carlos Villamizar. All rights reserved.

import Foundation
import UIKit

enum GeneralRoute: IRouter {
    case onboarding
    case main
    case detailMovie
}

extension GeneralRoute {
    var scene: UIViewController? {
        switch self {
        case .onboarding:
            return OnboardingViewController()
        case .main:
            return MainViewController()
        case .detailMovie:
            return MovieDetailViewController()
        }
    }
}
