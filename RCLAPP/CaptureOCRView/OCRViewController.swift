//
//  OCRViewController.swift
//  RCLAPP
//
//  Created by Omar Al Romaithi on 13/03/2020.
//  Copyright © 2020 UCarrot Software & Design. All rights reserved.
//

import UIKit

class OCRViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    let kTextRecog = "textRecognize" //this is the name of the segue
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var galleryButton: UIButton!
    @IBOutlet weak var analyzeButton: UIButton!
    
    //lazy variable functions, means it will not be initialized until it is called first. the memory will not be allocated until it comes in use. complier skip this function until later. memory effecient.
    lazy var imagePicker: UIImagePickerController = {
        return UIImagePickerController()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker.delegate = self
        //round corner
        cameraButton.layer.cornerRadius = 10
        cameraButton.layer.borderColor = #colorLiteral(red: 0.5787474513, green: 0.3215198815, blue: 0, alpha: 1)
        cameraButton.layer.borderWidth = 0.3
        galleryButton.layer.cornerRadius = 10
        galleryButton.layer.borderColor = #colorLiteral(red: 0.5807035565, green: 0.3225829303, blue: 0.005224436522, alpha: 1)
        galleryButton.layer.borderWidth = 0.3
        analyzeButton.layer.cornerRadius = 10
        analyzeButton.layer.borderColor = #colorLiteral(red: 0.5807035565, green: 0.3225829303, blue: 0.005224436522, alpha: 1)
        analyzeButton.layer.borderWidth = 0.3
    }
    
    //MARK: IBActions
    
    @IBAction func chooseImage(_ sender: UIButton) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary //.camera
        
        //present image picker controller
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func openCamera(_ sender: Any) {
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .camera
        
        //present image picker controller
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    
    //MARK: image picker controller delegate methods
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }
    //cancel
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: segue actions
    
    @IBAction func textRecognize(_ sender: UIButton) {
        
        performSegue(withIdentifier: kTextRecog , sender: self)
    }
    
    //MARK: prepare seque
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == kTextRecog {
            let vc = segue.destination as! AutoItemListViewController
            vc.sourceImage = self.imageView.image
            
        }
    }
    
}
