//
//  Scoket.swift
//  ArcTikV1
//
//  Created by Brandon In on 2/2/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit
import SocketIO

extension ChatPage{
    func setupSocket(){
        print("setupSocket");
        self.socket = manager.defaultSocket;
        
        
        self.socket.on(clientEvent: .connect) { (data, acks) in
            print("socketUserSetup");
            let userData = ["chatRoomID": self.chatRoomID!];
            self.socket.emit("userSetup", with: [userData]);
        }

        self.socket.on("messageRecieved") { (data, acks) in
            
            print("messageRecieved");
            
            let senderData = data[0] as! NSDictionary;
            
//            print(senderData);
            
            let senderID = senderData["senderID"] as! Int;
            let messageID = senderData["messageID"] as! Int;
            let message = senderData["message"] as! String;
            let chatRoomID = senderData["chatRoomID"] as! Int;
            let dateString = senderData["date"] as! String;
            let senderName = senderData["senderName"] as! String;
            
            let formatter = DateFormatter();
            formatter.dateFormat = "h:mm:ss a, MM/dd/yyyy";
            
            let date = formatter.date(from: dateString)! as NSDate;
//            print("recieveMessage prior");
            self.recieveMessage(senderID: senderID, chatRoomID: chatRoomID, message: message, date: date, messageID: messageID, senderName: senderName);
        }
        
        self.socket.connect();
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.manager.disconnect();
    }
    
    
}
