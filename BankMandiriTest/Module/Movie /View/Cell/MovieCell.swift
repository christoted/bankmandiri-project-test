//
//  MovieCell.swift
//  BankMandiriTest
//
//  Created by Bang Coding on 30/11/22.
//

import UIKit
import Kingfisher

internal class MovieCell: UICollectionViewCell {

    @IBOutlet internal weak var containerView: UIView!
    @IBOutlet internal weak var lblStatus: UILabel!
    @IBOutlet internal weak var lblReleaseDate: UILabel!
    @IBOutlet internal weak var lblTagline: UILabel!
    @IBOutlet internal weak var ivMovie: UIImageView!
    @IBOutlet internal weak var lblTitle: UILabel!
    internal static let identifier = "MovieCell"
    override internal func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        ivMovie.layer.cornerRadius = 8
        containerView.layer.cornerRadius = 8
    }
    
    internal func setupMovie(movie: MovieResult) {
        let posterURL = Util.shared.getBaseURLImage() + "\(movie.posterPath ?? "")"
        lblTitle.text = movie.originalTitle ?? ""
        ivMovie.kf.setImage(with: URL(string: posterURL), placeholder: UIImage(named: ""), options: [.cacheOriginalImage])
        lblTagline.text = "Popularity: \(movie.popularity ?? 0.0)"
        lblReleaseDate.text = movie.releaseDate ?? ""
        lblStatus.text = movie.originalLanguage ?? ""
    }

}
