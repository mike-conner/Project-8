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
    
    var editState: Bool = false // used to monitor whether the user is editing or viewing the entry.

    @IBAction func editEntryButton(_ sender: Any) {
        if editState == false {
            diaryEntryDetailsTextView.isEditable = true
            diaryEntryDetailsTextView.becomeFirstResponder()
            editDiaryEntryButton.title = "Save"
            addLocationButton.isEnabled = true
            addLocationButton.backgroundColor = .white
            if addLocationButton.title(for: .normal) != "no location entered" {
                addLocationButton.setTitle(" update location ", for: .normal)
            } else {
                addLocationButton.setTitle(" add location ", for: .normal)
            }
            
            addLocationButton.setTitleColor(UIColor(red: 0.0196, green: 0.498, blue: 1, alpha: 1), for: .normal)
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
            if let _ = addLocationButton {
                if detail.diaryEntryLocation?.description != "add location" {
                    addLocationButton.setTitle("\(detail.diaryEntryLocation?.description ?? "Error")", for: .normal)
                } else {
                    addLocationButton.setTitle("no location entered", for: .normal)
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        addLocationButton.isEnabled = false
        diaryEntryDetailsTextView.layer.cornerRadius = 20
        diaryEntryDetailsTextView.layer.masksToBounds = true
        addLocationButton.layer.cornerRadius = 10
        addLocationButton.layer.masksToBounds = true
    }

    var detailItem: DiaryEntry? {
        didSet {
            configureView()
        }
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
                print(error)
            }
        }
    }

}

extension DetailViewController: LocationDelegate {
    func getLocation(placemark: String) {
        addLocationButton.setTitle(placemark, for: .normal)
    }
}

extension UIViewController {
    func showAlert(with title: String, and message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
