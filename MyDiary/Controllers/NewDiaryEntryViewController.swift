//
//  NewDiaryEntryViewController.swift
//  MyDiary
//
//  Created by Mike Conner on 4/27/19.
//  Copyright © 2019 Mike Conner. All rights reserved.
//

import UIKit
import CoreData
import MapKit

class NewDiaryEntryViewController: UIViewController, NSFetchedResultsControllerDelegate {
    
    @IBOutlet weak var diaryEntryDate: UILabel!
    @IBOutlet weak var diaryEntryDetails: UITextView!
    @IBOutlet weak var cancelNewDiaryEntryButton: UIBarButtonItem!
    @IBOutlet weak var addLocationButton: UIButton!
    
    @IBAction func saveNewDiaryEntryButton(_ sender: Any) {
        if diaryEntryDetails.text == "" {
            showAlert(with: "Sorry", and: "You must enter your Entry Details to be able to save.")
            return
        }
        saveDiaryEntry()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "goToLocationVCFromNewEntryVC" {
                let navigationController = segue.destination as! UINavigationController
                let destinationViewController = navigationController.topViewController as! LocationViewController
                destinationViewController.newEntryDelegate = self
            }
        }
    }
    
    override func viewDidLoad() {
        getDate()
        diaryEntryDetails.becomeFirstResponder()
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
        diaryEntry.setValue(addLocationButton.title(for: .normal) , forKey: "diaryEntryLocation")
        
        do {
            try managedContext.save()
            dismiss(animated: true, completion: nil)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
}

extension NewDiaryEntryViewController: LocationDelegate {
    func getLocation(placemark: String) {
        addLocationButton.setTitle(placemark, for: .normal)
    }
}



