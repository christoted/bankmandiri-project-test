//
//  CommentCell.swift
//  BankMandiriTest
//
//  Created by Bang Coding on 01/12/22.
//

import UIKit

class CommentCell: UICollectionViewCell {
    @IBOutlet weak var lblAuthor: UILabel!
    @IBOutlet weak var lblComment: UILabel!
    @IBOutlet weak var containerView: UIView!
    static let identifier = "CommentCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        containerView.layer.cornerRadius = 8
    }
    
    func setupData(review: ReviewData) {
        lblAuthor.text = review.author ?? ""
        lblComment.text = review.content ?? ""
    }
}
