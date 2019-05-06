//
//  DetailViewController.swift
//  MyDiary
//
//  Created by Mike Conner on 4/27/19.
//  Copyright © 2019 Mike Conner. All rights reserved.
//

import UIKit
import CoreData

class DetailViewController: UIViewController {

    @IBOutlet weak var diaryEntryDateLabel: UILabel!
    @IBOutlet weak var diaryEntryDetailsTextView: UITextView!
    @IBOutlet weak var saveDiaryEntryButton: UIButton!
    @IBOutlet weak var editDiaryEntryButton: UIBarButtonItem!
    @IBOutlet weak var addLocationButton: UIButton!
    
    var editState: Bool = false
    
    var detailItem: DiaryEntry? {
        didSet {
            configureView()
        }
    }

    @IBAction func editEntryButton(_ sender: Any) {
        if editState == false {
            diaryEntryDetailsTextView.isEditable = true
            diaryEntryDetailsTextView.becomeFirstResponder()
            editDiaryEntryButton.title = "Save"
            addLocationButton.isEnabled = true
            editState = true
        } else {
            self.performSegue(withIdentifier: "finishedSaving", sender: self)
            updateDiaryEntry()
            diaryEntryDetailsTextView.isEditable = false
            editDiaryEntryButton.title = "Edit"
            addLocationButton.isEnabled = false
            editState = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        addLocationButton.isEnabled = false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "goToLocationVCFromEditVC" {
                let navigationController = segue.destination as! UINavigationController
                let destinationViewController = navigationController.topViewController as! LocationViewController
                destinationViewController.editedEntryDelegate = self
            }
        }
    }
    
    func configureView() {
        if let detail = detailItem {
            if let date = diaryEntryDateLabel {
                let formatter = DateFormatter()
                formatter.dateFormat = "EEEE, MMM d, yyyy"
                let tempDate = formatter.string(from: detail.diaryEntryDate! as Date)
                date.text = tempDate
            }
            if let details = diaryEntryDetailsTextView {
                details.text = detail.diaryEntryDetails!.description
            }
        }
    }

    func updateDiaryEntry() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        do {
            detailItem?.setValue(diaryEntryDetailsTextView.text, forKey: "diaryEntryDetails")
            detailItem?.setValue(Date(), forKey: "diaryEntryCreatedOrModifiedOnDate")
            detailItem?.setValue(addLocationButton.title(for: .normal) , forKey: "diaryEntryLocation")
            do {
                try managedContext.save()
            } catch {
                showAlert(with: "Uh-oh", and: "Something went wrong and your entry cannot be saved at this time.")
            }
        }
    }
}

