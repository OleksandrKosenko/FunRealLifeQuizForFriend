//
//  ViewController.swift
//  chbrns-uikit
//
//  Created by Alex Kosenko on 20.04.2023.
//

import UIKit
import Foundation
import Lottie

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var underListLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var stepsButton: UIButton!
    @IBOutlet weak var alphabetButton: UIButton!
    
    let main = UIStoryboard(name: "Main", bundle: nil)

    let userDefaults = UserDefaults.standard
    let tapAnimation = TapAnimation()
    
    var infoView = InfoView()
    var badWordAlertView = InfoView()
    var hintAnimationView = HintView()
    var happyBirthday = HappyBirthdayView()
    var notFoundAnimationView = NotFoundView()
    var searchAnimationView = SearchAnimationView()
    var backgroundAnimationView: UIView!
    
    lazy var arrForSearch: [String] = userDefaults.object(forKey: "myKeyForArray") as? [String] ?? []
    lazy var isUnderLabalHidden: Bool = userDefaults.object(forKey: "myKeyForLabel") as? Bool ?? true
    lazy var isStepsButtonHidden: Bool = userDefaults.object(forKey: "myKeyForStepsButton") as? Bool ?? true
    lazy var isAlphabetButtonHidden: Bool = userDefaults.object(forKey: "myKeyForAlphabetButton") as? Bool ?? true
    var arrForNavigation = [String: String]()
    
    var savedArray = [String]()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Load the original image
        upadteArrayForNavigation()
        let image = logoImageView.image!
        let renderer = UIGraphicsImageRenderer(size: image.size)
        let resizedImage = renderer.image { _ in
            // Get a reference to the current context
            let context = UIGraphicsGetCurrentContext()!
            
            // Set the interpolation quality to high
            context.interpolationQuality = .high
            
            // Draw the original image into the context
            image.draw(in: CGRect(origin: .zero, size: image.size))
        }
        
        logoImageView.image = resizedImage
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //add key as element and value as document name
        upadteArrayForNavigation()
        print(arrForNavigation)
        
        setupButton(button: stepsButton) {
            stepsButton.setImage(UIImage(named: "footsteps"), for: .normal)
        }
        setupButton(button: alphabetButton) {
            alphabetButton.setImage(UIImage(systemName: "character.book.closed.fill"), for: .normal)
        }
        
        setupAnyInfoView(ofType: InfoView.self, view: &infoView, withText: "Дані цього документа вже завантажено")
        setupAnyInfoView(ofType: InfoView.self, view: &badWordAlertView, withText: "Наша агенція проти вживання таких слів у робочих файлах (Вам теж не радимо, а то будете як Парасюк)")
        setupAnyInfoView(ofType: NotFoundView.self, view: &notFoundAnimationView, withText: "За вашом запитом даних не знайдено")
        
        
        setupAnyInfoView(ofType: SearchAnimationView.self, view: &searchAnimationView)

        underListLabel.isHidden = isUnderLabalHidden
        stepsButton.isHidden = isStepsButtonHidden
        alphabetButton.isHidden = isAlphabetButtonHidden
        
        searchTextField.delegate = self
        
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        tap.cancelsTouchesInView = false
        
        configureGradient(view: view, colorTop: Consts.Colors.gradientGrayLight, colorBottom: Consts.Colors.gradientGrayDark)
        configureSearchView()
        configureCollectionView()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.reloadData()
    }
    
    func setupButton(button: UIButton, completion: ()->()) {
        // setup button only with image in center
        button.setTitle("", for: .normal)
        completion()
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
    }
    
    
    @IBAction func buttonStepsPressed(_ sender: Any) {
        if let stepsViewController = main.instantiateViewController(identifier: "StepsViewController") as? StepsViewController {
            stepsViewController.tittleNavigationBar = "Крокомір"
            navigationController?.pushViewController(stepsViewController, animated: true)
        }
    }
    
    @IBAction func buttonAlphabetPressed(_ sender: Any) {
        if let alphabetViewController = main.instantiateViewController(identifier: "AlphabetViewController") as? AlphabetViewController {
            alphabetViewController.tittleNavigationBar = "Алфавіт"
            navigationController?.pushViewController(alphabetViewController, animated: true)
        }
    }
    
    func upadteArrayForNavigation() {
        for element in arrForSearch {
            if element.containsFirstDocument() {
                arrForNavigation.updateValue("FirstDocument", forKey: element)
            }
            if element.containsSecondDocument() && !(element.containsFirstDocument())  {
                arrForNavigation.updateValue("SecondDocument", forKey: element)
            }
            
            if element.containsThirdDocument() && !(element.containsFirstDocument()) && !(element.containsSecondDocument()) {
                arrForNavigation.updateValue("ThirdDocument", forKey: element)
            }
            
            if element.containsFourthDocument() && !(element.containsFirstDocument()) && !(element.containsSecondDocument()) && !(element.containsThirdDocument()) {
                arrForNavigation.updateValue("FourthDocument", forKey: element)
            }
        }
    }
    
    func checkIfDocumentIsDownloaded(documentName: String) -> Bool {
        var isDownloaded = false
        
        for element in arrForSearch {
            if element.containsFirstDocument() && documentName.containsFirstDocument() {
                isDownloaded = true
            }
        }
        
        for element in arrForSearch {
            if element.containsSecondDocument() && documentName.containsSecondDocument() {
                isDownloaded = true
            }
        }
        
        for element in arrForSearch {
            if element.containsThirdDocument() && documentName.containsThirdDocument() {
                isDownloaded = true
            }
        }
        
        for element in arrForSearch {
            if element.containsFourthDocument() && documentName.containsFourthDocument() {
                isDownloaded = true
            }
        }
        
        return isDownloaded
    }
    
    func showView(_ view: UIView) {
        view.alpha = 0.0
        view.isHidden = false
    }
    
    func showViewAnimated(view: PopUpable, animationDuration: Double, completion: @escaping ()->()) {
        UIView.animate(withDuration: animationDuration) {
            view.alpha = 1.0
            view.isHidden = false
            view.lottieAnimationView.play()
            completion()
            self.collectionView.isUserInteractionEnabled = false
        }
    }
    
    
    func showSearchView(text: String?) {
        showViewAnimated(view: searchAnimationView, animationDuration: 0.3) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 7.3) {
                UIView.animate(withDuration: 0.3) {
                    self.searchAnimationView.alpha = 0.0
                    self.view.isUserInteractionEnabled = true
                } completion: { _ in
                    self.searchAnimationView.isHidden = true
                    self.collectionView.isUserInteractionEnabled = true
                }
                self.arrForSearch.append(text!)
                self.upadteArrayForNavigation()
                self.collectionView.reloadData()
                self.userDefaults.set(self.arrForSearch, forKey: "myKeyForArray")
                self.underListLabel.isHidden = false
                self.userDefaults.set(false, forKey: "myKeyForLabel")
                print(self.arrForNavigation)
            }
        }
    }
    
//    func showSearchView(text: String?, completion: @escaping () -> Void) {
//        showViewAnimated(view: searchAnimationView, animationDuration: 0.3) {
//            DispatchQueue.main.asyncAfter(deadline: .now() + 7.3) {
//                UIView.animate(withDuration: 0.3, animations: {
//                    self.searchAnimationView.alpha = 0.0
//                    self.view.isUserInteractionEnabled = true
//                }) { _ in
//                    self.searchAnimationView.isHidden = true
//                    self.collectionView.isUserInteractionEnabled = true
//
//                    completion() // Call the completion handler here
//
//                    self.arrForSearch.append(text!)
//                    self.upadteArrayForNavigation()
//                    self.collectionView.reloadData()
//                    self.userDefaults.set(self.arrForSearch, forKey: "myKeyForArray")
//                    self.underListLabel.isHidden = false
//                    self.userDefaults.set(false, forKey: "myKeyForLabel")
//                    print(self.arrForNavigation)
//                }
//            }
//        }
//    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        showView(searchAnimationView)
        
        var text = textField.text
        
        // Check if text is not empty and not contains only spaces
        if text != "" && text?.trimmingCharacters(in: .whitespacesAndNewlines) != "" {
            text = text?.trimmingCharacters(in: .whitespacesAndNewlines)
            textField.resignFirstResponder()
            
            switch text?.lowercased() {
                
            case let searchText where searchText!.containsBadWord():
                showViewAnimated(view: badWordAlertView, animationDuration: 0.3) {
                    self.badWordAlertView.lottieAnimationView.play()
                }
            case let searchText where checkIfDocumentIsDownloaded(documentName: searchText!):
                showViewAnimated(view: infoView, animationDuration: 0.3) {
                    self.infoView.lottieAnimationView.play()
                }
                
            case let searchText where searchText!.containsEhor():
                setupAnyInfoView(ofType: HappyBirthdayView.self, view: &happyBirthday, withText: "З Днем Народження!!!🎁🎊🎉✨")
                showViewAnimated(view: happyBirthday, animationDuration: 0.3) {
                    self.happyBirthday.lottieAnimationView.play()
                }
                
            case let searchText where searchText!.containsAtLeastOneHint():
                
                switch searchText {
                case let searchText where searchText!.containsHintLettersToCoords() && searchText!.count <= 24:
                    setupAnyInfoView(ofType: HintView.self, view: &hintAnimationView, withText: "Можливо Вам допоможе алфавіт у лівому кутку екрана")
                    showViewAnimated(view: hintAnimationView, animationDuration: 0.3) {
                        self.hintAnimationView.lottieAnimationView.play()
                    }
                    self.alphabetButton.isHidden = false
                    self.userDefaults.set(false, forKey: "myKeyForAlphabetButton")
                    
                    
                case let searchText where searchText!.containsHintCezar() && searchText!.count == 18:
                    setupAnyInfoView(ofType: HintView.self, view: &hintAnimationView, withText: "Експертиза підказує що це може бути шифр Цезаря. Алфавіт у кутку екрана стане Вам у нагоді!")
                    showViewAnimated(view: hintAnimationView, animationDuration: 0.3) {
                        self.hintAnimationView.lottieAnimationView.play()
                    }
                    self.alphabetButton.isHidden = false
                    self.userDefaults.set(false, forKey: "myKeyForAlphabetButton")
                    
                case let searchText where searchText!.containsHintNumbersToTree() && searchText!.count <= 17:
                    setupAnyInfoView(ofType: HintView.self, view: &hintAnimationView, withText: "Дуже дивні цифри... У цьому випадку навіть наша система не може нічого знайти")
                    showViewAnimated(view: hintAnimationView, animationDuration: 0.3) {
                        self.hintAnimationView.lottieAnimationView.play()
                    }
//                case let searchText where searchText!.containsThirdHint():
//                    setupAnyInfoView(ofType: HintView.self, view: &hintAnimationView, withText: "Схоже це підказка")
//                    showViewAnimated(view: hintAnimationView, animationDuration: 0.3) {
//                        self.hintAnimationView.lottieAnimationView.play()
//                    }
                    
                default:
                    showViewAnimated(view: notFoundAnimationView, animationDuration: 0.4) {
                        self.notFoundAnimationView.lottieAnimationView.play()
                    }
                }
                
                    
    
            case let searchText where searchText!.containsAtLeastOneDocument():
                
                switch searchText {
                case let searchText where searchText!.containsFirstDocument() && searchText!.count <= 24:
                    showSearchView(text: searchText!) //{}

                case let searchText where searchText!.containsSecondDocument() && searchText!.count <= 10:
                    showSearchView(text: searchText!) //{}
                    
                case let searchText where searchText!.containsThirdDocument() && searchText!.count <= 24:
                    showSearchView(text: searchText!)
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 7.7) {
                        self.setupAnyInfoView(ofType: HintView.self, view: &self.hintAnimationView, withText: "Тепер вам доступний компас та крокомір у правому кутку екрана!")
                        self.showViewAnimated(view: self.hintAnimationView, animationDuration: 0.4) {
                            self.hintAnimationView.lottieAnimationView.play()
                            self.stepsButton.isHidden = false
                            self.userDefaults.set(false, forKey: "myKeyForStepsButton")
                        }
                    }
                    //                    self.setupAnyInfoView(ofType: HintView.self, view: &self.hintAnimationView, withText: "Тепер вам доступний компас та крокомір у правому кутку екрана!")
                    //                    showSearchView(text: searchText!)
                    //                                        DispatchQueue.main.asyncAfter(deadline: .now() + 7.3) {
                    //                                            self.setupAnyInfoView(ofType: HintView.self, view: &self.hintAnimationView, withText: "Тепер вам доступний компас та крокомір у правому кутку екрана!")
                    //                                            self.showViewAnimated(view: self.hintAnimationView, animationDuration: 0.4) {
                    //                                                self.hintAnimationView.lottieAnimationView.play()
                    //                                                self.stepsButton.isHidden = false
                    //                                                self.userDefaults.set(false, forKey: "myKeyForStepsButton")
                    //                                            }
                    //                                        }
                    
                case let searchText where searchText!.containsFourthDocument():
                    showSearchView(text: searchText!) //{}
                    
                    
                default:
                    showViewAnimated(view: notFoundAnimationView, animationDuration: 0.4) {
                        self.notFoundAnimationView.lottieAnimationView.play()
                    }
                }
                


            default:
                    showViewAnimated(view: notFoundAnimationView, animationDuration: 0.4) {
                            self.notFoundAnimationView.lottieAnimationView.play()
                    }
            }
        }

        textField.text = ""
        
        // Return true to indicate that the text field should respond to the "Return" key
        return true
    }
    
    
    func setupAnyInfoView<T: PopUpable>(ofType type: T.Type, view tempView: inout T, withText text: String = String(), completion: (()->())? = nil) {
        tempView = type.init(frame: CGRect(x: (view.frame.size.width - 300) / 2, y: (view.frame.size.height - 380) / 2, width: 300, height: 380))
        tempView.viewLabel.text = text
        //tempView.nameOfLottieAnimation = animation
        completion?()
        view.addSubview(tempView)
        tempView.isHidden = true
        tempView.alpha = 0.0
    }
    
    func configureGradient(view: UIView, colorTop: UIColor, colorBottom: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [colorTop.cgColor, colorBottom.cgColor]
        gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.0) // top right corner
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 1.0) // bottom left corner
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func configureSearchView() {
        searchView.layer.cornerRadius = 14
        searchView.layer.masksToBounds = true
        searchView.layer.borderWidth = 1.5
        searchView.layer.borderColor = UIColor(named: "customGray")?.cgColor
    }
    
    func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.clear
        collectionView.register(UINib(nibName: "CustomCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        
        collectionView.collectionViewLayout = layout
    }
    
    
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrForSearch.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section:
                        Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath:
                        IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 70)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellLable = arrForSearch[indexPath.row]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CustomCollectionViewCell else { return UICollectionViewCell() }
        cell.documentLabel.text = cellLable
        cell.layer.cornerRadius = 14
        cell.layer.masksToBounds = true
        //        cell.frame = cell.frame.inset(by: UIEdgeInsets(top: 2, left: 0, bottom: 2, right: 0))
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? CustomCollectionViewCell else { return }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
        }
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.tapAnimation.optionsForStartAnimation(view: cell, color: Consts.Colors.tappedGray)
        })
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? CustomCollectionViewCell else { return }
        
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.tapAnimation.optionsForEndAnimation(view: cell)
        })
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        let cellLabel = arrForSearch[indexPath.row]
            if let viewControllerIdentifier = arrForNavigation[cellLabel],
               let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: viewControllerIdentifier) as? Documentable {
                viewController.tittleNavigationBar = cellLabel
                self.navigationController?.pushViewController(viewController, animated: true)
            }
    }
}





