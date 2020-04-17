//
//  ViewController.swift
//  drawView
//
//  Created by Tsering Lama on 4/16/20.
//  Copyright © 2020 Tsering Lama. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let canvas = CanvasView()
    
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    lazy var imagePickerController: UIImagePickerController = {
        let mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary) // photos or videos
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        return pickerController
    }()
    
    private var mediaObjects = [ActivityData]()
    
    override func loadView() {
        self.view = canvas
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        canvas.backgroundColor = .systemBackground
        
        if !UIImagePickerController.isSourceTypeAvailable(.camera) {
            cameraButton.isEnabled = false
        }
        
        fetchMediaObjects()
        dump(mediaObjects)
    }
    
    private func fetchMediaObjects() {
        mediaObjects = CoreDataManager.shared.fetchMediaObjects()
    }
    
    func takeScreenshot(view: UIView) -> UIImageView {
        UIGraphicsBeginImageContext(view.frame.size)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
        
        return UIImageView(image: image)
    }
    
    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {

        let newHeight = canvas.frame.height
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
    }

    @IBAction func clearAll(_ sender: UIBarButtonItem) {
        canvas.clear()
    }
    
    @IBAction func selecPhoto(_ sender: UIBarButtonItem) {
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true)
    }
    
    @IBAction func cameraOpened(_ sender: UIBarButtonItem) {
        imagePickerController.sourceType = .camera
        present(imagePickerController, animated: true)
    }
    
    
    @IBAction func screenshotPressed(_ sender: UIBarButtonItem) {
       let screenShot = takeScreenshot(view: canvas)
        
        guard let imageData = screenShot.image?.jpegData(compressionQuality: 1.0) else {
            return
        }
        
        let mediaObject = CoreDataManager.shared.create(imageData, videoURL: nil, personifedItem: nil, activityName: nil, caption: nil)
        mediaObjects.append(mediaObject)
        
        showAlert(title: "Success", message: "Screenshot taken")
    }
    
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }
                
        let newImage = resizeImage(image: image, newWidth: canvas.frame.width)
        
        canvas.backgroundColor = UIColor(patternImage: newImage)
        
        dismiss(animated: true)
    }
}
