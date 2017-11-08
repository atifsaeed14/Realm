//
//  String+Extension.swift
//  ASSwift
//
//  Created by Atif Saeed on 2/10/17.
//  Copyright © 2017 AtifSaeed. All rights reserved.
//

import Foundation

//if let releaseDate = result["releaseDate"] as? String {
//    releaseDate = releaseDate.convertToReadableDate()
//}

extension String {
 
    func convertToReadableDate() -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone!
        let date = dateFormatter.date(from: self)
        
        dateFormatter.dateFormat = "d MMMM yyyy HH:mm"
        dateFormatter.timeZone = NSTimeZone.local
        let timeStamp = dateFormatter.string(from: date!)
        
        return timeStamp
    }
    
}
