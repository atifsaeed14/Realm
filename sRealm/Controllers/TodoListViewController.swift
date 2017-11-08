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

    @IBOutlet weak var tableView: UITableView!
    //var isExpend: Bool = false
    
    let realm = try! Realm()
    let results = try! Realm().objects(TodoItem.self).sorted(byKeyPath: "date")
    var notificationToken: NotificationToken?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.title = "Todo"
        tableView.tableFooterView = UIView()
        tableView.tableHeaderView = UIView()
        //self.automaticallyAdjustsScrollViewInsets = false
        //self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        tableView.keyboardDismissMode = .onDrag
        self.edgesForExtendedLayout = UIRectEdge()
        
//        self.edgesForExtendedLayout = UIRectEdge.None
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        navigationItem.rightBarButtonItems = [add]
        
        tableView.estimatedRowHeight = 65.0
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.register(UINib(nibName: "TaskTableCell", bundle: nil), forCellReuseIdentifier: "TaskTableCell")
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

    /*func showDetailTapped(sender: UIButton) {
        if (isExpend) {
            isExpend = false
        } else {
            isExpend = true
        }
        
        tableView.beginUpdates()
        let indexPath = IndexPath(item: sender.tag, section: 0)
        tableView.reloadRows(at: [indexPath], with: .automatic)
        tableView.endUpdates()
    }*/
    
}

// MARK:- UITableViewDataSource

extension TodoListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskTableCell", for: indexPath) as! TaskTableCell
        
        cell.taskLabel.text = "Title What you have to do is to save the index of the selected Cell in didSelectRow method. and also have to begin/end updates on table view. This will reload some part of tableview. and will call heightForRow method. In that method you can check that if your row is selected one then return expandedHeight, otherwise return the normal height ????"
        cell.taskLabel.numberOfLines = 0
        
        /*if (isExpend) {
            cell.taskLabel.numberOfLines = 0
        } else {
            cell.taskLabel.numberOfLines = 1
        }
        
        cell.detailButton.tag = indexPath.row
        
        cell.detailButton.addTarget(self, action: #selector(showDetailTapped(sender:)), for: .touchUpInside)*/
        
        return cell
}
    
}

