//
//  TodoItem.swift
//  sRealm
//
//  Created by Atif Saeed on 07/11/2017.
//  Copyright © 2017 Atif Saeed. All rights reserved.
//

import UIKit
import RealmSwift

class TodoItem: Object {
    
    dynamic var task: String? = nil
    dynamic var date: Date = Date()
    dynamic var priority: Int = 1
    dynamic var isCompleted: Bool = false
    dynamic var isExpend: Bool = false
    
    func save() {
       do {
            let realm = try Realm()
            try realm.write {
                realm.add(self)
            }
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }
    
    func update(task: String, priority: Int) {
        do {
            let realm = try Realm()
            try realm.write {
                self.task = task
                self.priority = priority
            }
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }
    
    func update(value: Bool) {
        do {
            let realm = try Realm()
            try realm.write {
                self.isExpend = value
            }
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }
    
    func delete() {
        do {
            let realm = try Realm()
            try realm.write {
                realm.delete(self)
            }
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }
    
}
