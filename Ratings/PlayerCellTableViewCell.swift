//
//  PlayerCellTableViewCell.swift
//  Ratings
//
//  Created by tibin on 16/03/17.
//  Copyright © 2017 tibin. All rights reserved.
//

import UIKit

class PlayerCellTableViewCell: UITableViewCell {
    @IBOutlet weak var gameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingImageView: UIImageView!
    
    var player: Player! {
        didSet {
            gameLabel.text = player.game
            nameLabel.text = player.name
            ratingImageView.image = imageForRating(player.rating)
        }
    }
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func imageForRating(_ rating:Int) -> UIImage? {
        let imageName = "\(rating)Stars"
        return UIImage(named: imageName)
    }

}
