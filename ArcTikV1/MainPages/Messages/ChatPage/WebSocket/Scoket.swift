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
        self.socket = manager.defaultSocket;
        self.socket.connect();
    }
    
    
}
