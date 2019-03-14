//
//  ChatPage.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/8/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit
import SocketIO

protocol ChatPageDelegate{
    func reloadItemsAt(indexPath: IndexPath);
}

class ChatPage: UITableViewController, ComposePageDelegate,SendMessageViewDelegate{
    
//    let sendMessageView = SendMessageView();
    
    lazy var sendMessageView: SendMessageView = {
        let sendMessageView = SendMessageView();
        sendMessageView.sendMessageViewDelegate = self;
        return sendMessageView;
    }()
    
    let messageCellReuse = "messageCellReuse";
    let headerCellReuse = "mesasgeHeaderCellReuse";
    
    var recieverList = NSMutableDictionary();
    
    var socket: SocketIOClient!;
    let manager = SocketManager(socketURL: URL(string:"http://localhost:4000/")!, config: [.log(true),.connectParams(["token":"ABC438s"])])
    
    var chatPageDelegate: ChatPageDelegate?;
    //messages, chat room id,
//    var messages = [Message]();
    var messages: NSMutableDictionary?;
    var messagesDates: [String]?;
    var indexPath: IndexPath?;
    var chatRoomID: Int?;
    var lastSenderID: Int = user!.userID;
    
    var chatRoom: ChatRoom?{
        didSet{
            self.chatRoomID = Int(chatRoom!.chatRoomID);
            self.recieverList = chatRoom!.chatRoomFriendList;
//            setupNavBar();
        }
    }
    
    //from event
    var event: Event?;
    
    override func viewDidLoad() {
        super.viewDidLoad();

        self.view.backgroundColor = UIColor.white;
        tableView.separatorStyle = .none
        
        self.tableView.register(ChatCell.self, forCellReuseIdentifier: messageCellReuse);
        self.tableView.register(ChatHeaderCell.self, forHeaderFooterViewReuseIdentifier: headerCellReuse);
        setupNavBar();
        self.tableView.keyboardDismissMode = .interactive;
        if(chatRoomID != nil){
            setupSocket();
        }
    }
    
    deinit{
        NotificationCenter.default.removeObserver(self);
    }
    
    override var inputAccessoryView: UIView?{
        get{
            return self.sendMessageView;
        }
    }
    
    override var canBecomeFirstResponder: Bool{
        return  true;
    }
    
    fileprivate func setupNavBar(){
        var recieversString = "";
        
        if(recieverList.count > 1){
            var count = 0;
            for reciever in recieverList{
                let friend = reciever.value as! Friend;
                recieversString += friend.firstName!;
                if(count != recieverList.count-1){
                    recieversString += ",";
                }
                count+=1;
            }
        }else{
            for reciever in recieverList{
                let friend = reciever.value as! Friend;
                print(friend.userID);
                recieversString += friend.firstName!;
            }
        }
        
        self.navigationItem.title = recieversString;
        
        let infoButton = UIBarButtonItem(image: #imageLiteral(resourceName: "info"), style: .plain, target: nil, action: nil);
        self.navigationItem.rightBarButtonItem = infoButton;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //get messages date section
        let dateString = messagesDates![indexPath.section];//dateString
        let messagesList = messages!.value(forKey: dateString) as! [Message];
        
        let cell = tableView.dequeueReusableCell(withIdentifier: messageCellReuse, for: indexPath) as! ChatCell;
        let message = messagesList[indexPath.item];
        cell.message = message;
        cell.setMessageText(message: message.message!);
        
        if(Int(message.senderID) != user!.userID){
            //not from user
            cell.isIncoming = true;
            if((indexPath.item-1) >= 0){
                if(messagesList[indexPath.item-1].senderID != message.senderID){
                    //if the id's aren't the same, then show the name label
                    cell.setSenderName(senderName: message.senderName!);
                }else{
                    //if messagesList are the same, then hide the name label
                    cell.hideSenderNameLabel();
                    cell.setSameSenderConstant();
                }
            }else{
                cell.setSenderName(senderName: message.senderName!);
            }
//            cell.setSenderName(senderName: message.senderName!);
            //need to set the sender's name if the previous sender's name isn't the same
//            if(Int(message.senderID) != self.lastSenderID){
//                self.lastSenderID = Int(message.senderID);
//                cell.setSenderName(senderName: message.senderName!);
//            }else{
//                cell.hideSenderNameLabel();
//            }
        }else{
            cell.hideSenderNameLabel();
            cell.isIncoming = false;
            self.lastSenderID = user!.userID;
        }
        return cell;
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(messagesDates != nil){
            if(messagesDates!.count > 0){
                let messageArray = messages!.value(forKey: messagesDates![section]) as! [Message];
                print("numberOfRows: \(messageArray.count)");
                return messageArray.count;
            }
        }
        
        return 0;
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if(messagesDates != nil){
            if(messagesDates!.count > 0){
                return messagesDates!.count;
            }
        }
        
        return 1;
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true);
    }
    
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40;
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if(messagesDates != nil){
            if(messagesDates!.count > 0){
                let sectionDate = messagesDates![section];
                
                let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerCellReuse) as! ChatHeaderCell;
                header.setDateTitle(title: sectionDate);
                return header;
            }
        }
        
        let backgroundView = UIView();
        backgroundView.backgroundColor = UIColor.white;
        
        return backgroundView;

    }
    
}

extension ChatPage{
    func handlePeopleSelected(selectedList: NSMutableDictionary) {
        self.recieverList = selectedList;
        reloadInputViews();
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        print("appeared");
        self.becomeFirstResponder();
        reloadInputViews();
    }
}

extension ChatPage{
    func scrollToBottom() {
        //scroll to bottom
        if(self.messagesDates != nil){
//            if(self.messages!.count>3){
            if(self.messagesDates!.count > 0){
                let dateString = self.messagesDates!.last;//string
    //            print(dateString);
                let messagesCountArray = self.messages!.value(forKey: dateString!) as! [Message];
                let indexPath = IndexPath(row: messagesCountArray.count-1, section: self.messagesDates!.count-1);
    //            print(indexPath);
                self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true);
            }
//            }
        }
    }
    
    func sendMessage(message: String) {

        guard let messageDates = self.messagesDates else {
            //error
            return;
        }
        
        if(messageDates.count < 1){
            sendFirstMessage(message: message);
            
            return;
        }
        
        self.emitMessage(message: message);
    }
        //json body

    func sendFirstMessage(message: String){
        let date = NSDate();
        let formatter = DateFormatter();
        formatter.dateFormat = "h:mm:ss a, MM/dd/yyyy";
        
        let dateString = formatter.string(from: date as Date);
        //get the index path of the message
        //messages acts as a queue, first in first out... therefore we append to the end
        
        let jsonBodyData = translateJson(message: message, date: dateString);
        //send message, already checked for length
        if(jsonBodyData != nil){
            //            print("attempt");
            attemptToSendMessage(jsonData: jsonBodyData!) { (error) in
                if(error){
                    //there was an error, therefore show the error symbol
                    print("error occured");
                    return;
                }
                
                guard let chatRoomID = self.chatRoomID else{
                    print("chat room id null");
                    //add message to the list but
                    //show error alert in sending the message
                    return;
                }
                
                let newMessage = Message(context: PersistenceManager.shared.context);
                newMessage.chatRoomID = Int16(chatRoomID);
                newMessage.message = message;
                newMessage.senderID = Int16(user!.userID);
                newMessage.date = date as NSDate;
                PersistenceManager.shared.save();
                
//                print("appending and reloading tableView");
                
                //get the current month,date,and year,
                //if it doesn't match the date string, then create a new date string and start a new messages section
                let calendar = NSCalendar.current;
                let monthComponent = calendar.component(.month, from: date as Date);
                let dayComponenet = calendar.component(.day, from: date as Date);
                let yearComponent = calendar.component(.year, from: date as Date);
                
                let newMessageDateString = "\(monthComponent)\(dayComponenet)\(yearComponent)"
                
                var newMessageList = [Message]();
                newMessageList.append(newMessage);
                self.messages!.setValue(newMessageList, forKey: "\(newMessageDateString)")
                
                self.messagesDates?.append(newMessageDateString);
                
                self.tableView.reloadData();
            }
        }
    }
    
    func emitMessage(message: String){
        let date = NSDate();
        let formatter = DateFormatter();
        formatter.dateFormat = "h:mm:ss a, MM/dd/yyyy";
        
        let dateString = formatter.string(from: date as Date);
        
        guard let chatRoomID = self.chatRoomID else {
            //error
            print("chatRoomerror");
            return;
        }
        
        let socketData = ["userID":user!.userID, "senderName":user!.firstName, "message":message, "chatRoomID":chatRoomID, "date":dateString] as [String : Any]
        
        self.socket.emit("sendMessage", [socketData]);
        
    }
    
    func recieveMessage(senderID: Int, chatRoomID: Int, message: String, date: NSDate, messageID: Int, senderName: String){

        let newMessage = Message(context: PersistenceManager.shared.context);
        newMessage.senderID = Int16(senderID);
        newMessage.messageID = Int16(messageID);
        newMessage.chatRoomID = Int16(chatRoomID);
        newMessage.message = message;
        newMessage.date = date;
        newMessage.senderName = senderName;
        
        self.chatRoom!.lastMessageID = Int16(messageID);
        self.chatRoom!.lastMessage = message;
        self.chatRoom!.lastMessageTime = date;
        if(self.indexPath != nil){
            self.chatPageDelegate?.reloadItemsAt(indexPath: self.indexPath!);
        }
        PersistenceManager.shared.save();
        
        //need to reload the indices in the chatRooms
        
        
        let calendar = NSCalendar.current;
        let monthComponent = calendar.component(.month, from: date as Date);
        let dayComponent = calendar.component(.day, from: date as Date);
        let yearComponent = calendar.component(.year, from: date as Date);
        
        var month: String;
        
        switch(monthComponent){
        case 1: month = "Jan.";break;
        case 2: month = "Feb.";break;
        case 3: month = "Mar.";break;
        case 4: month = "Apr.";break;
        case 5: month = "May";break;
        case 6: month = "June";break;
        case 7: month = "July";break;
        case 8: month = "Aug.";break;
        case 9: month = "Sept.";break;
        case 10: month = "Oct.";break;
        case 11: month = "Nov.";break;
        case 12: month = "Dec.";break;
        default: month = "Some.";break;
        }
        
        let newMessageDateString = "\(month) \(dayComponent), \(yearComponent)"
        
        //search for the newMessageDateString in the messagesDates
        if(self.messagesDates == nil){
            //error
            return;
        }
        
        var count = 0;
        while(count < self.messagesDates!.count){
            let messageDate = self.messagesDates![count];
            if(messageDate == newMessageDateString){
                //then append to the corresponding messages
                //insert message
                if(self.messages != nil){
                    var messageArray = self.messages!.value(forKey: messageDate) as! [Message];//creats a new set
                    messageArray.append(newMessage);
                    
                    self.messages!.setValue(messageArray, forKey: messageDate);
                    
                    if(newMessage.senderID != user!.userID){
                        self.tableView.insertRows(at: [IndexPath(item: messageArray.count-1, section: count)], with: .bottom);//inserts from the left
                    }else{
                        self.tableView.insertRows(at: [IndexPath(item: messageArray.count-1, section: count)], with: .bottom);
                    }
                    
                    //need to change the last message and make it read
                    self.chatRoom!.lastMessage = newMessage.message!;
                    self.chatRoom!.lastMessageTime = newMessage.date!;
                    self.chatRoom!.readLastMessage = true;
                    PersistenceManager.shared.save();//saves the changes
                    
                    self.scrollToBottom();
                }
                return;
            }
            count+=1;
        }
        
        if(self.messages != nil){
            
            self.messagesDates!.append(newMessageDateString);
            var newMessagesArray = [Message]();
            newMessagesArray.append(newMessage);
            self.messages!.setValue(newMessagesArray, forKey: newMessageDateString);
            
//            self.tableView.reloadData();
            self.tableView.insertSections(IndexSet(integer: self.messagesDates!.count-1), with: .bottom);
            
            self.chatRoom!.lastMessage = newMessage.message!;
            self.chatRoom!.lastMessageTime = newMessage.date!;
            self.chatRoom!.readLastMessage = true;
            
            PersistenceManager.shared.save();//saves the changes
            
            self.scrollToBottom();
            //need to change the last message and make it read
//            print("messages reload nil");
            return;
        }
    }
    
    fileprivate func translateJson(message: String, date: String)-> Data?{
        var recieverIDs = [Int]();
        for tuple in recieverList{
            let recieverID = tuple.key;//tuple.key is the userID
            if let id = (recieverID as? NSString)?.integerValue{
                recieverIDs.append(id);
            }
            
        }
        
        let jsonDictionary = NSMutableDictionary();
        jsonDictionary.setValue(recieverIDs, forKey: "recieverList");
        jsonDictionary.setValue(message, forKey: "message");
        jsonDictionary.setValue(user!.userID, forKey: "senderID");
        jsonDictionary.setValue(date, forKey: "date")
        if(self.event != nil){
            jsonDictionary.setValue(event!.eventID!, forKey: "eventID");
        }
        
        do{
            let json = try JSONSerialization.data(withJSONObject: jsonDictionary, options: .prettyPrinted);
            return json;//return json data if success
        }catch{
//            print(error);
            print("error");
            return nil;//return nil if failed
        }
    }
    
    func attemptToSendMessage(jsonData: Data, completion: @escaping (Bool)->()){//bool indicates if there was an error
        DispatchQueue.global(qos: .background).async {
                let url = URL(string: "http://localhost:3000/sendNewMessage")!;
                var request = URLRequest(url: url);
                request.httpMethod = "POST";
                request.httpBody = jsonData;
                request.addValue("application/json", forHTTPHeaderField: "Content-Type");
                let urlTask = URLSession.shared.dataTask(with: request) { (data, res, err) in
                    if(err != nil){
                        DispatchQueue.main.async {
                            completion(true);
                        }
                    }
                    if(data != nil){
                        let response = NSString(data: data!, encoding: 8)! as String;
                        if(response == "none"){
                            DispatchQueue.main.async {
                                completion(true);
                            }
                        }else{
                            DispatchQueue.main.async {
                                if(self.chatRoomID == nil){
                                    let chatRoomID = Int(response);
                                    self.chatRoomID = chatRoomID;
//                                    print(chatRoomID);
                                }
    //                            print(chatRoomID);
                                completion(false);
                            }
                        }
                    }
                }
                urlTask.resume();
//            }
        }//dispatchqueue.global
        
    }
    
}
