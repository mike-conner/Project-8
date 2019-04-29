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
    
    var editState: Bool = false

    @IBAction func editEntryButton(_ sender: Any) {
        if editState == false {
            diaryEntryDetailsTextView.isEditable = true
            diaryEntryDetailsTextView.becomeFirstResponder()
            editDiaryEntryButton.title = "Save"
            editState = true
        } else {
            self.performSegue(withIdentifier: "finishedSaving", sender: self)
            updateDiaryEntry()
            diaryEntryDetailsTextView.isEditable = false
            editDiaryEntryButton.title = "Edit"
            editState = false
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

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }

    var detailItem: DiaryEntry? {
        didSet {
            configureView()
        }
    }

    func updateDiaryEntry() {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        
        do {
            detailItem?.setValue(diaryEntryDetailsTextView.text, forKey: "diaryEntryDetails")
            detailItem?.setValue(Date(), forKey: "diaryEntryCreatedOrModifiedOnDate")
            do {
                try managedContext.save()
            } catch {
                print(error)
            }
        }
    }

}

