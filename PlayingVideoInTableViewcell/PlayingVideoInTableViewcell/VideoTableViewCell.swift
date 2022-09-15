//
//  VideoTableViewCell.swift
//  PlayingVideoInTableViewcell
//
//  Created by chaitanya on 15/09/22.
//

import UIKit

class VideoTableViewCell: UITableViewCell {

    @IBOutlet weak var videoTitle: UILabel!
    @IBOutlet weak var videoThumNail: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
