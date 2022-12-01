//
//  MovieCell.swift
//  BankMandiriTest
//
//  Created by Bang Coding on 30/11/22.
//

import UIKit
import Kingfisher

class MovieCell: UICollectionViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblReleaseDate: UILabel!
    @IBOutlet weak var lblTagline: UILabel!
    @IBOutlet weak var ivMovie: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    static let identifier = "MovieCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        ivMovie.layer.cornerRadius = 8
        containerView.layer.cornerRadius = 8
    }
    
    func setupMovie(movie: MovieResult) {
        let posterURL = Util.shared.getBaseURLImage() + "\(movie.posterPath ?? "")"
        lblTitle.text = movie.originalTitle ?? ""
        ivMovie.kf.setImage(with: URL(string: posterURL), placeholder: UIImage(named: ""), options: [.cacheOriginalImage, .loadDiskFileSynchronously])
        lblTagline.text = "Popularity: \(movie.popularity ?? 0.0)"
        lblReleaseDate.text = movie.releaseDate ?? ""
        lblStatus.text = movie.originalLanguage ?? ""
    }

}
