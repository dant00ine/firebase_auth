//
//  UploadMemeViewController.swift
//  firebase-auth
//
//  Created by Daniel Thompson on 7/19/17.
//  Copyright © 2017 Daniel Thompson. All rights reserved.
//

import UIKit
import FirebaseStorage

class UploadMemeViewController: UIViewController {

    @IBOutlet weak var previewImageView: UIImageView!
    @IBOutlet weak var imageTitleField: UITextField!
    
    var imagePicker: UIImagePickerController?
    
    var storageRef: StorageReference!
    var imagesRef: StorageReference!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker = UIImagePickerController()
        imagePicker?.delegate = self
        
        let storage = Storage.storage()
        storageRef = storage.reference()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func chooseImagePressed(_ sender: UIButton) {
        
        self.present(imagePicker!, animated: true, completion: nil)
        
    }

    @IBAction func uploadPressed(_ sender: UIButton) {
        
        if let image = previewImageView.image {
            if let imageData = image.jpeg(quality: .medium) {
                imagesRef = storageRef.child("images/\(imageTitleField.text!).jpg")
                imagesRef.putData(imageData, metadata: nil ){ ( metadata, error ) in
                    guard let metadata = metadata else {
                        print("unable to find metadata from putData response with error \(String(describing: error?.localizedDescription))")
                        return
                    }
                    print("finished uploading image with \(metadata)")
                }
            }
        }
    }
    
}

extension UploadMemeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print("did finish picking media with info: \(String(describing: info))")
        
        let image = info["UIImagePickerControllerOriginalImage"] as? UIImage
        
        previewImageView.image = image
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
}

extension UIImage {
    
    enum JPEGQuality: CGFloat {
        case lowest = 0.0
        case low = 0.25
        case medium = 0.5
        case high = 0.75
        case highest = 1.0
    }
    
    var png: Data? { return UIImagePNGRepresentation(self) }
    
    /// - returns: A data object containing the JPEG data at the specified quality
    func jpeg(quality: JPEGQuality) -> Data? {
        return UIImageJPEGRepresentation(self, quality.rawValue)
    }
    
}



