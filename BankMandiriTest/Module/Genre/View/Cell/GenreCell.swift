//
//  GenreCell.swift
//  BankMandiriTest
//
//  Created by Bang Coding on 30/11/22.
//

import UIKit

class GenreCell: UICollectionViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    static let identifier = "GenreCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        containerView.layer.cornerRadius = 8
        containerView.layer.borderWidth = 0.1
    }
    
    func setupGenre(genre: String) {
        lblTitle.text = genre
    }
}
