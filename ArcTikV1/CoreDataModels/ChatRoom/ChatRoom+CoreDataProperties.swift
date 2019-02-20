//
//  ChatRoom+CoreDataProperties.swift
//  ArcTikV1
//
//  Created by Brandon In on 2/19/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//
//

import Foundation
import CoreData


extension ChatRoom {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ChatRoom> {
        return NSFetchRequest<ChatRoom>(entityName: "ChatRoom")
    }

    @NSManaged public var chatRoomID: Int16
    @NSManaged public var lastMessage: String?
    @NSManaged public var lastMessageTime: NSDate?
    @NSManaged public var people: NSData?
    @NSManaged public var lastMessageID: Int16
    @NSManaged public var readLastMessage: Bool

}
