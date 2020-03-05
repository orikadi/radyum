//
//  RestaurantTableViewCell.swift
//  radyum
//
//  Created by Studio on 17/02/2020.
//  Copyright © 2020 Studio. All rights reserved.
//

import UIKit

class RestaurantTableViewCell: UITableViewCell {

    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var restaurantName: UILabel!
    @IBOutlet weak var restaurantAddress: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //TODO load the restaurant info for each cell
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
