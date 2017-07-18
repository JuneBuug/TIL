//
//  CustomTableViewCell.swift
//  baeminFresh
//
//  Created by woowabrothers on 2017. 7. 18..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var descriptionView: UILabel!
    @IBOutlet weak var n_priceView: UILabel!
    @IBOutlet weak var s_priceView: UILabel!
  
    @IBOutlet var badgeView: UILabel!
   
    @IBOutlet weak var mainImageView: UIImageView!
   
    @IBOutlet var launchinngBadge: UILabel!
    @IBOutlet var eventBadge: UILabel!
    @IBOutlet var badgeStackView: UIStackView!

    override func awakeFromNib() {
        super.awakeFromNib()
               // Initialization code
        n_priceView.isHidden = true
        s_priceView.isHidden = true
        launchinngBadge.isHidden = true
        eventBadge.isHidden = true
        
        titleView.font = UIFont.boldSystemFont(ofSize: 18.0)
        s_priceView.font = UIFont.boldSystemFont(ofSize: 18.0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
