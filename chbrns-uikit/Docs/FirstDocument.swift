//
//  FirstDocument.swift
//  chbrns-uikit
//
//  Created by Alex Kosenko on 21.04.2023.
//

import UIKit

protocol Documentable: UIViewController {
    var tittleNavigationBar: String! { get set }
}

class FirstDocument: UIViewController, Documentable {
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var mapImage: UIImageView!
    
    var image: UIImageView!
    var tittleNavigationBar: String! = String()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupImageAppearance()
    }

    func setupImageAppearance() {
        guard let mapImageView = mapImage else { return }

        mapImageView.layer.cornerRadius = 14
        mapImageView.contentMode = .scaleAspectFill
        mapImageView.layer.masksToBounds = true
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        
        guard let mapImageView = mapImage else { return }
        // make image zoomable and movable with two fingers
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(pinchGesture(sender:)))
        mapImageView.addGestureRecognizer(pinchGesture)
        mapImageView.isUserInteractionEnabled = true
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGesture(sender:)))
        mapImageView.addGestureRecognizer(panGesture)
        mapImageView.isUserInteractionEnabled = true
        
    }
    
    @objc func pinchGesture(sender: UIPinchGestureRecognizer) {
        guard let view = sender.view else { return }
        
        if sender.state == .began {
            let pinchLocationInView = sender.location(in: view)
            let pinchLocationInSuperview = sender.location(in: view.superview)
            
            view.layer.anchorPoint = CGPoint(x: pinchLocationInView.x / view.bounds.width,
                                              y: pinchLocationInView.y / view.bounds.height)
            view.center = pinchLocationInSuperview
        } else if sender.state == .changed {
            view.transform = view.transform.scaledBy(x: sender.scale, y: sender.scale)
            sender.scale = 1
            
        }
//        } else if sender.state == .ended {
//            UIView.animate(withDuration: 0.3, animations: {
//                view.transform = CGAffineTransform.identity
//            })
//        }
    }

    @objc func panGesture(sender: UIPanGestureRecognizer) {
        guard let view = sender.view else { return }
        
        if sender.state == .began || sender.state == .changed {
            let translation = sender.translation(in: view.superview)
            view.center = CGPoint(x: view.center.x + translation.x, y: view.center.y + translation.y)
            sender.setTranslation(CGPoint.zero, in: view.superview)
        }
//        } else if sender.state == .ended {
//            UIView.animate(withDuration: 0.3, animations: {
//                view.center = CGPoint(x: view.superview!.bounds.midX, y: view.superview!.bounds.midY)
//            })
//        }
    }
    

    
    func setupNavigationBar() {
        let attributes = [NSAttributedString.Key.font: UIFont(name: "Jura-Bold", size: 20)!]
        UINavigationBar.appearance().titleTextAttributes = attributes
        self.navigationController?.navigationBar.barTintColor = UIColor.red
        
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(backButtonPressed(_:)))
        backButton.tintColor = UIColor(named: "customGray")
        
        let navItem = UINavigationItem(title: tittleNavigationBar)
        navItem.titleView?.tintColor = UIColor(named: "customGray")
        
        navItem.leftBarButtonItem = backButton
        
        navigationBar.items = [navItem]
    }
    
    @objc func backButtonPressed(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }

}
