//
//  ViewController.swift
//  VK_limiter
//
//  Created by Aleksei Kanatev on 30/06/2019.
//  Copyright © 2019 Aleksei Kanatev. All rights reserved.
//


import UIKit

class FirstVC: UIViewController, UIAlertViewDelegate {
    
    override open var shouldAutorotate: Bool {
        return false
    }
    
    private let animator = Animator()
    
    var animationPerformed: Bool?
    var grayView: UIView?
    var dotsView: UIView?
    
    // white status bar
    var barStyle = UIStatusBarStyle.lightContent
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return barStyle
    }
    
    @IBOutlet var loginTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var enterButtonOutlet: UIButton!
    
    func clearTextFields() {
        loginTextField.text = nil
        passwordTextField.text = nil
    }
    
    @IBAction func enterButton(_ sender: Any) {
        animation4()
//        let navigationController = UINavigationController()
//        let controller1 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier:"controller1")
//        navigationController.setViewControllers([controller1], animated: false)
//        navigationController.transitioningDelegate = self
//        present(navigationController, animated: true)
    }
    
    func showArert() {
        let alert: UIAlertController = UIAlertController(title: "Ошибка", message: "Неправильный логин или пароль", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        clearTextFields()
    }
    
    private func animation() {
        
        if animationPerformed == false {
            
            self.grayView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height))
            self.grayView!.backgroundColor = .lightGray
            self.view.addSubview(self.grayView!)
            
            let dotsView = UIView(frame: CGRect(x: grayView!.bounds.width/2-50, y: self.grayView!.bounds.height/2-15, width: 100, height: 30))
            dotsView.backgroundColor = .gray
            dotsView.layer.cornerRadius = 15
            grayView!.addSubview(dotsView)
            
            let firstDot = UIView(frame: CGRect(x: 10, y: dotsView.bounds.height/2-5, width: 10, height: 10))
            firstDot.backgroundColor = .black
            firstDot.layer.cornerRadius = firstDot.frame.height/2
            dotsView.addSubview(firstDot)
            
            let secondDot = UIView(frame: CGRect(x: dotsView.bounds.width/2-5, y: dotsView.bounds.height/2-5, width: 10, height: 10))
            secondDot.backgroundColor = .black
            secondDot.layer.cornerRadius = firstDot.frame.height/2
            dotsView.addSubview(secondDot)
            
            let thirdDot = UIView(frame: CGRect(x: 80, y: dotsView.bounds.height/2-5, width: 10, height: 10))
            thirdDot.backgroundColor = .black
            thirdDot.layer.cornerRadius = firstDot.frame.height/2
            dotsView.addSubview(thirdDot)
            
            
            var counter = 1
            func repeatAnimation(){
                UIView.animate(withDuration: 0.7, delay: 0, options: .curveEaseInOut, animations: {
                    firstDot.backgroundColor = .white
                    
                }, completion: {_ in
                    firstDot.backgroundColor = .black
                    UIView.animate(withDuration: 0.7, delay: 0, options: .curveEaseInOut, animations: {
                        secondDot.backgroundColor = .white
                    }, completion: {_ in
                        secondDot.backgroundColor = .black
                        UIView.animate(withDuration: 0.7, delay: 0, options: .curveEaseInOut, animations: {
                            thirdDot.backgroundColor = .white
                        }, completion: {_ in
                            thirdDot.backgroundColor = .black
                            counter += 1
                            if counter < 2{
                                repeatAnimation()
                            } else {
                                self.animationPerformed = true
                                self.performSegue(withIdentifier: "enterSegue", sender: self)
                            }
                        })
                    })
                })
            }
            repeatAnimation()
        }
    }
    
    
    private func animation2() {
        
        if animationPerformed == false {
            
            self.grayView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height))
            self.grayView!.backgroundColor = .lightGray
            self.view.addSubview(self.grayView!)
            
            let dotsView = UIView(frame: CGRect(x: grayView!.bounds.width/2-50, y: self.grayView!.bounds.height/2-15, width: 100, height: 30))
            dotsView.backgroundColor = .gray
            dotsView.layer.cornerRadius = 15
            dotsView.layer.masksToBounds = true
            grayView!.addSubview(dotsView)
            
            var counter1 = 1
            var counter2 = 1
            var counter3 = 1
            var counter4 = 1
            var counter5 = 1
            
            
            let durationOfAnim: Double = 2
            
            
            func firstDotAnimation(){
                
                let firstDot = UIView(frame: CGRect(x: -20, y: dotsView.bounds.height/2-5, width: 10, height: 10))
                firstDot.backgroundColor = .none
                firstDot.layer.cornerRadius = firstDot.frame.height/2
                dotsView.addSubview(firstDot)
                
                UIView.animate(withDuration: durationOfAnim, delay: 0, options: .curveLinear, animations: {
                    firstDot.backgroundColor = .blue
                    firstDot.transform = CGAffineTransform(translationX: dotsView.bounds.maxX+30, y: dotsView.bounds.maxY-30)
                }, completion: {_ in
                    firstDot.removeFromSuperview()
                    counter1 += 1
                    if counter1 < 50{
                        firstDotAnimation()
                    } else {
                        self.animationPerformed = true
                    }
                })
            }
            
            func secondDotAnimation(){
                
                let secondDot = UIView(frame: CGRect(x: -20, y: dotsView.bounds.height/2-5, width: 10, height: 10))
                secondDot.backgroundColor = .none
                secondDot.layer.cornerRadius = secondDot.frame.height/2
                dotsView.addSubview(secondDot)
                
                var delay: Double
                if counter2 == 1{
                    delay = 0.5
                } else {
                    delay = 0
                }
                
                UIView.animate(withDuration: durationOfAnim, delay: delay, options: .curveLinear, animations: {
                    secondDot.backgroundColor = .none
                    secondDot.transform = CGAffineTransform(translationX: dotsView.bounds.maxX+30, y: dotsView.bounds.maxY-30)
                    secondDot.backgroundColor = .orange
                    
                }, completion: {_ in
                    secondDot.removeFromSuperview()
                    counter2 += 1
                    if counter2 < 50{
                        secondDotAnimation()
                    } else {
                        self.animationPerformed = true
                    }
                })
            }
            
            func thirdDotAnimation(){
                
                let thirdDot = UIView(frame: CGRect(x: -20, y: dotsView.bounds.height/2-5, width: 10, height: 10))
                thirdDot.backgroundColor = .none
                thirdDot.layer.cornerRadius = thirdDot.frame.height/2
                dotsView.addSubview(thirdDot)
                
                var delay: Double
                if counter3 == 1{
                    delay = 1
                } else {
                    delay = 0
                }
                
                UIView.animate(withDuration: durationOfAnim, delay: delay, options: .curveLinear, animations: {
                    thirdDot.backgroundColor = .none
                    thirdDot.transform = CGAffineTransform(translationX: dotsView.bounds.maxX+30, y: dotsView.bounds.maxY-30)
                    thirdDot.backgroundColor = .cyan
                    
                }, completion: {_ in
                    thirdDot.removeFromSuperview()
                    counter3 += 1
                    if counter3 < 50{
                        thirdDotAnimation()
                    } else {
                        self.animationPerformed = true
                    }
                })
            }
            
            func fourthDotAnimation(){
                
                let fourthDot = UIView(frame: CGRect(x: -20, y: dotsView.bounds.height/2-5, width: 10, height: 10))
                fourthDot.backgroundColor = .none
                fourthDot.layer.cornerRadius = fourthDot.frame.height/2
                dotsView.addSubview(fourthDot)
                
                var delay: Double
                if counter4 == 1{
                    delay = 1.5
                } else {
                    delay = 0
                }
                
                UIView.animate(withDuration: durationOfAnim, delay: delay, options: .curveLinear, animations: {
                    fourthDot.transform = CGAffineTransform(translationX: dotsView.bounds.maxX+30, y: dotsView.bounds.maxY-30)
                    fourthDot.backgroundColor = .green
                    
                }, completion: {_ in
                    fourthDot.removeFromSuperview()
                    counter4 += 1
                    if counter4 < 50{
                        fourthDotAnimation()
                    } else {
                        self.animationPerformed = true
                    }
                })
            }
            
            func fifthDotAnimation(){
                
                let fifthDot = UIView(frame: CGRect(x: -20, y: dotsView.bounds.height/2-5, width: 10, height: 10))
                fifthDot.backgroundColor = .none
                fifthDot.layer.cornerRadius = fifthDot.frame.height/2
                dotsView.addSubview(fifthDot)
                
                var delay: Double
                if counter5 == 1{
                    delay = 2
                } else {
                    delay = 0
                }
                
                UIView.animate(withDuration: durationOfAnim, delay: delay, options: .curveLinear, animations: {
                    fifthDot.transform = CGAffineTransform(translationX: dotsView.bounds.maxX+30, y: dotsView.bounds.maxY-30)
                    fifthDot.backgroundColor = .magenta
                }, completion: {_ in
                    fifthDot.removeFromSuperview()
                    counter5 += 1
                    if counter5 < 50{
                        fifthDotAnimation()
                    } else {
                        self.animationPerformed = true
                    }
                })
            }
            
            firstDotAnimation()
            secondDotAnimation()
            thirdDotAnimation()
            fourthDotAnimation()
            fifthDotAnimation()
        }
    }
    
    func animation3(){
        
        self.grayView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height))
        self.grayView!.backgroundColor = .lightGray
        //            self.grayView!.alpha = 0.9
        self.view.addSubview(self.grayView!)
        
        let dotsView = UIView(frame: CGRect(x: grayView!.bounds.width/2-50, y: self.grayView!.bounds.height/2-15, width: 100, height: 30))
        dotsView.backgroundColor = .gray
        dotsView.layer.cornerRadius = 15
        dotsView.layer.masksToBounds = true
        grayView!.addSubview(dotsView)
        
        let firstDot = UIView(frame: CGRect(x: 10, y: dotsView.bounds.height/2, width: 10, height: 10))
        firstDot.backgroundColor = .white
        firstDot.layer.cornerRadius = firstDot.frame.height/2
        dotsView.addSubview(firstDot)
        
        let transform1 = CGAffineTransform(translationX: dotsView.bounds.width/2-10, y: -10)
        let transform2 = transform1.concatenating(CGAffineTransform(translationX: 30, y: 10))
        
        UIView.animateKeyframes(withDuration: 1, delay: 0, options: [.repeat, .calculationModeCubicPaced, .autoreverse], animations: {
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1) {
                firstDot.backgroundColor = .green
                firstDot.transform = transform1
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 1) {
                firstDot.transform = transform2
            }
        }, completion: nil)
    }
    
    
    var timeOfStart: Timer?
    
    @objc func stopAnimation(){
        timeOfStart?.invalidate()
        self.animationPerformed = true
        self.performSegue(withIdentifier: "enterSegue", sender: self)
    }
    
    func animation4(){
        
        timeOfStart = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(stopAnimation), userInfo: nil, repeats: false)
        
        self.grayView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height))
        self.grayView!.backgroundColor = .lightGray
//        self.grayView!.layer.backgroundColor = UIColor.black.cgColor
        self.grayView!.layer.opacity = 0.5
    
        //            self.grayView!.alpha = 0.9
        self.view.addSubview(self.grayView!)
        
        self.dotsView = UIView(frame: CGRect(x: grayView!.bounds.width/2-50, y: self.grayView!.bounds.height/2-15, width: 100, height: 30))
        self.dotsView!.backgroundColor = .gray
        self.dotsView!.layer.cornerRadius = 15
        self.dotsView!.layer.masksToBounds = true
        self.view.addSubview(self.dotsView!)
        
        let firstDot = UIView(frame: CGRect(x: 25, y: self.dotsView!.bounds.height/2-5, width: 10, height: 10))
        firstDot.backgroundColor = .green
        firstDot.layer.cornerRadius = firstDot.frame.height/2
        self.dotsView!.addSubview(firstDot)
        
        let secondDot = UIView(frame: CGRect(x: 10, y: self.dotsView!.bounds.height/2-5, width: 10, height: 10))
        secondDot.backgroundColor = .yellow
        secondDot.layer.cornerRadius = secondDot.frame.height/2
        self.dotsView!.addSubview(secondDot)
        
        let transform1 = CGAffineTransform(translationX: 60, y: 0)
        let transform2 = transform1.concatenating(CGAffineTransform(translationX: 0, y: 0))
        
         
        UIView.animateKeyframes(withDuration: 1, delay: 0, options: [.repeat, .calculationModeCubicPaced, .autoreverse], animations: {
            UIView.addKeyframe(withRelativeStartTime: 1, relativeDuration: 1) {
                firstDot.transform = transform1
            }
        }, completion: nil)
        
        
        UIView.animateKeyframes(withDuration: 1, delay: 0.04, options: [.repeat, .calculationModeCubicPaced, .autoreverse], animations: {
            UIView.addKeyframe(withRelativeStartTime: 1, relativeDuration: 1) {
                secondDot.transform = transform2
            }
        }, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animationPerformed = false
        loginTextField.placeholder = "Email или телефон"
        passwordTextField.placeholder = "Пароль"
        enterButtonOutlet.layer.cornerRadius = 5
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if self.grayView != nil {
            self.grayView!.removeFromSuperview()
            self.animationPerformed = false
        }
        if self.dotsView != nil {
            self.dotsView!.removeFromSuperview()
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if animationPerformed == true{
            return true
        } else {
            return false
        }
        //        if loginTextField.text == "admin" && passwordTextField.text == "123456" {
        //            clearTextFields()
        //            return true
        //        } else {
        //            showArert()
        //            return false
        //        }
        //    }
    }
    
    
    
}

extension FirstVC: UIViewControllerTransitioningDelegate {
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return animator
    }
    
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return animator
    }
}
