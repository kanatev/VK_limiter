//
//  NewsCell.swift
//  VK_limiter
//
//  Created by Aleksei Kanatev on 02.05.2020.
//  Copyright © 2020 Aleksei Kanatev. All rights reserved.
//

import UIKit

protocol NewsCellDelegate: class {
    func heartTapped(at indexPath: IndexPath)
}

class NewsCell: UITableViewCell {

    @IBOutlet weak var heartImageView: UIImageView!
    @IBOutlet weak var heartCounterLabel: UILabel!
    @IBOutlet weak var nameForNews: UILabel!
    @IBOutlet weak var textOfNews: UILabel!
    @IBOutlet weak var imageForNews: UIImageView!
    @IBOutlet weak var heightConstrPictureForNews: NSLayoutConstraint!
    @IBOutlet weak var widthConstrPictureForNews: NSLayoutConstraint!
    @IBOutlet weak var likeControlOutlet: UIView!
    
    
    public var heartFilled = false {
        didSet {
            if !heartFilled {
                heartImageView.image = UIImage(systemName: "heart")
                heartCounterLabel.text = "0"
            } else {
                heartImageView.image = UIImage(systemName: "heart.fill")
                heartCounterLabel.text = "1"
            }
        }
    }
    
    public weak var delegate: NewsCellDelegate?
    public var heartPressed = {}
    public var cellIndexPath = IndexPath(item: 0, section: 0)
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        heartImageView.image = UIImage(systemName: "heart")
        heartCounterLabel.text = "0"
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(heartTapped))
        likeControlOutlet.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc private func heartTapped(){
        heartFilled.toggle()
        heartPressed()
        likeListingAnimation()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        heartImageView.image = UIImage(systemName: "heart")
        heartCounterLabel.text = "0"
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func likeListingAnimation(){
        UIView.transition(with: self.likeControlOutlet, duration: 0.5, options: .transitionFlipFromBottom, animations: {}, completion: nil)
    }
    
}
