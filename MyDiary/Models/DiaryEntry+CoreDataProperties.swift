//
//  DiaryEntry+CoreDataProperties.swift
//  MyDiary
//
//  Created by Mike Conner on 4/27/19.
//  Copyright © 2019 Mike Conner. All rights reserved.
//
//

import Foundation
import CoreData


extension DiaryEntry {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DiaryEntry> {
        return NSFetchRequest<DiaryEntry>(entityName: "DiaryEntry")
    }

    @NSManaged public var diaryEntryDate: NSDate?
    @NSManaged public var diaryEntryCreatedOrModifiedOnDate: NSDate?
    @NSManaged public var diaryEntryDetails: String?

}
