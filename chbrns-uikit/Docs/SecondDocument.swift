//
//  SecondDocument.swift
//  chbrns-uikit
//
//  Created by Alex Kosenko on 21.04.2023.
//

import UIKit

class SecondDocument: UIViewController, Documentable {
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    @IBOutlet weak var  rotoMotor: UIImageView?
    @IBOutlet weak var  fingerPrints: UIImageView?
    @IBOutlet weak var  upperTextLabel: UILabel!
    @IBOutlet weak var  lowerTextLabel: UILabel!
    
    
    var tittleNavigationBar: String! = String()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        
        let text = "На місці розслідування було знайдено речові докази, а саме: китайський роторний двигун з відбитками пальців, та сліди пилку рідкісної вишні."
        let attributedText = NSMutableAttributedString(string: text)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .justified
        paragraphStyle.hyphenationFactor = 0.9
        paragraphStyle.lineBreakMode = .byWordWrapping
        
        let fullRange = NSRange(location: 0, length: attributedText.length)
        attributedText.addAttribute(.paragraphStyle, value: paragraphStyle, range: fullRange)
        
        upperTextLabel.attributedText = attributedText
        
        let text2 = "За результатами лабораторного аналізу було знайдене місце походження речовини, а саме, дім через дорогу від помешкання Кюрасао."
        let attributedText2 = NSMutableAttributedString(string: text2)
        
        let paragraphStyle2 = NSMutableParagraphStyle()
        paragraphStyle2.alignment = .justified
        paragraphStyle2.hyphenationFactor = 1
        paragraphStyle2.lineBreakMode = .byWordWrapping
        
        let fullRange2 = NSRange(location: 0, length: attributedText2.length)
        attributedText2.addAttribute(.paragraphStyle, value: paragraphStyle2, range: fullRange2)
        
        lowerTextLabel.attributedText = attributedText2
        
    
        guard let rotoMotorImageView = rotoMotor, let fingerPrintsImageView = fingerPrints else { return }

            // Configure image views
        configureImageView(rotoMotorImageView)
        configureImageView(fingerPrintsImageView)
        
    }
    
    func configureImageView(_ imageView: UIImageView) {
        imageView.layer.cornerRadius = 14
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.isUserInteractionEnabled = true

        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(pinchGesture(sender:)))
        imageView.addGestureRecognizer(pinchGesture)

        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGesture(sender:)))
        imageView.addGestureRecognizer(panGesture)
    }

    @objc func pinchGesture(sender: UIPinchGestureRecognizer) {
        guard let view = sender.view else { return }
        
        if sender.state == .began {
            self.view.bringSubviewToFront(view)
        }

        view.transform = view.transform.scaledBy(x: sender.scale, y: sender.scale)
        sender.scale = 1
    }

    @objc func panGesture(sender: UIPanGestureRecognizer) {
        guard let view = sender.view else { return }
        
        if sender.state == .began {
            self.view.bringSubviewToFront(view)
        }

        let translation = sender.translation(in: view.superview)

        view.center = CGPoint(x: view.center.x + translation.x, y: view.center.y + translation.y)
        sender.setTranslation(CGPoint.zero, in: view.superview)
    }
    
    
    func setupNavigationBar() {
        let attributes = [NSAttributedString.Key.font: UIFont(name: "Jura-Bold", size: 20)!]
        UINavigationBar.appearance().titleTextAttributes = attributes
        self.navigationController?.navigationBar.barTintColor = UIColor.red
        
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(backButtonPressed(_:)))
        backButton.tintColor = UIColor(named: "customGray")
        
        let navItem = UINavigationItem(title: "Документ №1337228")
        navItem.titleView?.tintColor = UIColor(named: "customGray")
        
        navItem.leftBarButtonItem = backButton
        
        navigationBar.items = [navItem]
    }
    
    @objc func backButtonPressed(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    
}
