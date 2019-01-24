//
//  HostedEvent+CoreDataProperties.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/23/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//
//

import Foundation
import CoreData


extension HostedEvent {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<HostedEvent> {
        return NSFetchRequest<HostedEvent>(entityName: "HostedEvent")
    }

    @NSManaged public var eventID: Int16
    @NSManaged public var hosterID: Int16
    @NSManaged public var thingsToBring: NSData?
    @NSManaged public var city: String?
    @NSManaged public var country: String?
    @NSManaged public var endDate: String?
    @NSManaged public var endTime: String?
    @NSManaged public var eventDescription: String?
    @NSManaged public var imageNames: NSData?
    @NSManaged public var people: Int16
    @NSManaged public var price: Double
    @NSManaged public var privacy: String?
    @NSManaged public var requirements: NSData?
    @NSManaged public var startDate: String?
    @NSManaged public var startTime: String?
    @NSManaged public var street: String?
    @NSManaged public var eventTitle: String?
    @NSManaged public var zipcode: String?

}
