//
//  LetterCell.swift
//  KidsActivities
//
//  Created by Maitree Bain on 4/17/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//

import UIKit

class LetterCell: UICollectionViewCell {
    
    public lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "photo.fill")
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        setUpImageViewConstraints()
    }
    
    private func setUpImageViewConstraints() {
        addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: heightAnchor)
        ])
    }
    
    public func configureCell(_ activity: ActivityData) {
        if let imageData = activity.imageData {
            imageView.image = UIImage(data: imageData)
        }
    }
}
