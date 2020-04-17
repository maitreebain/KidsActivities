//
//  View.swift
//  ActivitySideProj
//
//  Created by Maitree Bain on 4/15/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//

import UIKit

class View: UIView {
    
//    public lazy var tips: TipsView = {
//        let view = TipsView()
//        return view
//    }()
    
    public lazy var lettCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.backgroundColor = #colorLiteral(red: 0.152980417, green: 0.8163639903, blue: 0.8561428189, alpha: 1)
        return cv
    }()
    
    public lazy var letterImageView: UIImageView = {
       let iv = UIImageView()
        iv.image = UIImage(systemName: "photo.on.rectangle")
        iv.backgroundColor = .darkGray
        iv.tintColor = #colorLiteral(red: 1, green: 0.5916159749, blue: 0.6973670721, alpha: 1)
        return iv
    }()
    
    public lazy var letterTextView: UITextView = {
        let tv = UITextView()
        tv.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        tv.text = "Type your letter here"
        tv.font = UIFont(name: "noteworthy", size: 20)
        tv.textColor = .darkGray
        return tv
    }()
    
    public lazy var submitButton: UIButton = {
       let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "paperplane.fill"), for: .normal)
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
        //setUpTipsConstraints()
        setUpCollectionView()
        setUpImageView()
        setUpTextBox()
        setUpSubmitButton()
    }
    
//    private func setUpTipsConstraints() {
//        addSubview(tips)
//
//        tips.translatesAutoresizingMaskIntoConstraints = false
//
//        NSLayoutConstraint.activate([
//            tips.topAnchor.constraint(equalTo: topAnchor, constant: 60),
//            tips.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
//            tips.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
//            tips.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5)
//        ])
//    }
    
    private func setUpCollectionView() {
        addSubview(lettCollectionView)
        
        lettCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            lettCollectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            lettCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            lettCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            lettCollectionView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.1)
        ])
    }
    
    private func setUpImageView() {
        addSubview(letterImageView)
        
        letterImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            letterImageView.topAnchor.constraint(equalTo: lettCollectionView.bottomAnchor, constant: 20),
            letterImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 60),
            letterImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -60),
            letterImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.25)
        ])
    }
    
    private func setUpTextBox() {
        addSubview(letterTextView)
        
        letterTextView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            letterTextView.topAnchor.constraint(equalTo: letterImageView.bottomAnchor, constant: 20),
            letterTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            letterTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            letterTextView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3)
        
        ])
    }
    
    private func setUpSubmitButton() {
        addSubview(submitButton)
        
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            submitButton.topAnchor.constraint(equalTo: letterTextView.bottomAnchor, constant: 20),
            submitButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            submitButton.heightAnchor.constraint(equalToConstant: 42),
            submitButton.widthAnchor.constraint(equalToConstant: 46)
        ])
    }


}
