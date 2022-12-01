//
//  MovieInfoCell.swift
//  BankMandiriTest
//
//  Created by Bang Coding on 01/12/22.
//

import UIKit
import youtube_ios_player_helper_swift
import Kingfisher

class MovieInfoCell: UICollectionViewCell {
    @IBOutlet weak var lblOverview: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var lblVote: UILabel!
    @IBOutlet weak var lblTagline: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var ivMovie: UIImageView!
    @IBOutlet var playerView: YTPlayerView!
    
    static let identifier = "MovieInfoCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        containerView.layer.cornerRadius = 8
        ivMovie.layer.cornerRadius = 8
        playerView.layer.cornerRadius = 8
    }
    
    func setupData(movie: MovieResponse?, video: VideoResult?) {
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
