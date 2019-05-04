//
//  DiaryEntry+CoreDataProperties.swift
//  MyDiary
//
//  Created by Mike Conner on 5/4/19.
//  Copyright © 2019 Mike Conner. All rights reserved.
//
//

import Foundation
import CoreData


extension DiaryEntry {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DiaryEntry> {
        return NSFetchRequest<DiaryEntry>(entityName: "DiaryEntry")
    }

    @NSManaged public var diaryEntryCreatedOrModifiedOnDate: NSDate?
    @NSManaged public var diaryEntryDate: NSDate?
    @NSManaged public var diaryEntryDetails: String?
    @NSManaged public var diaryEntryLocation: String?

}
