//
//  MovieDetailViewController.swift
//  Movies
//
//  Created by Carlos Villamizar on 10/14/20.
//  Copyright © 2020 Carlos Villamizar. All rights reserved.
//

import UIKit

protocol MovieDetailDisplayLogic: class {
    func displayInitialData(viewModel: MovieDetail.InitalData.ViewModel)
    func displayError(viewModel: MovieDetail.Error.ViewModel)
}

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var posterImageView      : MOImageView!
    @IBOutlet weak var titleLabel           : UILabel!
    @IBOutlet weak var dateLabel            : UILabel!
    @IBOutlet weak var overviewTextView     : MOTextView!
    @IBOutlet weak var voteCountLabel       : UILabel!
    
    
    var interactor: MovieDetailBusinessLogic?
    var router: (NSObjectProtocol & MovieDetailRoutingLogic & MovieDetailDataPassing)?

    // MARK: - Object lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
      super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
      setup()
    }

    required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      setup()
    }

    // MARK: - Setup
    private func setup() {
      let viewController = self
      let interactor = MovieDetailInteractor()
      let presenter = MovieDetailPresenter()
      let router = MovieDetailRouter()
      viewController.interactor = interactor
      viewController.router = router
      interactor.presenter = presenter
      presenter.viewController = viewController
      router.viewController = viewController
      router.dataStore = interactor
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchInitialData()
    }
    
    // MARK: - Fetch Initial Data
    func fetchInitialData() {
        let request = MovieDetail.InitalData.Request()
        interactor?.loadInitialData(request: request)
    }
}

// MARK: - MainDisplayLogic
extension MovieDetailViewController: MovieDetailDisplayLogic {
    func displayInitialData(viewModel: MovieDetail.InitalData.ViewModel) {
        let movie = viewModel.movie
        
        titleLabel.text         = movie.title
        dateLabel.text          = "Date: \(movie.release_date ?? "")"
        overviewTextView.text   = movie.overview
        voteCountLabel.text     = "Votes: \(movie.vote_count!)"
        setImage("https://image.tmdb.org/t/p/w500\(movie.poster_path ?? "")")
    }
    
    func displayError(viewModel: MovieDetail.Error.ViewModel){
        
        print("Error ", viewModel.error.description)
    }
    
    private func setImage(_ urlString: String?) {
        guard let urlString = urlString, !urlString.isEmpty, let imageURL = URL(string: urlString) else { return }
        
        let processor = MODownsamplingImageProcessor(size: posterImageView.bounds.size, subIdentifier: String(describing: MoviesTableViewCell.self))
        posterImageView.kf.indicatorType = .activity
        posterImageView.kf.setImage(with: imageURL,
                                 options: [
                                    .processor(processor),
                                    .scaleFactor(UIScreen.main.scale),
                                    .transition(.fade(1)),
                                    .waitForCache,
                                    .cacheOriginalImage,
                                 ],
                                 completionHandler: { result in
            switch result {
            case .success:
                break
            case .failure:
                break
            }
        })
    }
}
