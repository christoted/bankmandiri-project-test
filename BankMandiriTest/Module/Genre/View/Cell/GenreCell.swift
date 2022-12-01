//
//  GenreCell.swift
//  BankMandiriTest
//
//  Created by Bang Coding on 30/11/22.
//

import UIKit

internal class GenreCell: UICollectionViewCell {

    @IBOutlet internal weak var lblTitle: UILabel!
    @IBOutlet internal weak var containerView: UIView!
    
    internal static let identifier = "GenreCell"
    override internal func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        containerView.layer.cornerRadius = 8
        containerView.layer.borderWidth = 0.1
    }
    
    internal func setupGenre(genre: String) {
        lblTitle.text = genre
    }
}
