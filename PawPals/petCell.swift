//
//  petCell.swift
//  PawPals
//
//  Created by Susanne Burnham on 12/15/15.
//  Copyright © 2015 Susanne Kasahara. All rights reserved.
//

import UIKit

class petCell: UITableViewCell {
    
    var petInfo: [String:AnyObject]!
    
    @IBOutlet weak var petNameCLabel: UILabel!
    
    @IBOutlet weak var petAgeCLabel: UILabel!
    
    @IBOutlet weak var petBreedCLabel: UILabel!
    
    @IBOutlet weak var petCityCLabel: UILabel!
    
    @IBOutlet weak var petStateCLabel: UILabel!
    
    @IBOutlet weak var petImageCView: UIImageView!

    
    
    
    override func prepareForReuse() {
        
        petNameCLabel.text = ""
        petAgeCLabel.text = ""
        petBreedCLabel.text = ""
        petCityCLabel.text = ""
        petStateCLabel.text = ""
        petImageCView.image = nil
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

