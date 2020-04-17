//
//  ScavengerCell.swift
//  KidsActivities
//
//  Created by Maitree Bain on 4/16/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//

import UIKit

class ScavengerCell: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var prompt: UILabel!
    @IBOutlet weak var checkButton: UIButton!
    
    
    public func configureCell(for item: ScavengerInfo) {
        
        image.image = item.image
        prompt.text = item.title
    }
    
    
    @IBAction func checkButtonPressed(_ sender: UIButton){
        sender.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
    }
}
