//
//  RestaurantReviewsTableViewCell.swift
//  radyum
//
//  Created by Studio on 11/03/2020.
//  Copyright © 2020 Studio. All rights reserved.
//

import UIKit

class RestaurantReviewsTableViewCell: UITableViewCell {

    @IBOutlet weak var reviewImage: UIImageView!
    @IBOutlet weak var reviewText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
