//
//  NewDiaryEntryViewController.swift
//  MyDiary
//
//  Created by Mike Conner on 4/27/19.
//  Copyright © 2019 Mike Conner. All rights reserved.
//

import UIKit
import CoreData

class NewDiaryEntryViewController: UIViewController, NSFetchedResultsControllerDelegate {
    
    @IBOutlet weak var diaryEntryDate: UILabel!
    @IBOutlet weak var diaryEntryDetails: UITextView!
    
    override func viewDidLoad() {
        getDate()
    }
    
    @IBAction func saveDiaryEntry(_ sender: Any) {
        
    }
    
    func getDate() {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d, yyyy"
        let todaysDate = formatter.string(from: Date())
        diaryEntryDate.text = todaysDate
    }
    
    
}
