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
        saveDiaryEntry()
    }
    
    func getDate() {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d, yyyy"
        let todaysDate = formatter.string(from: Date())
        diaryEntryDate.text = todaysDate
    }

    
    func saveDiaryEntry() {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        guard let diaryEntryEntity = NSEntityDescription.entity(forEntityName: "DiaryEntry", in: managedContext) else { return }
        let diaryEntry = NSManagedObject(entity: diaryEntryEntity, insertInto: managedContext)
        diaryEntry.setValue(diaryEntryDetails.text, forKeyPath: "diaryEntryDetails")
        diaryEntry.setValue(Date(), forKeyPath: "diaryEntryDate")
        diaryEntry.setValue(Date(), forKeyPath: "diaryEntryCreatedOrModifiedOnDate")
        
        do {
            try managedContext.save()
            dismiss(animated: true, completion: nil)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
    }
}
