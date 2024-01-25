//
//  AlphabetViewController.swift
//  chbrns-uikit
//
//  Created by Alex Kosenko on 03.05.2023.
//

import UIKit

class AlphabetViewController: FirstDocument {

    @IBOutlet weak var alphabetImage: UIImageView!
    
    
    var isImageToggled = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fourFingerTap = UITapGestureRecognizer(target: self, action: #selector(fourFingerTapped))
            fourFingerTap.numberOfTouchesRequired = 5
            view.addGestureRecognizer(fourFingerTap)
    }
    
    @objc func fourFingerTapped() {
        if isImageToggled {
            // Set the original image
            alphabetImage.image = UIImage(named: "Alphabet")
        } else {
            // Set the new image
            alphabetImage.image = UIImage(named: "AlphabetV2")
        }
        
        // Toggle the boolean value
        isImageToggled.toggle()
    }
}
