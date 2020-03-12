//
//  UserReviewsTableViewCell.swift
//  radyum
//
//  Created by Studio on 12/03/2020.
//  Copyright © 2020 Studio. All rights reserved.
//

import UIKit

class UserReviewsTableViewCell: UITableViewCell {

    @IBOutlet weak var resName: UILabel!
    @IBOutlet weak var reviewText: UILabel!
    @IBOutlet weak var reviewImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
