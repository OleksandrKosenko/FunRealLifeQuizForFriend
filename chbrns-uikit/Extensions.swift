//
//  Extensions.swift
//  chbrns-uikit
//
//  Created by Alex Kosenko on 21.04.2023.
//

import UIKit

extension UIViewController: UIGestureRecognizerDelegate {
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}


extension UIImageView {
    
    open override func draw(_ rect: CGRect) {
        guard let image = self.image else { return }
        
        let context = UIGraphicsGetCurrentContext()
        context?.interpolationQuality = .high // Set the interpolation quality
        
        let imageRect = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
        image.draw(in: imageRect)
    }
}

extension UIView {
    
    func setupBackgroundAnimationView() -> UIView {
        let backgroundAnimationView = UIView(frame: CGRect(x: (frame.size.width - 300) / 2, y: (frame.size.height - 380) / 2, width: 300, height: 380))
        backgroundAnimationView.backgroundColor = .clear
        backgroundAnimationView.layer.cornerRadius = 14
        backgroundAnimationView.layer.masksToBounds = true
        addSubview(backgroundAnimationView)
        let blurEffect = UIBlurEffect(style: .systemMaterialDark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = backgroundAnimationView.bounds
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        backgroundAnimationView.insertSubview(blurView, at: 0)
        return backgroundAnimationView
    }
    
    public var backgroundAnimationView : UIView {
        return setupBackgroundAnimationView()
    }
    
}


extension String {
    
    func containsEhor() -> Bool {
        let words = ["Егор", "Егор", "Егор", "Егор", "Єгор", "єгор"]
        
        for word in words {
            // ignoring case
            if localizedCaseInsensitiveContains(word) {
                return true
            }
        }
        return false
    }
    func containsHintCezar() -> Bool {
        let words = ["бдкзйзї ґил внпзшд"]
        
        for word in words {
            // ignoring case
            if localizedCaseInsensitiveContains(word) {
                return true
            }
        }
        return false
    }
    
    func containsHintLettersToCoords() -> Bool {
        let words = ["да.жавґгзз, Ю.азжежґє", "Да.Жавґгзз, Ю.Азжежґє", "да.жавґгзз ю.азжежґє", "да,жавґгзз, ю,азжежґє", "да,жавґгзз, ю,азжежґє" ]
        
        for word in words {
            // ignoring case
            if localizedCaseInsensitiveContains(word) {
                return true
            }
        }
        return false
    }
    
    func containsHintNumbersToTree() -> Bool {
        let words = ["32-15-10-17-14-00", "32 15 10 17 14 00"]
        
        for word in words {
            // ignoring case
            if localizedCaseInsensitiveContains(word) {
                return true
            }
        }
        return false
    }
    
    //check all hints
    func containsAtLeastOneHint() -> Bool {
        
        if containsHintLettersToCoords() || containsHintCezar() || containsHintNumbersToTree() {
            return true
        }
        return false
    }
    
    func containsBadWord()->Bool {
        //Sorry for bad words
        let badWords = ["fuck"]
        for word in badWords {
            // ignoring case
            if localizedCaseInsensitiveContains(word) {
                return true
            }
        }
        return false
    }
    
    func containsFirstDocument() -> Bool {
        let documentNames = ["50.8022689, 31.1022668", "50,8022689, 31,1022668", "50.8022689 31.1022668", "50,8022689 31,1022668", "(50.8022689, 31.1022668)", "(50,8022689, 31,1022668)", "(50.8022689 31.1022668)", "(50,8022689 31,1022668)"]
        for documentName in documentNames {
            if localizedCaseInsensitiveContains(documentName) {
                // check number of letters
                return true
            }
        }
        return false
    }
    
    func containsSecondDocument() -> Bool {
        let documentNames = ["ротомотор", "рото мотор", "rotomotor", "roto motor"]
        for documentName in documentNames {
            if localizedCaseInsensitiveContains(documentName) {
                return true
            }
        }
        return false
    }
    
    func containsThirdDocument() -> Bool {
        let documentNames = ["50.8020064, 31.1003959", "50,8020064, 31,1003959", "50.8020064 31.1003959", "50,8020064 31,1003959", "(50.8020064, 31.1003959)", "(50,8020064, 31,1003959)", "(50.8020064 31.1003959)", "(50,8020064 31,1003959)"]
        for documentName in documentNames {
            if localizedCaseInsensitiveContains(documentName) {
                return true
            }
        }
        return false
    }
    
    func containsFourthDocument() -> Bool {
        let documentNames = ["50.8024399, 31.0986847", "50,8024399, 31,0986847", "50.8024399 31.0986847", "50,8024399 31,0986847", "(50.8024399, 31.0986847)", "(50,8024399, 31,0986847)", "(50.8024399 31.0986847)", "(50,8024399 31,0986847)"]
        for documentName in documentNames {
            if localizedCaseInsensitiveContains(documentName) {
                return true
            }
        }
        return false
    }
    
    func containsAtLeastOneDocument() -> Bool {
        if containsFirstDocument() || containsSecondDocument() || containsThirdDocument() || containsFourthDocument() {
            return true
        }
        return false
    }
}
