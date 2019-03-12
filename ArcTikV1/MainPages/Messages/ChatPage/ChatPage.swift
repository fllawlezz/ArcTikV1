//
//  ChatPage.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/8/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit
import SocketIO

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
    
    let manager = SocketManager(socketURL: URL(string:"http://localhost:4000/")!, config: [.log(true),.connectParams(["token":"ABC438s"])])
    
    var socket: SocketIOClient!;
    
    //messages, chat room id,
//    var messages = [Message]();
    var messages: NSMutableDictionary?;
    var messagesDates: [String]?;
    
    var chatRoomID: Int?;
    
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
        
//        print(messagesDates?.count);
//        print(messages?.count);
//
        self.view.backgroundColor = UIColor.white;
        tableView.separatorStyle = .none
        
        self.tableView.register(ChatCell.self, forCellReuseIdentifier: messageCellReuse);
        self.tableView.register(ChatHeaderCell.self, forHeaderFooterViewReuseIdentifier: headerCellReuse);
        setupNavBar();
        self.tableView.keyboardDismissMode = .interactive;
        setupSocket();
        // have to sort messages by date
//        scrollToBottom();
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
//        print(dateString);
        let messagesList = messages!.value(forKey: dateString) as! [Message];
//        print(messagesList.count);
        
        let cell = tableView.dequeueReusableCell(withIdentifier: messageCellReuse, for: indexPath) as! ChatCell;
        let message = messagesList[indexPath.item];
        cell.setMessageText(message: message.message!);
        if(Int(message.senderID) != user!.userID){
            //not from user
            cell.isIncoming = true;
        }else{
            cell.isIncoming = false;
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
//                print("messagesCount:\(messagesDates!.count)")
                return messagesDates!.count;
            }
        }
        
        return 1;
    }
    
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40;
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if(messagesDates!.count > 0){
            let sectionDate = messagesDates![section];
            
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerCellReuse) as! ChatHeaderCell;
            header.setDateTitle(title: sectionDate);
            return header;
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
            let dateString = self.messagesDates!.last;//string
            print(dateString);
            let messagesCountArray = self.messages!.value(forKey: dateString!) as! [Message];
            let indexPath = IndexPath(row: messagesCountArray.count, section: self.messagesDates!.count-1);
            print(indexPath);
//            self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true);
//            }
        }
    }
    
    func sendMessage(message: String) {
        print("send message");
        guard let messageDates = self.messagesDates else {
            //error
//            print("send first message");
            return;
        }
        
        if(messageDates.count < 1){
            print("send first message");
            
            sendFirstMessage(message: message);
            
            return;
        }
        
        self.emitMessage(message: message);
        
//        if(messageDates.count > 0)

                
//                if(self.messagesDates!.count == 0){
//                    //if this is the first message, then basically a new message list
//                    var newMessageList = [Message]();
//                    newMessageList.append(newMessage);
//                    self.messages!.setValue(newMessageList, forKey: "\(newMessageDateString)")
//
//                    PersistenceManager.shared.save();
//
//                    self.tableView.reloadData();
////                    self.tableView.insertSections(IndexSet(integer: self.messages!.count - 1), with: .right);
//                }else{
//
//                    let currentSection = self.messagesDates!.count-1;//currentSection - 1
//                    let dateString = self.messagesDates![currentSection];//
//
//                    if(newMessageDateString != dateString){
//                        //start new message section
//                        var newMessageList = [Message]();
//                        newMessageList.append(newMessage);
//                        self.messages!.setValue(newMessageList, forKey: "\(newMessageDateString)")
//
//                        PersistenceManager.shared.save();
//
//                        self.tableView.insertSections(IndexSet(integer: self.messages!.count - 1), with: .right);
//                    }else{
//                        var messagesList = self.messages!.value(forKey: dateString) as! [Message];
//
//                        messagesList.append(newMessage);
//
//                        PersistenceManager.shared.save();
//
//                        self.tableView.insertRows(at: [IndexPath(item: messagesList.count-1, section: currentSection)], with: UITableViewRowAnimation.right);
//                    }
//
//                    print("success");
//                }
//            }
//            }else{
//                //show error
            }
        //json body

    func sendFirstMessage(message: String){
        let date = NSDate();
        //        print(date);
        let formatter = DateFormatter();
        formatter.dateFormat = "h:mm:ss a, MM/dd/yyyy";
        
        let dateString = formatter.string(from: date as Date);
        //        print(dateString);
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
                
//                print(chatRoomID);
//                print(message);
                
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
        print("emitMessage");
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
        print(socketData);
        
        self.socket.emit("sendMessage", [socketData]);
        
    }
    
    func recieveMessage(senderID: Int, chatRoomID: Int, message: String, date: NSDate, messageID: Int){
        
        print("recieve message");
        
        print(chatRoomID);
        print(messageID);
        print(senderID);
        
        let newMessage = Message(context: PersistenceManager.shared.context);
        newMessage.senderID = Int16(senderID);
        newMessage.messageID = Int16(messageID);
        newMessage.chatRoomID = Int16(chatRoomID);
        newMessage.message = message;
        newMessage.date = date;
        PersistenceManager.shared.save();
        
        let calendar = NSCalendar.current;
        let monthComponent = calendar.component(.month, from: date as Date);
        let dayComponenet = calendar.component(.day, from: date as Date);
        let yearComponent = calendar.component(.year, from: date as Date);
        
        let newMessageDateString = "\(monthComponent)\(dayComponenet)\(yearComponent)"
        
        //search for the newMessageDateString in the messagesDates
        if(self.messagesDates == nil){
            //error
            return;
        }
        
//        print("passed all checks");
        
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
                    
//                    print("messages found with date");
                    
                    if(newMessage.senderID != user!.userID){
                        self.tableView.insertRows(at: [IndexPath(item: messageArray.count-1, section: count)], with: .left);//inserts from the left
                    }else{
                        self.tableView.insertRows(at: [IndexPath(item: messageArray.count-1, section: count)], with: .right);
                    }
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
            self.tableView.insertSections(IndexSet(integer: self.messagesDates!.count-1), with: .fade);
            self.scrollToBottom();
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
//            if(self.messagesDates!.count != 0){
//                self.socket.emit("sendMessage", []);
//            }else{
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
    
    func filterMessages(){
        //need to filter by date, so new header/section after each day
        var filteredMessages = [[Message]]();
        
    }
    
}
