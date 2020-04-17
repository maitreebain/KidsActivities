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
    
    override func loadView() {
        view = letterView
    }
    
    let letters = [LetterObject]()
    
    private var selectedImage: UIImage? {
        didSet{
            addNewImage()
        }
    }
    
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
        //turn this into an action sheet
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let imageAction = UIAlertAction(title: "Photo Library", style: .default) { (alertAction) in
            self.imagePickerController.sourceType = .photoLibrary
            self.present(self.imagePickerController, animated: true)
        }
        let videoAction = UIAlertAction(title: "Camera", style: .default) { (alertAction) in
            self.imagePickerController.sourceType = .camera
        }
        alertController.addAction(imageAction)
        alertController.addAction(videoAction)
        present(alertController, animated: true)
    }
    
    private func addNewImage() {
        guard let image = selectedImage else {
            print("image is nil")
            return
        }
        let size = UIScreen.main.bounds.size
        let rect = AVMakeRect(aspectRatio: image.size, insideRect: CGRect(origin: CGPoint.zero, size: size))
        let resizeImage = image.resizeImage(to: rect.size.width, height: rect.size.height)
        
        print("resized: \(resizeImage.size)")
        
        guard let resizedImageData = resizeImage.jpegData(compressionQuality: 1.0) else {
            return
        }
        
        let letterItem = LetterObject(letter: letterView.letterTextView.text, image: selectedImage)
        
        
    }
}

extension LetterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let mediaType = info[UIImagePickerController.InfoKey.mediaType] as? String else  {
            return
        }
        switch mediaType {
        case "public.image":
            print("save image")
        case "public.video":
            print("save video")
        default:
            print("unsupported media type")
        }
    
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
