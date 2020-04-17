//
//  MediaCell.swift
//  AVFoundation-MediaFeed
//
//  Created by Tsering Lama on 4/13/20.
//  Copyright © 2020 Tsering Lama. All rights reserved.
//

import UIKit

class MediaCell: UICollectionViewCell {

    @IBOutlet weak var mediaView: UIImageView!
    @IBOutlet weak var activityName: UILabel!
    
    public func configureCell(mediaObject: ActivityData) {
        if let imageData = mediaObject.imageData  {
            mediaView.image = UIImage(data: imageData)
        }
        
        if let videoURL = mediaObject.videoData?.convertToURL() {
            let image = videoURL.videoPreviewThumbnail() ?? UIImage(systemName: "heart")
            mediaView.image = image
        }
        
        activityName.text = mediaObject.activityName
    }
}
