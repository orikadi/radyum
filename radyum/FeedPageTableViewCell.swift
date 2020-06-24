//
//  FeedPageTableViewCell.swift
//  radyum
//
//  Created by Studio on 12/03/2020.
//  Copyright © 2020 Studio. All rights reserved.
//

import UIKit

class FeedPageTableViewCell: UITableViewCell {

    @IBOutlet weak var reviewImage: UIImageView!
    @IBOutlet weak var resNameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
