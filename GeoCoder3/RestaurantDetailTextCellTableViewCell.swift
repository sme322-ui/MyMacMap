//
//  RestaurantDetailTextCellTableViewCell.swift
//  GeoCoder
//
//  Created by Sie monyan on 2021/11/30.
//

import UIKit

class RestaurantDetailTextCellTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet var descriptionLabel:UILabel!{
        didSet{
            descriptionLabel.numberOfLines = 0
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
