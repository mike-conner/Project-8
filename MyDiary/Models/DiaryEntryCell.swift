//
//  DiaryEntryCell.swift
//  MyDiary
//
//  Created by Mike Conner on 4/27/19.
//  Copyright © 2019 Mike Conner. All rights reserved.
//

import UIKit

class DiaryEntryCell: UITableViewCell {
    
    var diaryEntryDate: String = ""
    var diaryEntryCreatedOrModifiedOnDate: String = ""
    var diaryEntryDetails: String = ""
    var diaryEntryLocation: String = ""
    
    @IBOutlet weak var diaryEntryDateLabel: UILabel!
    @IBOutlet weak var diaryEntryDetailsLabel: UILabel!
    @IBOutlet weak var diaryEntryCreatedOrModifiedOnDateLabel: UILabel!
    @IBOutlet weak var diaryEntryLocationLabel: UILabel!
    
    
}
