//
//  Friend+CoreDataProperties.swift
//  ArcTikV1
//
//  Created by Brandon In on 2/2/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//
//

import Foundation
import CoreData


extension Friend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Friend> {
        return NSFetchRequest<Friend>(entityName: "Friend")
    }

    @NSManaged public var userID: Int16
    @NSManaged public var userName: String?
    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var imageUrl: String?
    @NSManaged public var profileImage: NSData?

    
}
