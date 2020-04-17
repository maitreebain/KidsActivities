//
//  SubmittedActivitiesViewController.swift
//  KidsActivities
//
//  Created by Maitree Bain on 4/14/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class ScavengerViewController: UIViewController {
    
    @IBOutlet weak var scavengerCollection: UICollectionView!
    
    private lazy var imagePickerController: UIImagePickerController = {
        let mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)
        let pickerController = UIImagePickerController()
        pickerController.mediaTypes = mediaTypes ?? ["kUTTypeImage"]
        pickerController.delegate = self
        return pickerController
    }()
    
    private var scavInfo = scavengerItems {
        didSet{
            DispatchQueue.main.async {
                self.scavengerCollection.reloadData()
            }
            print(scavInfo)
        }
    }
    
    private var activityData = [ActivityData](){
        didSet{
            DispatchQueue.main.async {
                self.scavengerCollection.reloadData()
            }
        }
    }
    
//    private var selectedImage: UIImage?
    private var currentItem: ScavengerInfo?
    private var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(scavInfo)
        setUpCollectionView()
        setUpNavItems()
        fetchActivities()
    }
    
    private func setUpCollectionView() {
        scavengerCollection.delegate = self
        scavengerCollection.dataSource = self
    }
    
    private func fetchActivities() {
        activityData = CoreDataManager.shared.fetchMediaObjects()
    }
    
    private func setUpNavItems() {
        navigationItem.title = "Scavenger Hunt"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "questionmark.circle"), style: .plain, target: self, action: #selector(promptButtonPressed))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "photo.on.rectangle"), style: .plain, target: self, action: #selector(photoLibraryPressed))
    }
    
    @objc private func promptButtonPressed() {
        print("prompt")
    }
    
    @objc private func photoLibraryPressed(){
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true)
    }
    
//    private func addNewUserImage() {
//        guard let image = selectedImage else {
//                print("image is nil")
//                return
//        }
//
//        let size = UIScreen.main.bounds.size
//
//        let rect = AVMakeRect(aspectRatio: image.size, insideRect: CGRect(origin: CGPoint.zero, size: size))
//
//        let huntItem = ScavengerInfo(title: currentItem?.title ?? "title empty", image: image)
//        //add item into struct
//
//        scavInfo[index] = huntItem
//        print(scavInfo)
//        scavengerCollection.reloadData()
//    }
    
}

extension ScavengerViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxSize: CGSize = UIScreen.main.bounds.size
        let spacingBetweenItems: CGFloat = 10
        let numberOfItems: CGFloat = 2
        let totatSpacing: CGFloat = (2 * spacingBetweenItems) + (numberOfItems - 1) * spacingBetweenItems
        let itemWidth: CGFloat = (maxSize.width - totatSpacing) / numberOfItems
        let itemHeight: CGFloat = maxSize.height * 0.20
        return  CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return scavInfo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "scavengerCell", for: indexPath) as? ScavengerCell else {
            fatalError("could not downcast to scavCell")
        }
        
        let huntItem = scavInfo[indexPath.row]
        print(activityData.count)
        
        cell.configureCell(for: huntItem)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            imagePickerController.sourceType = .photoLibrary
            present(imagePickerController, animated: true)
        currentItem = scavengerItems[indexPath.row]
        index = indexPath.row
        
    }
}

extension ScavengerViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage, let imageData = originalImage.jpegData(compressionQuality: 1.0){
            scavInfo[index].image = originalImage
            let mediaObject = CoreDataManager.shared.create(imageData, videoURL: nil)
            activityData.append(mediaObject)
        }

        
        dismiss(animated: true)
    }
    
    
    
}
