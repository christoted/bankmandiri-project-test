//
//  MovieCell.swift
//  BankMandiriTest
//
//  Created by Bang Coding on 30/11/22.
//

import UIKit

class MovieCell: UICollectionViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    static let identifier = "MovieCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupMovie(movie: MovieResult) {
        lblTitle.text = movie.originalTitle ?? ""
    }

}
