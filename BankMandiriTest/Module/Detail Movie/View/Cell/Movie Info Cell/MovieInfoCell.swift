//
//  MovieInfoCell.swift
//  BankMandiriTest
//
//  Created by Bang Coding on 01/12/22.
//

import UIKit
import youtube_ios_player_helper_swift
import Kingfisher

internal class MovieInfoCell: UICollectionViewCell {
    @IBOutlet internal weak var lblOverview: UILabel!
    @IBOutlet internal weak var containerView: UIView!
    @IBOutlet internal weak var lblVote: UILabel!
    @IBOutlet internal weak var lblTagline: UILabel!
    @IBOutlet internal weak var lblTitle: UILabel!
    @IBOutlet internal weak var ivMovie: UIImageView!
    @IBOutlet internal var playerView: YTPlayerView!
    
    internal static let identifier = "MovieInfoCell"

    override internal func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        containerView.layer.cornerRadius = 8
        ivMovie.layer.cornerRadius = 8
        playerView.layer.cornerRadius = 8
    }
    
    internal func setupData(movie: MovieResponse?, video: VideoResult?) {
        guard let movie = movie else {
            return
        }

        let posterURL = Util.shared.getBaseURLImage() + "\(movie.posterPath ?? "")"
        lblTitle.text = movie.title ?? ""
        lblOverview.text = movie.overview ?? ""
        lblVote.text = "\(movie.voteCount ?? 0)"
        lblTagline.text = movie.tagline ?? ""
        ivMovie.kf.setImage(with: URL(string: posterURL), placeholder: UIImage(named: ""), options: [.cacheOriginalImage, .loadDiskFileSynchronously])
        if let video = video {
            let key = video.key ?? ""
            playerView.load(videoId: key)
        }
    }
    
}
