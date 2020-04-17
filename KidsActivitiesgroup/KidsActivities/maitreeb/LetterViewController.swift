//
//  ViewController.swift
//  ActivitySideProj
//
//  Created by Maitree Bain on 4/15/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class LetterViewController: UIViewController {
    
    private let letterView = View()
    
    private var activityName = "Letter"
    
    override func loadView() {
        view = letterView
    }
    
    var letters = [ActivityData](){
        didSet{
            letterView.lettCollectionView.reloadData()
        }
    }
    
    var index = 0
    
    private lazy var imagePickerController: UIImagePickerController = {
        let mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)
        let pickerController = UIImagePickerController()
        pickerController.mediaTypes = mediaTypes ?? ["kUTTypeImage"]
        pickerController.delegate = self
        return pickerController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        letterView.letterTextView.delegate = self
        setUpNavItems()
        configureCollectionView()
        fetchMediaObjects()
        updateUI()
    }
    
    
    
    private func setUpNavItems() {
        navigationItem.title = "Scavenger Hunt"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "questionmark.circle"), style: .plain, target: self, action: #selector(promptButtonPressed))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "photo.on.rectangle"), style: .plain, target: self, action: #selector(photoLibraryPressed))
         letterView.submitButton.addTarget(self, action: #selector(submitButtonPressed(_:)), for: .touchUpInside)
    }
    
    private func configureCollectionView() {
        letterView.lettCollectionView.delegate = self
        letterView.lettCollectionView.dataSource = self
        letterView.lettCollectionView.register(LetterCell.self, forCellWithReuseIdentifier: "letterCell")
    }
    
    private func updateUI() {
        guard let current = letters.last else { return }
        if let image = current.imageData {
            letterView.letterImageView.image = UIImage(data: image)
        }
    }
    
    @objc private func promptButtonPressed() {
        print("prompt")
    }
    
    @objc private func submitButtonPressed(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Empty Fields", message: "Please enter some text", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(cancelAction)
        if letterView.letterTextView.text == "" {
            present(alertController, animated: true)
        }
    }
    
    @objc private func photoLibraryPressed(){
        //turn this into an action sheet
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let imageAction = UIAlertAction(title: "Photo Library", style: .default) { (alertAction) in
            self.imagePickerController.sourceType = .photoLibrary
            self.present(self.imagePickerController, animated: true)
        }
        let videoAction = UIAlertAction(title: "Camera", style: .default) { (alertAction) in
            self.imagePickerController.sourceType = .camera
            self.present(self.imagePickerController, animated: true)
        }
        alertController.addAction(imageAction)
        alertController.addAction(videoAction)
        present(alertController, animated: true)
    }
    
    private func fetchMediaObjects() {
        letters = CoreDataManager.shared.fetchMediaObjects().filter { $0.activityName == activityName}
    }
    
}

extension LetterViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSpacing: CGFloat = 1
        let maxWidth = CGFloat(80)
        let numberOfItems: CGFloat = 1
        let totalSpace: CGFloat = numberOfItems * itemSpacing
        let itemWidth: CGFloat = (maxWidth - totalSpace) / numberOfItems
        
        return CGSize(width: itemWidth, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return letters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "letterCell", for: indexPath) as? LetterCell else {
            fatalError("could not downcast to LetterCell")
        }
        let letter = letters[indexPath.row]
        cell.configureCell(letter)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //move this to when image is interactable
        //        let playerController = AVPlayerViewController()
        //        let letter = letters[indexPath.row]
        //        guard let videoURL = letter.videoData?.convertToURL() else { return}
        //        let player = AVPlayer(url: videoURL)
        //        playerController.player = player
        //        present(playerController, animated: true) {
        //            player.play()
        //        }
        index = indexPath.row
        if let image = letters[index].imageData {
            letterView.letterImageView.image = UIImage(data: image)
        }
    }
    
    
}

extension LetterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let mediaType = info[UIImagePickerController.InfoKey.mediaType] as? String else  {
            return
        }
        
        switch mediaType {
        case "public.image":
            if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage, let imageData = originalImage.jpegData(compressionQuality: 1.0){
                guard let text = letterView.letterTextView.text else { return }
                let mediaObject = CoreDataManager.shared.create(imageData, videoURL: nil, personifedItem: nil, activityName: activityName, caption: text)
                letters.append(mediaObject)
                print("saved image")
            }
        case "public.video":
            if let mediaURL = info[UIImagePickerController.InfoKey.mediaURL] as? URL,
                let image = mediaURL.videoPreviewThumbnail(),
                let imageData = image.jpegData(compressionQuality: 1.0)
            {
                guard let text = letterView.letterTextView.text else { return }
                let mediaObject = CoreDataManager.shared.create(imageData, videoURL: mediaURL, personifedItem: nil, activityName: activityName, caption: text)
                letters.append(mediaObject)
                print("saved video: \(text)")
            }
        default:
            print("unsupported media type")
        }
        
        
        print(mediaType)
        dismiss(animated: true)
    }
    
}
extension LetterViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Type your letter here" {
            textView.text = ""
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.resignFirstResponder()
    }
}

extension UIImage {
    func resizeImage(to width: CGFloat, height: CGFloat) -> UIImage {
        let size = CGSize(width: width, height: height)
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { (context) in
            self.draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
