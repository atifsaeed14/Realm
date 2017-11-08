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
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    var sortKey: String = "date"

    let realm = try! Realm()
    var results = try! Realm().objects(TodoItem.self)
    var notificationToken: NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.title = "Todo"
        self.edgesForExtendedLayout = UIRectEdge()
        results = try! Realm().objects(TodoItem.self).sorted(byKeyPath: sortKey)

        //add()
        setupUI()
        
        // Set results notification block
        self.notificationToken = results.observe { (changes: RealmCollectionChange) in
            switch changes {
            case .initial:
                // Results are now populated and can be accessed without blocking the UI
                self.tableView.reloadData()
                
            case .update(_, let deletions, let insertions, let modifications):
                // Query results have changed, so apply them to the TableView
                /*self.tableView.beginUpdates()
                self.tableView.insertRows(at: insertions.map { IndexPath(row: $0, section: 0) }, with: .automatic)
                self.tableView.deleteRows(at: deletions.map { IndexPath(row: $0, section: 0) }, with: .automatic)
                self.tableView.reloadRows(at: modifications.map { IndexPath(row: $0, section: 0) }, with: .automatic)
                self.tableView.endUpdates()*/
                self.tableView.reloadData()
                
            case .error(let err):
                // An error occurred while opening the Realm file on the background worker thread
                fatalError("\(err)")
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Helping method
    
    @IBAction func didSelectSortCriteria(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            sortKey = "date"
        } else if sender.selectedSegmentIndex == 1 {
            sortKey = "task"
        } else {
            sortKey = "priority"
            // A-Z
            //self.lists = self.lists.sorted(byProperty: "name")
            // date
            //self.lists = self.lists.sorted(byProperty: "createdAt", ascending:false)
        }
        
        if (searchBar.text?.isEmpty)! {
            results = try! Realm().objects(TodoItem.self).sorted(byKeyPath: sortKey)
        } else {
            let predicate = NSPredicate(format: "task contains %@", searchBar.text!)
            results = try! Realm().objects(TodoItem.self).filter(predicate).sorted(byKeyPath: sortKey)
        }
        self.tableView.reloadData()
    }
    
    func setupUI() {
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        navigationItem.rightBarButtonItems = [add]
        
        tableView.estimatedRowHeight = 65.0
        tableView.tableFooterView = UIView()
        tableView.tableHeaderView = UIView()
        tableView.keyboardDismissMode = .onDrag
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.register(UINib(nibName: "TaskTableCell", bundle: nil), forCellReuseIdentifier: "TaskTableCell")
    }
    
    func addTapped(sender: Any) {
        let alertController = TodoAddViewController(nibName: "TodoAddViewController", bundle: nil)
        
        alertController.modalTransitionStyle = .crossDissolve
        alertController.modalPresentationStyle = .overCurrentContext
        //present(alertController, animated: false, completion: nil)
        
        let animationType: AlertAnimationType = .scale
        
        if let viewController = alertController.getCurrentVC() {
            viewController.present(alertController, animated: false, completion: {
                alertController.startAnimated(type: animationType)
            })
        }
    }
    
    func editTapped(sender: UIButton) {
        let object:TodoItem = results[sender.tag]
        let alertController = TodoAddViewController(nibName: "TodoAddViewController", bundle: nil)
        
        alertController.modalTransitionStyle = .crossDissolve
        alertController.modalPresentationStyle = .overCurrentContext
        
        let animationType: AlertAnimationType = .scale
        
        if let viewController = alertController.getCurrentVC() {
            viewController.present(alertController, animated: false, completion: {
                alertController.startAnimated(type: animationType)
                alertController.todoItem = object
            })
        }
    }
    
    func deleteTapped(sender: UIButton) {
        let object:TodoItem = results[sender.tag]
        object.delete()
    }
    
    func detailTapped(sender: UIButton) {
        let object: TodoItem = results[sender.tag]
        if (object.isExpend) {
            object.update(value: false)
        } else {
            object.update(value: true)
        }
    }
    
    // Random add for testing purpose
    
    /*func add() {
        realm.beginWrite()
        //realm.create(TodoItem.self, value: [TodoListViewController.randomString(), TodoListViewController.randomDate()])
        realm.create(TodoItem.self, value: ["task": TodoListViewController.randomString(), "date": TodoListViewController.randomDate()])
        try! realm.commitWrite()
    }
    
    class func randomString() -> String {
        return "Title \(arc4random())"
    }
    
    class func randomDate() -> NSDate {
        return NSDate(timeIntervalSince1970: TimeInterval(arc4random()))
    }*/
    
}

// MARK:- UITableViewDataSource

extension TodoListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskTableCell", for: indexPath) as! TaskTableCell
        
        let object = results[indexPath.row]
        cell.taskLabel.text = object.task
        cell.dateLabel.text = object.date.toString(dateFormat: "dd MMM HH:mm")
        
        if (object.isExpend) {
            cell.taskLabel.numberOfLines = 0
            cell.detailButton .setTitle("Hide", for: .normal)
        } else {
            cell.taskLabel.numberOfLines = 1
            cell.detailButton .setTitle("Detail", for: .normal)
        }
        
        cell.detailButton.tag = indexPath.row
        cell.detailButton.addTarget(self, action: #selector(detailTapped(sender:)), for: .touchUpInside)
        
        cell.deleteButton.tag = indexPath.row
        cell.deleteButton.addTarget(self, action: #selector(deleteTapped(sender:)), for: .touchUpInside)
        
        cell.editButton.tag = indexPath.row
        cell.editButton.addTarget(self, action: #selector(editTapped(sender:)), for: .touchUpInside)
        
        return cell
    }
    
}

// MARK:- UISearchBarDelegate

extension TodoListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let predicate = NSPredicate(format: "task contains %@", searchText)
        if searchText.isEmpty {
            results = try! Realm().objects(TodoItem.self).sorted(byKeyPath: sortKey)
        } else {
            results = try! Realm().objects(TodoItem.self).filter(predicate).sorted(byKeyPath: sortKey)
        }
        tableView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        /*if !(searchBar.text?.isEmpty)! {
         UIApplication.shared.isNetworkActivityIndicatorVisible = true
         }*/
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
        results = try! Realm().objects(TodoItem.self).sorted(byKeyPath: sortKey)
        tableView.reloadData()
    }
}
