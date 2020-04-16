//
//  ContentCell.swift
//  KidsActivities
//
//  Created by Bienbenido Angeles on 4/16/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//

import UIKit

class ContentCell: UICollectionViewCell {
    
    @IBOutlet weak var videoThumbnailImageview: UIImageView!
    
    public func configureCell(){
        
    }
    
}

class HeaderView: UICollectionReusableView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .systemYellow
    }
}
