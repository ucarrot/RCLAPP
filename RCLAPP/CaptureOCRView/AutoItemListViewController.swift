//
//  AutoItemListViewController.swift
//  RCLAPP
//
//  Created by Omar Al Romaithi on 13/03/2020.
//  Copyright © 2020 UCarrot Software & Design. All rights reserved.
//

import UIKit
import Firebase

class AutoItemListViewController: UIViewController {

    var sourceImage: UIImage?
    
    @IBOutlet weak var imageV: UIImageView!
    @IBOutlet weak var textV: UITextView!
    
    //MARK: Firebase var
    lazy var vision = Vision.vision() //vision service
    var textRecognizer : VisionTextRecognizer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.imageV.image = sourceImage
        self.textV.text = ""
        
        textRecognizer = vision.onDeviceTextRecognizer()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //OCR
        //documentation https://firebase.google.com/docs/ml-kit/ios/recognize-text
        let image = VisionImage(image: sourceImage!)
        textRecognizer?.process(image, completion: { (result, error) in
            
            guard error == nil, let _ = result else {
                print(error!.localizedDescription)
                return
            }
            
            print("recognized text it has \(String(describing: result?.text))")
            
            _ = result?.text
            
            for block in result!.blocks {
                let blockText = block.text
                let blockConfidence = block.confidence
                let blockLanguages = block.recognizedLanguages
                let blockCornerPoints = block.cornerPoints
                let blockFrame = block.frame
                for line in block.lines {
                    let lineText = line.text
                    for element in line.elements {
                        let elementText = element.text
                        let elementConfidence = element.confidence
                        let elementLanguages = element.recognizedLanguages
                        let elementCornerPoints = element.cornerPoints
                        let elementFrame = element.frame
                    }
                    self.textV.text = self.textV.text + " " + lineText + "\n"
            }
            }
        })
    }

    //MARK: IBActions
    

    @IBAction func cancelButtonPressed(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    

}
