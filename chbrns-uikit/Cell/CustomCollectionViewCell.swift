//
//  CustomCollectionViewCell.swift
//  chbrns-uikit
//
//  Created by Alex Kosenko on 21.04.2023.
//

import UIKit


class CustomCollectionViewCell: UICollectionViewCell {
    
    let tapAnimation = TapAnimation()

    @IBOutlet weak var documentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(with document: String) {
        documentLabel.text = document
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        documentLabel.text = nil
    }
    
    
//    private func setupGestureRecognizer() {
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
//        self.addGestureRecognizer(tapGesture)
//    }
//    
//    @objc private func handleTap(_ sender: UITapGestureRecognizer) {
//        animateTapBegan {
//            self.animateTapEnded {
//                // Notify the view controller that the tap has completed
//                self.delegate?.didCompleteTapAnimation(for: self)
//            }
//        }
//    }
//    
//    func animateTapBegan(completion: (() -> Void)? = nil) {
//        UIView.animate(withDuration: 0.2, animations: {
//            self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
//        }, completion: { _ in
//            completion?()
//        })
//    }
//
//    func animateTapEnded(completion: (() -> Void)? = nil) {
//        UIView.animate(withDuration: 0.2, animations: {
//            self.transform = CGAffineTransform.identity
//        }, completion: { _ in
//            completion?()
//        })
//    }
    
    
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        super.touchesBegan(touches, with: event)
//        animateSelection(isSelected: true)
//    }
//
//    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
//        super.touchesCancelled(touches, with: event)
//        animateSelection(isSelected: false)
//    }
//
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        super.touchesEnded(touches, with: event)
//        animateSelection(isSelected: false)
//
//    }
//
//    func animateSelection(isSelected: Bool) {
//        if isSelected {
//            UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
//                self.tapAnimation.optionsForStartAnimation(view: self, color: Consts.Colors.tappedGray)
//            })
//        } else {
//            UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
//                self.tapAnimation.optionsForEndAnimation(view: self)
//            })
//        }
//    }
//
}
