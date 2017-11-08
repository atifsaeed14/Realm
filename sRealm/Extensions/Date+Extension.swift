//
//  Date+Extension.swift
//  ASSwift
//
//  Created by Atif Saeed on 2/10/17.
//  Copyright © 2017 AtifSaeed. All rights reserved.
//

import Foundation

// let today = Date()
// today.toString(dateFormat: "dd-MM")

extension Date {
 
    func toString(dateFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: self)
    }
    
}
