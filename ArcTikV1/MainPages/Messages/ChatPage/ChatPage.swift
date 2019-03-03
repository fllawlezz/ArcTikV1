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
    var messages = [Message]();
    var chatRoomID: Int?;
    
    var chatRoom: ChatRoom?{
        didSet{
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
//        setupSocket();
        // have to sort messages by date
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
//        self.navigationItem.title = "Daniel Negreanu";
        var recieversString = "";
        print(recieverList.count);
        
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
        let cell = tableView.dequeueReusableCell(withIdentifier: messageCellReuse, for: indexPath) as! ChatCell;
        let message = messages[indexPath.item];
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
        if(messages.count > 0){
            return messages.count;
        }
        return 0;
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40;
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let currentDate = Date();
        let formatter = DateFormatter();
        formatter.dateFormat = "MM/dd/yyyy h:mm a";
        
        let dateString = formatter.string(from: currentDate);
        
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerCellReuse) as! ChatHeaderCell;
        header.setDateTitle(title: dateString);
        return header;
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
    }
    
    func sendMessage(message: String) {
        
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
            print("attempt");
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
                
                print("appending and reloading tableView");
                
                self.messages.append(newMessage);
                self.tableView.insertRows(at: [IndexPath(item: self.messages.count-1, section: 0)], with: UITableViewRowAnimation.right);
                
                print("success");
            }
        }else{
            //show error
        }
        
        
        //json body
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
                            let chatRoomID = Int(response);
                            self.chatRoomID = chatRoomID;
//                            print(chatRoomID);
                            completion(false);
                        }
                    }
                }
            }
            urlTask.resume();
        }//dispatchqueue.global
        
    }
    
}
