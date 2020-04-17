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
            scavengerCollection.reloadData()
        }
    }
    
    private var selectedImage: UIImage? {
        didSet{
            addNewUserImage()
        }
    }
    private var currentItem: ScavengerInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpCollectionView()
        setUpNavItems()
    }
    
    private func setUpCollectionView() {
        scavengerCollection.delegate = self
        scavengerCollection.dataSource = self
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
    
    private func addNewUserImage() {
        guard let image = selectedImage else {
                print("image is nil")
                return
        }

        let size = UIScreen.main.bounds.size
        
        let rect = AVMakeRect(aspectRatio: image.size, insideRect: CGRect(origin: CGPoint.zero, size: size))
        
        let huntItem = ScavengerInfo(title: currentItem?.title ?? "title empty", image: image)
        //add item into struct
    }
    
    
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
        return scavengerItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "scavengerCell", for: indexPath) as? ScavengerCell else {
            fatalError("could not downcast to scavCell")
        }
        
        let huntItem = scavengerItems[indexPath.row]
        currentItem = huntItem
        if cell.image != huntItem.image {
            cell.checkButton.isEnabled = true
        } else {
            cell.checkButton.isEnabled = false
        }
        
        cell.configureCell(for: huntItem)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            imagePickerController.sourceType = .photoLibrary
            present(imagePickerController, animated: true)
    }
}

extension ScavengerViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
                   print("image selection not found")
                   return
               }
        
        selectedImage = image
        currentItem?.image = selectedImage
        dismiss(animated: true)
    }
    
    
    
}
