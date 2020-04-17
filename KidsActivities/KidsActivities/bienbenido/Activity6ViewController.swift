//
//  Activity6ViewController.swift
//  Test
//
//  Created by Bienbenido Angeles on 4/16/20.
//  Copyright © 2020 Bienbenido Angeles. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class Activity6ViewController: UIViewController {
    
    @IBOutlet weak var descLabel: UILabel!
    
    @IBOutlet weak var instruLabel: UILabel!
    
    @IBOutlet weak var camButton: UIBarButtonItem!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private lazy var imagePickerController: UIImagePickerController = {
        let mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.mediaTypes = mediaTypes ?? ["kUTTypeImage"]
        return pickerController
    }()
    
    private var activities = [Activity](){
        didSet{
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        isCamDisabled()
        let createdAct = Activity(activityName: "Blur", personifiedObject: nil, imageData: nil, videoData: nil, videoURL: nil)
        activities.append(createdAct)
    }
    
    @IBAction func camButton(_ sender: UIBarButtonItem) {
        imagePickerController.sourceType = .camera
        present(imagePickerController, animated: true)
    }
    
    @IBAction func submitButtonPressed(_ sender: UIButton) {
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
    
    private func playRandomVideo(in view: UIView){

        
        let videoURLs = activities.compactMap{$0.videoData}
        
        // get a random video URL
        if let videoObject = videoURLs.randomElement(), let videoURL = videoObject.convertToURL()  {
            
            let player = AVPlayer(url: videoURL)
            
            let playerLayer = AVPlayerLayer(player: player)
            
            playerLayer.frame = view.bounds //take up the entire headerView
            playerLayer.videoGravity = .resizeAspect
            
            view.layer.sublayers?.removeAll()
            
            view.layer.addSublayer(playerLayer)
            
            player.play()
        }
    }
    

}

extension Activity6ViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      let maxSize: CGSize = UIScreen.main.bounds.size
        let itemWidth: CGFloat = maxSize.width * 0.9
      let itemHeight: CGFloat = maxSize.height * 0.40
      return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      let activity = activities[indexPath.row]
      guard let videoURL = activity.videoData?.convertToURL() else {
        return
      }
      let playerViewController = AVPlayerViewController()
      let player = AVPlayer(url: videoURL)
      playerViewController.player = player
      present(playerViewController, animated: true) {
        // play video automatically
        player.play()
      }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
      
      return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height * 0.40)
    }
}

extension Activity6ViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return activities.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "activity6Cell", for: indexPath) as? Activity6Cell else {
          fatalError("could not dequeue a MediaCell")
        }
        let activity = activities[indexPath.row]
        cell.configureCell(for: activity)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
      
      guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "activity6CellVideo", for: indexPath) as? HeaderView else {
        fatalError("could not dequeue a HeaderView")
      }
      playRandomVideo(in: headerView)
      return headerView // is of the UICollectionReusableView
    }
}

extension Activity6ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let mediaType = info[UIImagePickerController.InfoKey.mediaType] as? String else {
              return
            }
            
            switch mediaType {
            case "public.image":
              if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage,
                let imageData = originalImage.jpegData(compressionQuality: 1.0){
                
                let activity = Activity(activityName: "Color Slow-Mo", personifiedObject: nil, imageData: imageData, videoData: nil, videoURL: nil)
                activities.append(activity)
              }
            case "public.movie":
                if let mediaURL = info[UIImagePickerController.InfoKey.mediaURL] as? URL, let image = mediaURL.videoPreviewThumbnail(), let imageData = image.jpegData(compressionQuality: 1.0) {
                print("mediaURL: \(mediaURL)")
                    let activity = Activity(activityName: "Color Slow-Mo", personifiedObject: nil, imageData: imageData, videoData: nil, videoURL: mediaURL)
                activities.append(activity)
              }
            default:
              print("unsupported media type")
            }
            
            picker.dismiss(animated: true)
    }
}
