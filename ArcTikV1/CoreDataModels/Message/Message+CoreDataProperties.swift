//
//  Message+CoreDataProperties.swift
//  ArcTikV1
//
//  Created by Brandon In on 3/2/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//
//

import Foundation
import CoreData


extension Message {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Message> {
        return NSFetchRequest<Message>(entityName: "Message")
    }

    @NSManaged public var chatRoomID: Int16
    @NSManaged public var date: NSDate?
    @NSManaged public var message: String?
    @NSManaged public var senderID: Int16
    @NSManaged public var messageID: Int16

}
