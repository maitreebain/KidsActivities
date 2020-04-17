//
//  Activity6Cell.swift
//  Test
//
//  Created by Bienbenido Angeles on 4/16/20.
//  Copyright © 2020 Bienbenido Angeles. All rights reserved.
//

import UIKit

class Activity6Cell: UICollectionViewCell {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    @IBOutlet weak var videoDesc: UILabel!
    
    
    public func configureCell(for activity: Activity){
        
        if let imageData = activity.imageData {
            thumbnailImageView.image = UIImage(data: imageData)
        }
        
        if let videoURL = activity.videoData?.convertToURL() {
            let image = videoURL.videoPreviewThumbnail() ?? UIImage(systemName: "heart")
            thumbnailImageView.image = image
        }
        
        videoDesc.text = activity.date.convertToString()
        
    }
}
