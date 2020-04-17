//
//  ActivityData+CoreDataProperties.swift
//  KidsActivities
//
//  Created by Maitree Bain on 4/16/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//
//

import Foundation
import CoreData


extension ActivityData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ActivityData> {
        return NSFetchRequest<ActivityData>(entityName: "ActivityData")
    }

    @NSManaged public var imageData: Data?
    @NSManaged public var videoData: Data?
    @NSManaged public var activityName: String?
    @NSManaged public var personifiedItem: String?
    @NSManaged public var id: String?
    @NSManaged public var date: Date?

}
