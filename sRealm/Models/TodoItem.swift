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
    dynamic var isCompleted: Bool = false

    //dynamic var createdAt: Date = Date()
    //dynamic var count: Int = Int(0)
    //dynamic var title: String? = nil
    
    /*func save() {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(self)
            }
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }*/
}
