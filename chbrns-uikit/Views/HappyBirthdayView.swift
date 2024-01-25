//
//  InfoView.swift
//  chbrns-uikit
//
//  Created by Alex Kosenko on 03.05.2023.
//

import UIKit
import Lottie

class HappyBirthdayView: UIView, PopUpable {

    var lottieAnimationView: LottieAnimationView!
    var viewLabel: UILabel!
    var nameOfLottieAnimation: String!
    var viewButton: UIButton!
    var nameOfAnimation: String! = String()
    
    override init(frame: CGRect) {
        self.nameOfLottieAnimation = nameOfAnimation
        super.init(frame: frame)

        setupInfoAnimationView()
        setupInfoViewLabal()
        setupWarningButton()
    }
    
    required init?(coder aDecoder: NSCoder, nameOfAnimation: String) {
        self.nameOfLottieAnimation = nameOfAnimation
        super.init(coder: aDecoder)

        setupInfoAnimationView()
        setupInfoViewLabal()
        setupWarningButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupInfoAnimationView() {
        addSubview(self.backgroundAnimationView)
        lottieAnimationView = .init(name: "HB")
        lottieAnimationView.frame = CGRect(x: (frame.size.width - 350) / 2, y: (frame.size.height - 460), width: 350, height: 280)
        lottieAnimationView.backgroundColor = .clear
        lottieAnimationView.layer.cornerRadius = 14
        lottieAnimationView.layer.masksToBounds = true
        lottieAnimationView.contentMode = .scaleAspectFit
        lottieAnimationView.loopMode = .loop
        lottieAnimationView.animationSpeed = 1.0
        addSubview(lottieAnimationView)
//        lottieAnimationView.play()
    }
    
    func setupInfoViewLabal() {
        viewLabel = UILabel(frame: CGRect(x: (frame.size.width - 250) / 2, y: (frame.size.height - 225), width: 260, height: 145))
        viewLabel.backgroundColor = .clear
        viewLabel.textColor = .white
        viewLabel.font = UIFont(name: "Jura-Medium", size: 24)
        viewLabel.textAlignment = .center
        viewLabel.numberOfLines = 0
        viewLabel.lineBreakMode = .byWordWrapping
        viewLabel.adjustsFontSizeToFitWidth = true
        viewLabel.minimumScaleFactor = 0.5
        addSubview(viewLabel)
    }
    
    func setupWarningButton() {
        viewButton = UIButton(frame: CGRect(x: (frame.size.width - 250) / 2, y: (frame.size.height - 90), width: 250, height: 50))
        viewButton.backgroundColor = UIColor(named: "customGray")?.withAlphaComponent(0.6)
        viewButton.setTitle("Закрити привітання", for: .normal)
        viewButton.setTitleColor(.white, for: .normal)
        viewButton.titleLabel?.font = UIFont(name: "Jura-Medium", size: 20)
        viewButton.layer.cornerRadius = 14
        viewButton.layer.masksToBounds = true
        
        // add tap animation to button
        
        viewButton.addTarget(self, action: #selector(infoViewButtonTapped), for: .touchUpInside)
        addSubview(viewButton)
    }
    
    @objc func infoViewButtonTapped() {
        
        
        UIView.animate(withDuration: 0.1) {
            self.viewButton.transform = CGAffineTransform(scaleX: 0.97, y: 0.97)
            self.viewButton.alpha = 0.8
        } completion: { (finished) in
            UIView.animate(withDuration: 0.1) {
                self.viewButton.transform = CGAffineTransform.identity
                self.viewButton.alpha = 1.0
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            UIView.animate(withDuration: 0.3) {
                self.alpha = 0.0
                if let parentVC = self.superview?.next as? ViewController {
                    parentVC.collectionView.isUserInteractionEnabled = true
                }
            }
        }
    }
}
