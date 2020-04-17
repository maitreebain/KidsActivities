//
//  URL+videoPreviewThumbnail.swift
//  Test
//
//  Created by Bienbenido Angeles on 4/16/20.
//  Copyright © 2020 Bienbenido Angeles. All rights reserved.
//

import UIKit
import AVFoundation

extension URL{
    public func videoPreviewThumbnail() -> UIImage? {
        
        let asset = AVAsset(url: self) // self is the URL instance
        
        
        let assetGenerator = AVAssetImageGenerator(asset: asset)
        

        assetGenerator.appliesPreferredTrackTransform = true
        
        let timeStamp = CMTime(seconds: 1.0, preferredTimescale: 60)
        
        var image:UIImage?
        
        do {
            let cgImage =  try assetGenerator.copyCGImage(at: timeStamp, actualTime: nil)
            image = UIImage(cgImage: cgImage)
            
        } catch {
            print("failed to generate image: \(error)")
        }
        
        return image
    }
}
