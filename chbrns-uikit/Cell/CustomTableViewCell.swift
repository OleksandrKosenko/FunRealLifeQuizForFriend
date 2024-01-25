//
//  CustomTableViewCell.swift
//  chbrns-uikit
//
//  Created by Alex Kosenko on 20.04.2023.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var documentLabel: UILabel!
    
//    var originalBackgroundColor: UIColor?
//    let view = UIView()
//    let background = UIView()
//    let titleLabel = UILabel()
//    let layerColor = CALayer()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
//
        contentView.layer.cornerRadius = 14
        contentView.layer.masksToBounds = true
//        contentView.addSubview(view)
//        view.addSubview(background)
//        view.layer.addSublayer(layerColor)
//
//        view.translatesAutoresizingMaskIntoConstraints = false
//        background.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
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
//
//        if isSelected {
//            UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
//                TapAnimation().optionsForStartAnimation(view: self.view, color: Consts.Colors.tappedGray)
//            })
//        } else {
//            UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
//                TapAnimation().optionsForEndAnimation(view: self.view)
//            })
//        }
//    }
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
