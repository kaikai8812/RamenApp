//
//  ContentsCell.swift
//  RamenApp
//
//  Created by ヘパリン類似物質 on 2021/05/27.
//

import UIKit
import Cosmos

class ContentsCell: UITableViewCell {
    
    
    @IBOutlet weak var contentImageView: UIImageView!
    @IBOutlet weak var shopNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var reviewRatingView: CosmosView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentImageView.layer.cornerRadius = 20.0
        contentView.clipsToBounds = true
        
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
