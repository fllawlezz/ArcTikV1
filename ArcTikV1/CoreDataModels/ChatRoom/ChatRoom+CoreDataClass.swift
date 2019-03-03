//
//  ChatRoom+CoreDataClass.swift
//  ArcTikV1
//
//  Created by Brandon In on 2/19/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//
//

import Foundation
import CoreData

@objc(ChatRoom)
public class ChatRoom: NSManagedObject {
    
    var chatRoomFriendList = NSMutableDictionary();
    var friendObjectList = NSMutableDictionary();
    
    func getID()->Int{
        return Int(self.chatRoomID);
    }
    
    func friendExist(friendID: Int)->Bool{
        let value = chatRoomFriendList.value(forKey: "\(friendID)");
        if(value == nil){
            return false;//friend List
        }
        return true;//friend exists
    }
}
