//
//  PhotoCell.swift
//  Tumblr-Feed
//
//  Created by Thomas Bender on 9/18/18.
//  Copyright © 2018 Thomas Bender. All rights reserved.
//

import UIKit

class PhotoCell: UITableViewCell {
  @IBOutlet weak var photoCellView: PhotoCell!
  
  @IBOutlet weak var photoImageView: UIImageView!
  
  
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
