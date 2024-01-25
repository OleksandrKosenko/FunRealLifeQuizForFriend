//
//  SearchAnimationView.swift
//  chbrns-uikit
//
//  Created by Alex Kosenko on 03.05.2023.
//

import UIKit
import Lottie

class SearchAnimationView: UIView, PopUpable {
    
    var lottieAnimationSearchView: LottieAnimationView!
    var lottieAnimationView: LottieAnimationView!
    var viewLabel: UILabel!
    var nameOfLottieAnimation: String!
    
    override init(frame: CGRect) {
        self.nameOfLottieAnimation = String()
        super.init(frame: frame)
        setupAnimationSearchView()
        setupAnimationBarView()
        viewLabel = UILabel()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.nameOfLottieAnimation = String()
        super.init(coder: aDecoder)
        setupAnimationSearchView()
        setupAnimationBarView()
        viewLabel = UILabel()
    }

    
    func setupAnimationSearchView() {
        addSubview(self.backgroundAnimationView)
        lottieAnimationSearchView = .init (name: "125763-searching")
        lottieAnimationSearchView.frame = CGRect(x: (frame.size.width - 300) / 2, y: (frame.size.height - 310), width: 300, height: 125)
        lottieAnimationSearchView.backgroundColor = .clear
        lottieAnimationSearchView.layer.cornerRadius = 14
        lottieAnimationSearchView.layer.masksToBounds = true
        lottieAnimationSearchView.contentMode = .scaleAspectFit
        lottieAnimationSearchView.loopMode = .loop
        lottieAnimationSearchView.animationSpeed = 1.0
        addSubview(lottieAnimationSearchView)
        lottieAnimationSearchView.play()
    }
    
    func setupAnimationBarView() {
        lottieAnimationView = .init (name: "52652-loading-bar")
        lottieAnimationView.frame = CGRect(x: (frame.size.width - 200) / 2, y: (frame.size.height - 200) / 2, width: 200, height: 340)
//        lottieAnimationBarView.contentMode = .scaleAspectFit
        //        lottieAnimationBarView.loopMode = .loop
        lottieAnimationView.animationSpeed = 0.9
        addSubview(lottieAnimationView)
        
    }
    
}
