//
//  TapAnimation.swift
//  chbrns-uikit
//
//  Created by Alex Kosenko on 20.04.2023.
//

import UIKit

class TapAnimation {

    let layerColor = CALayer()
    
    func optionsForStartAnimation(view: UIView, color: UIColor) {
        view.transform = CGAffineTransform(scaleX: 0.99, y: 0.99)
        layerColor.frame = view.bounds
        layerColor.backgroundColor = color.cgColor
        view.layer.addSublayer(layerColor)
    }
    
    func optionsForEndAnimation(view: UIView) {
        view.layer.sublayers?.removeLast()
        view.transform = .identity
    }
    
    func tappedStart(view: UIView, color: UIColor, copmletions: @escaping () -> Void = {}) {
        UIView.animate(withDuration: 0.1, delay: 0, options: [.curveEaseInOut], animations: {
            self.optionsForStartAnimation(view: view, color: color)
        }, completion: { _ in
            copmletions()
        })
    }
    
    func tappedEnd(view: UIView) {
        UIView.animate(withDuration: 0.1, animations: {
            self.optionsForEndAnimation(view: view)
        })
    }
}

