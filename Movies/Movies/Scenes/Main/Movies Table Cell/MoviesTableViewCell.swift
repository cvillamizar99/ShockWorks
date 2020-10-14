//
//  MoviesTableViewCell.swift
//  Movies
//
//  Created by Carlos Villamizar on 10/14/20.
//  Copyright © 2020 Carlos Villamizar. All rights reserved.
//

import UIKit
import Kingfisher

class MoviesTableViewCell: UITableViewCell {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var voteCountLabel: UILabel!
    
    static let reuseIdentifier = "MoviesCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(moviesData: Movies) {
        setImage("https://image.tmdb.org/t/p/w500\(moviesData.poster_path ?? "")")
        titleLabel.text = moviesData.title
        voteCountLabel.text = "Votos: \(moviesData.vote_count!)"
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
