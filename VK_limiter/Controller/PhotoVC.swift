//
//  PhotoVC.swift
//  VK_limiter
//
//  Created by Aleksei Kanatev on 10.05.2020.
//  Copyright © 2020 Aleksei Kanatev. All rights reserved.
//

import UIKit

class PhotoVC: UIViewController {
    var viewForPicture: UIView!
    var imageView: UIImageView!
    var photoArray: [UIImage]!
    var imageView2: UIImageView!
    
    var swipeTopToBottom: UISwipeGestureRecognizer? = nil
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .all
    }
     
    override func viewWillLayoutSubviews() {
        
        let newSize = getSizeForImageWithOrientation(orientation: UIDevice.current.orientation, heightOfView: super.view.frame.height, widthOfView: super.view.frame.width, width: self.imageView.image!.size.width, height: self.imageView.image!.size.height)
        
        self.imageView.frame.size = newSize
            self.imageView.frame.origin.x = (self.view.bounds.width/2-(newSize.width/2))
            self.imageView.frame.origin.y = (self.view.bounds.height/2-(newSize.height/2))
        
        self.viewForPicture.frame = self.view.frame
    }
    
    func findImagePosition(currentImage: UIImage, arrayOfImages: [UIImage]) -> Int {
        var imagePosition: Int!
        
        for i in arrayOfImages.indices {
            let tempImage = arrayOfImages[i]
            if tempImage == currentImage {
                imagePosition = i
            }
        }
        return imagePosition
    }
    
    
    @objc func exitDownGesture(){
        let transition = CATransition()
        transition.duration = 0.3
        transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        transition.type = CATransitionType.reveal
        transition.subtype = CATransitionSubtype.fromBottom
        self.view.window!.layer.add(transition, forKey: nil)
        self.dismiss(animated: false, completion: nil)
    }
    
    @objc func exitUpGesture(){
        let transition = CATransition()
        transition.duration = 0.3
        transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        transition.type = CATransitionType.reveal
        transition.subtype = CATransitionSubtype.fromTop
        self.view.window!.layer.add(transition, forKey: nil)
        self.dismiss(animated: false, completion: nil)
    }
    
    // функция свайпа фото вперед
    @objc func nextPhotoGesture(){
        
        UIView.animateKeyframes(withDuration: 0.3, delay: 0, options: [.calculationModeCubicPaced], animations: {
            UIView.addKeyframe(withRelativeStartTime: 1, relativeDuration: 1) {
                self.imageView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            }
            
        }, completion:  {_ in
            
            self.imageView.transform = CGAffineTransform(scaleX: 1, y: 1)
            
            let newPosition: Int? = self.findImagePosition(currentImage: self.imageView.image!, arrayOfImages: self.photoArray)+1
            if newPosition! < self.photoArray.count {
                self.imageView.image = self.photoArray[newPosition!]
                
                let newSize = self.getSizeForImageWithOrientation(orientation: UIDevice.current.orientation, heightOfView: super.view.frame.height, widthOfView: super.view.frame.width, width: self.imageView.image!.size.width, height: self.imageView.image!.size.height)
                
                self.imageView.frame.size = newSize

                    self.imageView.frame.origin.x = (self.view.bounds.width/2-(newSize.width/2))
                    self.imageView.frame.origin.y = (self.view.bounds.height/2-(newSize.height/2))
                
            } else {
                self.imageView.image = self.photoArray[0]
                
                let newSize = self.getSizeForImageWithOrientation(orientation: UIDevice.current.orientation, heightOfView: super.view.frame.height, widthOfView: super.view.frame.width, width: self.imageView.image!.size.width, height: self.imageView.image!.size.height)
                
                self.imageView.frame.size = newSize

                    self.imageView.frame.origin.x = (self.view.bounds.width/2-(newSize.width/2))
                    self.imageView.frame.origin.y = (self.view.bounds.height/2-(newSize.height/2))
                
            }
            
            let transition = CATransition()
            transition.duration = 0.5
            transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            transition.type = CATransitionType.push
            transition.subtype = CATransitionSubtype.fromRight
            self.view.window!.layer.add(transition, forKey: nil)
            
        })
    }
    
    // функция свайпа фото назад
    @objc func previousPhotoGesture(){
        
        let newPosition: Int? = self.findImagePosition(currentImage: self.imageView.image!, arrayOfImages: self.photoArray)-1
        if newPosition! >= 0 {
            self.imageView.image = self.photoArray[newPosition!]

            let newSize = self.getSizeForImageWithOrientation(orientation: UIDevice.current.orientation, heightOfView: super.view.frame.height, widthOfView: super.view.frame.width, width: self.imageView.image!.size.width, height: self.imageView.image!.size.height)
            
            self.imageView.frame.size = newSize

                self.imageView.frame.origin.x = (self.view.bounds.width/2-(newSize.width/2))
                self.imageView.frame.origin.y = (self.view.bounds.height/2-(newSize.height/2))
            
            
        } else {
            self.imageView.image = self.photoArray.last
            
            let newSize = self.getSizeForImageWithOrientation(orientation: UIDevice.current.orientation, heightOfView: super.view.frame.height, widthOfView: super.view.frame.width, width: self.imageView.image!.size.width, height: self.imageView.image!.size.height)
            
            self.imageView.frame.size = newSize

                self.imageView.frame.origin.x = (self.view.bounds.width/2-(newSize.width/2))
                self.imageView.frame.origin.y = (self.view.bounds.height/2-(newSize.height/2))
            
        }
        
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        self.view.window!.layer.add(transition, forKey: nil)
        self.imageView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        
        UIView.animateKeyframes(withDuration: 0.5, delay: 0.5, options: [.calculationModeCubicPaced], animations: {
            UIView.addKeyframe(withRelativeStartTime: 1, relativeDuration: 1) {
                self.imageView.transform = CGAffineTransform(scaleX: 1, y: 1)
            }
        }, completion: nil)
    }
    
    @objc func orientationChanged(notification : NSNotification) {
        print("orientation changed")
        if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft {
            print("landscapeLeft")

        } else if UIDevice.current.orientation.isPortrait {
            print("portrait")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        UIDevice.current.beginGeneratingDeviceOrientationNotifications()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(orientationChanged(notification:)),
            name: UIDevice.orientationDidChangeNotification,
            object: nil)
        
        self.viewForPicture = UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height))
        self.view.addSubview(viewForPicture)
        self.viewForPicture.addSubview(self.imageView)
        
        self.swipeTopToBottom = UISwipeGestureRecognizer(target: self, action: #selector(exitDownGesture))
        self.swipeTopToBottom!.direction = .down
        self.viewForPicture.addGestureRecognizer(swipeTopToBottom!)
        
        let swipeBottomToTop = UISwipeGestureRecognizer(target: self, action: #selector(exitUpGesture))
        swipeBottomToTop.direction = .up
        self.viewForPicture.addGestureRecognizer(swipeBottomToTop)
        
        let swipeToNext = UISwipeGestureRecognizer(target: self, action: #selector(nextPhotoGesture))
        swipeToNext.direction = .left
        self.viewForPicture.addGestureRecognizer(swipeToNext)
        
        let swipeToPrevious = UISwipeGestureRecognizer(target: self, action: #selector(previousPhotoGesture))
        swipeToPrevious.direction = .right
        self.viewForPicture.addGestureRecognizer(swipeToPrevious)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        UIDevice.current.endGeneratingDeviceOrientationNotifications()
    }
    
    
    func getSizeForImage(heightOfView: CGFloat, widthOfView: CGFloat, width: CGFloat, height: CGFloat) -> CGSize {
        let multiplierForHeight = height / width
        var newWidth: CGFloat
        var newHeight: CGFloat
        var newSize: CGSize = CGSize(width: 100, height: 100)
        
        if heightOfView > widthOfView {
            newWidth = widthOfView
            newHeight = multiplierForHeight * widthOfView
            newSize = CGSize(width: newWidth, height: newHeight)
        } else {
            newWidth = widthOfView
            newHeight = heightOfView
            newSize = CGSize(width: newWidth, height: newHeight)
        }
        return newSize
    }
    
    func getSizeForImageWithOrientation(orientation: UIDeviceOrientation, heightOfView: CGFloat, widthOfView: CGFloat, width: CGFloat, height: CGFloat) -> CGSize {
        
        var newSize: CGSize!
        
        let multiplierForHeight = height / width
        let multiplierForWidth = width / height
        var newWidth: CGFloat
        var newHeight: CGFloat
        
        if orientation == .landscapeRight || orientation == .landscapeLeft {
            newWidth = multiplierForWidth * heightOfView
            newHeight = heightOfView
            newSize = CGSize(width: newWidth, height: newHeight)
            
        } else {
            newWidth = widthOfView
            newHeight = multiplierForHeight * widthOfView
            newSize = CGSize(width: newWidth, height: newHeight)
        }
        return newSize
    }
    
}

// proverka
