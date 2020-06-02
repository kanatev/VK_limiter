//
//  FriendsTableViewCell.swift
//  VK_limiter
//
//  Created by Aleksei Kanatev on 13/07/2019.
//  Copyright © 2019 Aleksei Kanatev. All rights reserved.
//

import UIKit

class FriendsTableViewCell: UITableViewCell {
    
    @IBOutlet var firstImageView: UIImageView!
    @IBOutlet var friendNameLabel: UILabel!
    @IBOutlet weak var shadowView: ShadowView3!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(animation))
        shadowView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    @objc func animation(){
        
//        реализация через CASpring
//        let animationForAva = CASpringAnimation(keyPath: #keyPath(UIBezierPath.bounds))
//        animationForAva.toValue = CGRect(x: -5, y: -5, width: 80, height: 80)
//        self.shadowView.layer.add(animationForAva, forKey: nil)
//
//        let animBorder = CASpringAnimation(keyPath: #keyPath(CALayer.bounds))
//        animBorder.toValue = CGRect(x: 0, y: 0, width: 40, height: 40)
//        animBorder.duration = 0.5
//        animBorder.autoreverses = true
//        self.shadowView.borderView.layer.add(animBorder, forKey: nil)
//
//        let animBorderCorner = CASpringAnimation(keyPath: #keyPath(CALayer.cornerRadius))
//        animBorderCorner.toValue = 20
//        animBorderCorner.duration = 0.5
//        animBorderCorner.autoreverses = true
//        self.shadowView.borderView.layer.add(animBorderCorner, forKey: nil)

        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.1, initialSpringVelocity: 5, options: .curveEaseInOut, animations: {() -> Void in
            self.shadowView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            self.shadowView.transform = CGAffineTransform(scaleX: 1, y: 1)

        }, completion: nil)
    }
}


