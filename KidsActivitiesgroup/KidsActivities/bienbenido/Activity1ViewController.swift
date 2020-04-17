//
//  ViewController.swift
//  Test
//
//  Created by Bienbenido Angeles on 4/16/20.
//  Copyright © 2020 Bienbenido Angeles. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class Activity1ViewController: UIViewController {
    
    @IBOutlet weak var descLabel: UILabel!
    
    @IBOutlet weak var instrLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var camButton: UIBarButtonItem!
    
    private lazy var imagePickerController: UIImagePickerController = {
        let mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.mediaTypes = mediaTypes ?? ["kUTTypeImage"]
        return pickerController
    }()
    
    private var activities = [ActivityData](){
        didSet{
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        descLabel.isHidden = true
        instrLabel.isHidden = true
        isCamDisabled()
    }
    
    
    func isCamDisabled(){
        if !UIImagePickerController.isSourceTypeAvailable(.camera) {
            camButton.isEnabled = false
        }
    }
    
    func configureCollectionView(){
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    
    @IBAction func camButtonPressed(_ sender: UIBarButtonItem){
        imagePickerController.sourceType = .camera
        present(imagePickerController, animated: true)
        
    }
}

extension Activity1ViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return activities.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "activity1Cell", for: indexPath) as? Activity1Cell else {
            fatalError("could not dequeue a MediaCell")
        }
        let activity = activities[indexPath.row]
        cell.configureCell(for: activity)
        cell.delegate = self
        return cell
    }
    
    
}

extension Activity1ViewController: CollectionViewCellDelegate{
    func textFieldChanged(cell: Activity1Cell, activity: ActivityData, text: String) {
        
        let unModifiedActivity = activities.first{$0 == activity}
        
        unModifiedActivity?.personifiedItem = text
    }
}

extension Activity1ViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxSize: CGSize = UIScreen.main.bounds.size // max width and height of the current device
        let itemWidth: CGFloat = maxSize.width * 0.9
        let itemHeight: CGFloat = maxSize.height * 0.40 // 40% of the height of the device
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
}

extension Activity1ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage, let imageData = image.jpegData(compressionQuality: 1.0) else {
            return
        }
        
        let activity = CoreDataManager.shared.create(imageData, videoURL: nil, personifedItem: nil, activityName: "Personify Something", caption: nil)
                
        activities.append(activity)
        
        picker.dismiss(animated: true)
    }
}
