//
//  photoCell.swift
//  instagram
//
//  Created by Ekko Lin on 3/12/17.
//  Copyright © 2017 CodePath. All rights reserved.
//

import UIKit

class photoCell: UITableViewCell {

    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    var post: Post! {
        didSet {
            
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

}
