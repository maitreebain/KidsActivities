//
//  LetterView.swift
//  KidsActivities
//
//  Created by Maitree Bain on 4/15/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//

import UIKit

class LetterView: UIView {
    
    //add labels
    
    public lazy var lettCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.backgroundColor = .black
        return cv
    }()
    
    public lazy var letterImageView: UIImageView = {
       let iv = UIImageView()
        iv.image = UIImage(systemName: "photo.on.rectangle")
        iv.tintColor = #colorLiteral(red: 1, green: 0.5916159749, blue: 0.6973670721, alpha: 1)
        return iv
    }()
    
    public lazy var letterTextView: UITextView = {
        let tv = UITextView()
        tv.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        return tv
    }()
    
    public lazy var submitButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(systemName: "paperplane.fill"), for: .normal)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        setUpCollectionView()
        setUpImageView()
        setUpTextBox()
        setUpSubmitButton()
    }
    
    private func setUpCollectionView() {
        addSubview(lettCollectionView)
        
        lettCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            lettCollectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            lettCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            lettCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            lettCollectionView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2)
        ])
    }
    
    private func setUpImageView() {
        
    }
    
    private func setUpTextBox() {
        
    }
    
    private func setUpSubmitButton() {
        
    }

}
