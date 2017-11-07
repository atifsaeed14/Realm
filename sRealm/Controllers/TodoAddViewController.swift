//
//  TodoAddViewController.swift
//  sRealm
//
//  Created by Atif Saeed on 07/11/2017.
//  Copyright © 2017 Atif Saeed. All rights reserved.
//

import UIKit

typealias ActionHandler = () -> Void

enum AlertAnimationType {
    case scale
    case rotate
    case bounceUp
    case bounceDown
}

class TodoAddViewController: UIViewController {

    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var textView: UITextView!

    let backgroundColor: UIColor = .black
    let backgroundOpacity: CGFloat = 0.5
    let animateDuration: TimeInterval = 1.0
    
    let scaleX: CGFloat = 0.9
    let scaleY: CGFloat = 0.9
    let rotateRadian:CGFloat = 1.5 // 1 rad = 57 degrees
    
    private var okHandler: ActionHandler?
    private var cancelHandler: ActionHandler?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        alertView.alpha = 0
        alertView.layer.cornerRadius = 4
        view.backgroundColor = backgroundColor.withAlphaComponent(backgroundOpacity)
        okButton.addTarget(self, action: #selector(okTapped), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK:- Helping methods
    
    func startAnimated(type: AlertAnimationType){
        
        alertView.alpha = 1
        switch type {
        case .rotate:
            alertView.transform = CGAffineTransform(rotationAngle: rotateRadian)
        case .bounceUp:
            let screenHeight = UIScreen.main.bounds.height/2 + alertView.frame.height/2
            alertView.transform = CGAffineTransform(translationX: 0, y: screenHeight)
        case .bounceDown:
            let screenHeight = -(UIScreen.main.bounds.height/2 + alertView.frame.height/2)
            alertView.transform = CGAffineTransform(translationX: 0, y: screenHeight)
        default:
            alertView.transform = CGAffineTransform(scaleX: scaleX, y: scaleY)
        }
        
        UIView.animate(withDuration: animateDuration, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .allowUserInteraction, animations: {
            self.alertView.transform = .identity
        }, completion: { (Bool) in
            self.textView.becomeFirstResponder()
        })
        
    }
    
    func closeTapped() {
        dismiss(animated: true, completion: {
           // if let posHandler = self.posHandler{
           //     posHandler()
           // }
        })
    }
    
    func okTapped() {
        
        if textView.text.characters.count == 0 {
            let alertView = UIAlertController(title:"Error", message: "Note cannot canot be empty.", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: { (alert) in
                
            })
            alertView.addAction(action)
            self.present(alertView, animated: true, completion: nil)
            
        } else {
            
            dismiss(animated: true, completion: {
                // if let posHandler = self.posHandler{
                //     posHandler()
                // }
            })
        }
        
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if textView.text.characters.count <= 140 {
            // Code here
        } else {
            //Code Here
        }
        return true
    }
    
}