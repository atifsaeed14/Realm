//
//  TodoListViewController.swift
//  sRealm
//
//  Created by Atif Saeed on 07/11/2017.
//  Copyright © 2017 Atif Saeed. All rights reserved.
//

import UIKit
import RealmSwift

class TodoListViewController: UIViewController {

    let realm = try! Realm()
    let results = try! Realm().objects(TodoItem.self).sorted(byKeyPath: "date")
    var notificationToken: NotificationToken?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.title = "Todo"
        
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        
        navigationItem.rightBarButtonItems = [add]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Helping method
    
    func addTapped(_ sender: Any) {
        
        let alertController = TodoAddViewController(nibName: "TodoAddViewController", bundle: nil)
        
        alertController.modalTransitionStyle = .crossDissolve
        alertController.modalPresentationStyle = .overCurrentContext
        //present(alertController, animated: false, completion: nil)
        
        let animationType: AlertAnimationType = .scale
        
        if let viewController = alertController.getCurrentVC() {
            viewController.present(alertController, animated: false, completion: {
                alertController.startAnimated(type: animationType)
                //alertController.titleLabel.text = title
                //alertController.messageLabel.text = message
            })
        }
        
    }


}
