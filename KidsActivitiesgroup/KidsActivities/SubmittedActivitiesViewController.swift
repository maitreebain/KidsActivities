//
//  SubmittedActivitiesViewController.swift
//  KidsActivities
//
//  Created by Maitree Bain on 4/14/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//

import UIKit

class SubmittedActivitiesViewController: UIViewController {
    
    @IBOutlet weak var submittedCV: UICollectionView!
    
    private var mediaObjects = [ActivityData]() {
        didSet {
            submittedCV.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        submittedCV.dataSource = self
        submittedCV.delegate = self
        
        fetchMediaObjects()
                
        dump(mediaObjects)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fetchMediaObjects()
    }
    
    private func fetchMediaObjects() {
        mediaObjects = CoreDataManager.shared.fetchMediaObjects()
    }
    
}

extension SubmittedActivitiesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mediaObjects.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mediaCell", for: indexPath) as? MediaCell else {
            fatalError()
        }
        let aMedia = mediaObjects[indexPath.row]
        cell.configureCell(mediaObject: aMedia)
        return cell
    }
}

extension SubmittedActivitiesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxSize: CGSize = UIScreen.main.bounds.size
        let itemWidth: CGFloat = maxSize.width
        let itemHeight: CGFloat = maxSize.height * 0.40
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
}
