//
//  MessagesCollectionView.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/3/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

protocol MessagesCollectionViewDelegate{
    func handleSelectedCell(chatRoom: ChatRoom, indexPath: IndexPath);
    func endRefreshing();
}

class MessagesCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    let messageReuse = "messageReuse";
    let emptyMessageReuse = "emptyMessageReuse";
    
    var chatRoomsDictionary: NSMutableDictionary?{
        didSet{
            self.chatRooms.removeAll();
            self.transferToArray();
            self.reloadData();
        }
    }
    
    var chatRooms = [ChatRoom]();
    
    var chatRoomsUnread = [ChatRoom]();
    var chatRoomsRead = [ChatRoom]();
    
    var messageViewDelegate: MessagesCollectionViewDelegate?;
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout);
        
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = UIColor.white;
        self.alwaysBounceVertical = true;
        self.register(MessagesCollectionViewCell.self, forCellWithReuseIdentifier: messageReuse);
        self.register(MessagesEmptyCell.self, forCellWithReuseIdentifier: emptyMessageReuse);
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(chatRooms.count > 0){
            return chatRooms.count;
        }
        return 1;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(chatRooms.count > 0){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: messageReuse, for: indexPath) as! MessagesCollectionViewCell
            cell.chatRoom = chatRooms[indexPath.item];
            return cell;
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: emptyMessageReuse, for: indexPath) as! MessagesEmptyCell
        return cell;
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width, height: 100);
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        messageViewDelegate?.handleSelectedCell(chatRoom: chatRooms[indexPath.item], indexPath: indexPath);
    }
    
    @objc func reloadMessages(){
        DispatchQueue.global().async {
            self.chatRooms.removeAll();
            self.transferToArray();
            DispatchQueue.main.async {
                self.reloadData();
                self.messageViewDelegate?.endRefreshing();
            }
        }
        
        
//        self.messageViewDelegate?.endRefreshing();
    }
    
    func transferToArray(){
        /*
         1. append all messageIDs to an array
         2. perform quicksort on thme,
         3. append each chatRoom in the order that the message id matches
         */
        
        for keyValue in chatRoomsDictionary!{
            let chatRoom = keyValue.value as! ChatRoom;
            
            self.chatRooms.append(chatRoom);
        }
        quickSort(chatRooms: &chatRooms, low: 0, high: chatRooms.count-1);//sorts array in order of message id
        //need to place all the unread at the front and all the read at the bottom
        self.chatRooms.reverse();//reverses everythign so its in descending order, with highest messageIDs at the front and the lwoest at the back
        //
        sortReadUnread(chatRooms: chatRooms);
        //sort array by chatRoomID
        
    }
    
    //go through every single node and see if the previous node is unread
    func sortReadUnread(chatRooms: [ChatRoom]){
        let list = List<ChatRoom>();
        for chatRoom in chatRooms{
            list.append(value: chatRoom);
        }
        listToArray(L: list);
        
    }
    
    func listToArray(L: List<ChatRoom>){
        //order of list is highest to lowest
        self.chatRoomsUnread.removeAll();
        self.chatRoomsRead.removeAll();
        
        var n = L.getHead();
        while(n != nil){
            let chatRoom = L.getValue(n: n!);
            
            if(chatRoom.readLastMessage){//read last message
                self.chatRoomsRead.append(chatRoom);
            }else{//did not read last message
                self.chatRoomsUnread.append(chatRoom);
            }
            
            n = n?.nextNode;
        }
        
        self.chatRooms.removeAll();
        self.chatRooms.append(contentsOf: chatRoomsUnread);
        self.chatRooms.append(contentsOf: chatRoomsRead);
    }
    
    func reloadTableData(){
        self.chatRooms.removeAll();
        self.transferToArray();
        self.reloadData();
    }
}


func quickSort(chatRooms: inout [ChatRoom], low: Int, high: Int){//takes in an array, low(starting index), high(ending index
    if(low < high){
        let pi = partition(chatRooms: &chatRooms, low: low, high: high);
        
        quickSort(chatRooms: &chatRooms, low: low, high: pi-1);
        quickSort(chatRooms: &chatRooms, low: pi+1, high: high);
        
    }
}

func partition(chatRooms: inout [ChatRoom], low: Int, high: Int)->Int{
    let pivot = chatRooms[high].lastMessageID;
    var i = low - 1;
    var count = 0;
    while(count <= high-1){
        if(chatRooms[count].lastMessageID<=pivot){
            i+=1;
            let temp = chatRooms[i];
            chatRooms[i] = chatRooms[count];
            chatRooms[count] = temp;
        }
        
        count+=1;
    }
    let tempChatRoom = chatRooms[i+1];
    chatRooms[i+1] = chatRooms[high];
    chatRooms[high] = tempChatRoom;
    return (i+1);
}
