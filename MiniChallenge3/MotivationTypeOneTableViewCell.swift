//
//  MotivationTypeOneTableViewCell.swift
//  MiniChallenge3
//
//  Created by Ana Carolina Silva on 13/06/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import UIKit

class MotivationTypeOneTableViewCell: UITableViewCell {

    //MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var motivationImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        motivationImage.layer.cornerRadius = 5
        motivationImage.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
