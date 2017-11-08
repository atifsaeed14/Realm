//
//  TaskTableCell.swift
//  sRealm
//
//  Created by Atif Saeed on 08/11/2017.
//  Copyright © 2017 Atif Saeed. All rights reserved.
//

import UIKit

class TaskTableCell: UITableViewCell {

    @IBOutlet var taskLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var editButton: UIButton!
    @IBOutlet var deleteButton: UIButton!
    @IBOutlet var detailButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
