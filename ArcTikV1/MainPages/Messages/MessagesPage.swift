//
//  Messages.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/3/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit
import CoreData

class MessagesPage: UIViewController, MessagesCollectionViewDelegate, ChatPageDelegate{
    
    var selector = UISegmentedControl(items: ["Direct","Group"]);
    var refreshControl = UIRefreshControl();
    
    var messagesList: MessagesCollectionView = {
        let layout = UICollectionViewFlowLayout();
        let messagesList = MessagesCollectionView(frame: .zero, collectionViewLayout: layout);
        return messagesList;
    }()
    
    var chatRooms = NSMutableDictionary();//dictionary of ChatRooms: key = chatRoomID, value = chatRoom object
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.view.backgroundColor = UIColor.white;
        setupNavBar();
        setupMessagesList();
        addObservers();
        setupRefreshControl();
        loadChatRooms();
    }
    
    deinit{
        NotificationCenter.default.removeObserver(self);
    }
    
    fileprivate func addObservers(){
        let name = Notification.Name(rawValue: dismissComposePage);
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleDismissNotification), name: name, object: nil);
    }
    
    fileprivate func setupNavBar(){
        let composeButton = UIBarButtonItem(image: UIImage(named: "compose"), style: .plain, target: self, action: #selector(handleComposePressed));
        
//        let composeButton = UIBarButtonItem(image: UIImage(named: "compose"), style: .plain, target: self, action: #selector(loadChatRooms));
        
        self.navigationItem.rightBarButtonItem = composeButton;
        
        selector.selectedSegmentIndex = 0;
        self.navigationItem.titleView = selector;
    }
    
    fileprivate func setupMessagesList(){
        self.view.addSubview(messagesList);
        messagesList.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        messagesList.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        messagesList.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true;
        messagesList.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true;
        
        messagesList.messageViewDelegate = self;
    }
    
    fileprivate func setupRefreshControl(){
        self.messagesList.refreshControl = self.refreshControl;
        self.refreshControl.addTarget(self, action: #selector(self.refreshMessageList), for: .valueChanged);
    }
    
    @objc func refreshMessageList(){
        self.messagesList.reloadMessages();
//        print("refresh");
    }
    
    func endRefreshing(){
        self.refreshControl.endRefreshing();
    }
}

extension MessagesPage{
    func handleSelectedCell(chatRoom: ChatRoom, indexPath: IndexPath) {
        
        /*
         0. show activity indicator, load messages
         1. set the chatRoom at the index to be equal to read
         2. load the last 20 messages from chat
         3. transfer over data to chat page
         4. show chatPage
         */
        
        chatRoom.readLastMessage = true;
        PersistenceManager.shared.save();
//        print("saved chatRoom");
            
        let chatPage = ChatPage();
        chatPage.chatRoom = chatRoom;
        chatPage.indexPath = indexPath;
        chatPage.chatPageDelegate = self;
        chatPage.hidesBottomBarWhenPushed = true;
        //need to pass over a dictionary of friends
        
//        the chatroomFriendList already has the friends in its dictionary, so just pass it over
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Message");
//        let batchDelete = NSBatchDeleteRequest(fetchRequest: fetchRequest);
//        do{
//            try PersistenceManager.shared.context.execute(batchDelete);
//        }catch{
//
//        }
        
        //load messages from core data where chatRoomID = chatRoomID
        let messageFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Message");
        let filterPredicate = NSPredicate(format: "chatRoomID == %@", "\(chatRoom.chatRoomID)")
        messageFetchRequest.sortDescriptors = [NSSortDescriptor(key: "messageID", ascending: false)]//the latest ones are at the bottom
        messageFetchRequest.predicate = filterPredicate;
        messageFetchRequest.fetchLimit = 20;
        
        do{
            if let results = try PersistenceManager.shared.context.fetch(messageFetchRequest) as? [Message]{
                print(results.count);
                //need to reverse the results
                var reversedResults = [Message]();
                var lastMessageID: Int16 = 0;
                if(results.count != 0){
                    lastMessageID = results.first!.messageID;
                }
                
                for message in results{
                    reversedResults.insert(message, at: 0);//prepends
                }
                
                
                DispatchQueue.global(qos: .background).async {
                    self.loadRecentMessages(chatRoomID: Int(chatRoom.chatRoomID), lastMessageID: Int(lastMessageID), completion: { (messages) in
                        if(messages != nil){
                            //then append to the reversed results
                            print("messages not nil");
                            for message in messages!{
                                reversedResults.append(message);
                                print(message);
                            }
                        }
                        
//                        for message in reversedResults{
//                            print(message.message!);
//                        }
                        
                        let messagesInfo = self.filterMessages(messages: reversedResults);
                        
                        let messageDates = messagesInfo["dates"] as! [String];
                        let messagesDictionary = messagesInfo["messagesDictionary"] as! NSMutableDictionary;
                        
                        chatPage.messagesDates = messageDates;
                        chatPage.messages = messagesDictionary;
                        self.navigationController?.pushViewController(chatPage, animated: true);
                        self.messagesList.reloadItems(at: [indexPath]);
                    })
                }
                print("loading recent messages");
                
            }
        }catch{
            print("error");
            //show error and exit
        }
            
            //filter dates by addresses and insert into a hashtable
        
        
    }
    
    func filterMessages(messages: [Message])->[String : Any]{
//        var messagesInfo = [String:Any]();
        
        let messagesHashTable = NSMutableDictionary();
        var dates = [String]();
        
        for message in messages{
            if let date = message.date{
                //get the day of the date
                let date = date as Date;
                let calendar = NSCalendar.current;
                let monthComponent = calendar.component(.month, from: date);
                let dayComponent = calendar.component(.day, from: date);
                let yearComponent = calendar.component(.year, from: date);
                
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
                
                let dateString = "\(month) \(dayComponent), \(yearComponent)"
                
                var messagesForDate = messagesHashTable.value(forKey: dateString) as? [Message];
                if(messagesForDate == nil){
                    //create one and add both dateString to dates and messagesHashTables
                    var newMessageList = [Message]();
                    newMessageList.append(message);
                    messagesHashTable.setValue(newMessageList, forKey: dateString);
                    
                    dates.append(dateString);
                }else{
                    messagesForDate!.append(message);//appends message to the messageForDate
                    messagesHashTable.setValue(messagesForDate, forKey: dateString);
                }
            }
        }
        
        let messagesInfo = ["dates":dates,"messagesDictionary":messagesHashTable] as [String : Any];
        
        return messagesInfo;
        
    }
    
    @objc func handleComposePressed(){
       
        let chatPage = ChatPage();
        chatPage.hidesBottomBarWhenPushed = true;
        
        let composePage = ComposePage();
        composePage.delegate = chatPage;
        
        var friends = [Friend]();
        
        //get friends data from core data
        var count = 0;
        while(count < 20){
            let friend = Friend(context: PersistenceManager.shared.context);
//            friend.userName = "\(count)"
            friend.firstName = "\(count)"
            friend.selected = false;
            friend.userID = Int16(count);
            friends.append(friend);
            count+=1;
        }
        composePage.composeMessageTableView.friendList = friends;
        
        let navigationController = UINavigationController(rootViewController: composePage);
        navigationController.navigationBar.isTranslucent = false;
        navigationController.navigationBar.barTintColor = UIColor.appBlue;
        navigationController.navigationBar.tintColor = UIColor.white;
        navigationController.navigationBar.barStyle = UIBarStyle.blackTranslucent;
        navigationController.title = "Select People";
        
        
        self.present(navigationController, animated: true, completion: nil);
        self.navigationController?.pushViewController(chatPage, animated: true);
    }
    
    @objc func handleDismissNotification(){
        self.navigationController?.popToRootViewController(animated: true);
        self.dismiss(animated: true, completion: nil);
    }
    
}

extension MessagesPage{
    @objc func handleLoadMessages(completion: @escaping (NSDictionary?)->()){
        //load from core data first
        let url = URL(string: "http://localhost:3000/loadChatRooms")!;
        let body = "userID=\(user!.userID)"
        var request = URLRequest(url: url);
        request.httpMethod = "POST";
        request.httpBody = body.data(using: .utf8);
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, res, err) in
            if(err != nil){
                print("error");
                return;
            }
            if(data != nil){
                let response = NSString(data: data!, encoding: 8) as String?;
                if(response == "error"){
                    //print error
                    print("error");
                    completion(nil);
                }else{
                    do{
                        let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! NSDictionary
                        print(json);
                        completion(json)
                    }catch{
                        print(error);
                    }
                }
            }
        }
        dataTask.resume();
    }
    
    @objc func loadChatRooms(){
        
        DispatchQueue.global(qos: .background).async {
            //load from core data the chat rooms that were previously saved
            let chatRooms = PersistenceManager.shared.fetch(ChatRoom.self);
            let chatRoomsInfo = NSMutableDictionary();
            
            for chatRoom in chatRooms{
//                let chatRoomInfo = [chatRoom.chatRoomID: chatRoom.lastMessageID];
//                print("chatRoom: \(chatRoom.chatRoomID), lastMessageID:\(chatRoom.lastMessageID), read: \(chatRoom.readLastMessage)");
//                chatRoomsInfo.setValue(chatRoom.lastMessageID, forKey: "\(chatRoom.chatRoomID)");//used to compare the chatRoomID from the loaded ones
                //add the chatRoom to self.chatRooms
                self.chatRooms.setValue(chatRoom, forKey: "\(chatRoom.chatRoomID)");
//                PersistenceManager.shared.context.delete(chatRoom);
//                PersistenceManager.shared.save();

            }
            
            self.handleLoadMessages { (dictionary) in
                guard let dictionary = dictionary else{
                    DispatchQueue.main.async {
                        //do something else here
                        //no chatRooms
                    }
                    return;
                }
                
                //core data load friends list
                
                let chatRoomArray = dictionary["chatRoomArray"] as! NSArray;
                let chatRoomLastMessages = dictionary["lastMessages"] as! NSArray;
                //we have an array of items which have userID, firstName, lastName, chatRoomID;
                
                //should only return new items, so just add the new ones and append to the other chatRooms
                
                /*
                1. cross check all chatRooms that are loaded with the chatRoom IDs  in the last messages
                    if they match, then change the last message and save a new message where the chatRoomID = chatRoomID
                    remove the element
                 2. for the rest of the items, make a new chatRoom
                    add friends
                    add messages
                */
                
                self.addChatRoomPeople(chatRoomArray: chatRoomArray, loadedChatRooms: chatRoomsInfo);
                self.addLastMessages(lastMessages: chatRoomLastMessages);
               
                DispatchQueue.main.async {
                   self.messagesList.chatRoomsDictionary = self.chatRooms;
                }
                

                
            }
        }
        
    }
    
    func addChatRoomPeople(chatRoomArray: NSArray, loadedChatRooms: NSDictionary){
        for peopleInfo in chatRoomArray{
            let infoDictionary = peopleInfo as! NSDictionary;
            let chatRoomID = infoDictionary["chatRoomID"] as! Int;
            
            //need to check to see if the chatRoomExists
            let chatRoom = self.chatRooms.value(forKey: "\(chatRoomID)") as? ChatRoom;
            
            if(chatRoom == nil){
                //create new chat room, add the person to the chatRoom
                let chatRoom = ChatRoom(context: PersistenceManager.shared.context);
                chatRoom.chatRoomID = Int16(infoDictionary["chatRoomID"] as! Int);
                
                //check to see if the friend exists,
                //if friend exists, add friend (new friend, not the reference) to the chatRoom
                //else make a new friend and add to the chatRoom
                
                let firstName = infoDictionary["firstName"] as? String;
                let lastName = infoDictionary["lastName"] as? String;
                let userID = infoDictionary["userID"] as! Int;
                
                self.addFriend(firstName: firstName, lastName: lastName, userID: userID, chatRoom: chatRoom);
                self.chatRooms.setValue(chatRoom, forKey: "\(chatRoomID)");
            }else{
                //chat room exists

                let firstName = infoDictionary["firstName"] as? String;
                let lastName = infoDictionary["lastName"] as? String;
                let userID = infoDictionary["userID"] as! Int;

                self.addFriend(firstName: firstName, lastName: lastName, userID: userID, chatRoom: chatRoom!);
            }
            
        }
    }
    
    func addFriend(firstName: String?, lastName: String?, userID: Int?, chatRoom: ChatRoom){
        //check to see if the friend exists,
        if(!chatRoom.friendExist(friendID: userID!)){
            //doesn't exist
            let chatRoomFriend = Friend(context: PersistenceManager.shared.context);
            chatRoomFriend.firstName = firstName
            chatRoomFriend.lastName = lastName
            chatRoomFriend.userID = Int16(userID!)
            
            chatRoom.chatRoomFriendList.setValue(chatRoomFriend, forKey: "\(userID!)");
        }
        //if friend exists, add friend reference (new friend, not the reference) to the chatRoom
        //else make a new friend and add to the chatRoom
        
    }
    
    func addLastMessages(lastMessages: NSArray){
//        var count = 0;
        for lastMessageDictionary in lastMessages{
            let lastMessage = lastMessageDictionary as! NSDictionary;
            let chatRoomID = lastMessage["chatRoomID"] as! Int;
            let message = lastMessage["lastMessage"] as! String;
            let messageDate = lastMessage["lastMessageDate"] as! String;
            let messageID = lastMessage["messageID"] as! Int;
            let senderID = lastMessage["senderID"] as! Int;
            
            let chatRoom = self.chatRooms.value(forKey: "\(chatRoomID)") as? ChatRoom;
            //there should already be a chatRoom for the given chatRoomID because we added the friends already
            //but still check
            if(chatRoom != nil){
                //check to see if the chatroom's last messageID equals the latest messageID
                if(chatRoom!.lastMessageID != Int16(messageID)){
                    //should return only the new chatRooms
                    chatRoom!.lastMessage = message;
                    chatRoom!.lastMessageID = Int16(messageID);
                    
                    let dateFormatter = DateFormatter();
                    dateFormatter.dateFormat = "h:mm:ss a, MM/dd/yyyy";
                    
                    let date = dateFormatter.date(from: messageDate);
                    chatRoom!.lastMessageTime = (date! as NSDate);
                    
                    if(senderID != user!.userID){
                        chatRoom!.readLastMessage = false;
                    }
                }
            }
            
        }
    }
    
}

extension MessagesPage{
    func loadRecentMessages(chatRoomID: Int, lastMessageID: Int, completion: @escaping ([Message]?)->()){
        print("load recent");
        let url = URL(string: "http://localhost:3000/loadMessages")!;
        var request = URLRequest(url: url);
        let body = "chatRoomID=\(chatRoomID)&lastMessageID=\(lastMessageID)";
        request.httpBody = body.data(using: .utf8);
        request.httpMethod = "POST";
        let task = URLSession.shared.dataTask(with: request) { (data, res, err) in
            if(err != nil){
                DispatchQueue.main.async {
                    print("error");
                    completion(nil);
                }
                return;
            }
            
            if(data != nil){
                let response = NSString(data: data!, encoding: 8) as String?;
                if(response == "none"){
                    //return nil
                    DispatchQueue.main.async {
                        print("response is none");
                        completion(nil);
                    }
                    
                }else{
                    do{
                        let jsonBody = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! NSDictionary;
                        let messages = jsonBody["messages"] as! NSArray;
//                        print(messages);
                        //messageID: row.MessageID, chatRoomID: row.ChatRoomID, senderID: row.SenderID, message: row.Message, date: row.Date
                        var newMessages = [Message]();
                        for message in messages{
                            let messageDictionary = message as! NSDictionary
                            let newMessage = Message(context: PersistenceManager.shared.context);
                            newMessage.messageID = messageDictionary["messageID"] as! Int16;
                            newMessage.chatRoomID = messageDictionary["chatRoomID"] as! Int16;
                            newMessage.senderID = messageDictionary["senderID"] as! Int16;
                            newMessage.message = (messageDictionary["message"] as! String);
                            newMessage.senderName = (messageDictionary["senderName"] as! String);
                            
                            let formatter = DateFormatter();
                            formatter.dateFormat = "h:mm:ss a, MM/dd/yyyy";
                            
                            let date = formatter.date(from: messageDictionary["date"] as! String)! as NSDate;
                            newMessage.date = date;
                            newMessages.append(newMessage);
                        }
                        
//                        print(messages);
                        DispatchQueue.main.async {
                            completion(newMessages);
                        }
                        
                        
                    }catch{
                        print(error);
                        DispatchQueue.main.async {
                            print("error parsing");
                            completion(nil);
                        }
                    }
                }
            }else{
                DispatchQueue.main.async {
                    print("data nil");
                    completion(nil);
                }
            }
        }
        task.resume();
    }
}

extension MessagesPage{
    func reloadItemsAt(indexPath: IndexPath){
        self.messagesList.reloadItems(at: [indexPath]);
    }
}
