//
//  CommentCell.swift
//  BankMandiriTest
//
//  Created by Bang Coding on 01/12/22.
//

import UIKit

internal class CommentCell: UICollectionViewCell {
    @IBOutlet internal weak var lblAuthor: UILabel!
    @IBOutlet internal weak var lblComment: UILabel!
    @IBOutlet internal weak var containerView: UIView!
    internal static let identifier = "CommentCell"
    override internal func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        containerView.layer.cornerRadius = 8
    }
    
    internal func setupData(review: ReviewData) {
        lblAuthor.text = review.author ?? ""
        lblComment.text = review.content ?? ""
    }
}
