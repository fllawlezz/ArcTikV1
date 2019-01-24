//
//  EventInProgress+CoreDataClass.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/23/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//
//

import Foundation
import UIKit
import CoreData

@objc(EventInProgress)
public class EventInProgress: NSManagedObject {
    
    func transferToMyEvent() -> MyEvent{
        var thingsToBringUnwrapped: [String]?;
        var imagesUnwrapped: [UIImage]?;
        var requirementsUnwrapped: [String]?;
        
        if(self.thingsToBring != nil){
            thingsToBringUnwrapped = NSKeyedUnarchiver.unarchiveObject(with: self.thingsToBring! as Data) as? [String]
        }
        
        if(self.images != nil){
            imagesUnwrapped = NSKeyedUnarchiver.unarchiveObject(with: self.images! as Data) as? [UIImage];
        }
        
        if(self.requirements != nil){
            requirementsUnwrapped = NSKeyedUnarchiver.unarchiveObject(with: self.requirements! as Data) as? [String];
        }
        
        let myEvent = MyEvent();
        myEvent.eventID = Int(self.eventID);
        myEvent.eventTitle = self.title;
        myEvent.thingsToBring = thingsToBringUnwrapped;
        myEvent.city = self.city;
        myEvent.country = self.country;
        myEvent.endDate = self.endDate;
        myEvent.endTime = self.endTime;
        myEvent.description = self.eventDescription;
        myEvent.images = imagesUnwrapped;
        myEvent.people = Int(self.people);
        myEvent.charge = self.price;
        myEvent.privacy = self.privacy;
        myEvent.requirements = requirementsUnwrapped;
        myEvent.startDate = self.startDate;
        myEvent.startTime = self.startTime;
        myEvent.stepNumber = Int(self.step)
        myEvent.street = self.street;
        myEvent.zipcode = self.zipcode;
        
        return myEvent;
        
    }
}
