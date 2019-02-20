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
        sortReadUnread(chatRooms: chatRooms);
        //sort array by chatRoomID
        
    }
    
    //go through every single node and see if the previous node is unread
    func sortReadUnread(chatRooms: [ChatRoom]){
        let list = List<ChatRoom>();
        for chatRoom in chatRooms{
            list.append(value: chatRoom);
        }
//        list.printList();
        //append each one in order, so its highest messageID at top
        //go down the list and swap nodes if the previous is unread
        let x = list.getHead();
        sortNodes(x: x!, L: list);
//        list.printList();
        //translate the list into the array
        self.chatRooms.removeAll();
        listToArray(L: list);
        
    }
    
    func sortNodes(x: Node<ChatRoom>?, L: List<ChatRoom>){
        var w = x;//w starts at the head
        while(w != nil){
            let tempNext = w?.nextNode;
            let y = w?.prevNode;
            
//            let yValue = y?.value;//prev node value
//            let wValue = w?.value;
            
//            if(y != nil){
//                if(!yValue!.readLastMessage){
//                    print("last message was read");
//                    return;
//                }
                swapReadNodes(prevNode: y, currentNode: w!, L: L);
                
//                if(yValue!.readLastMessage && !wValue!.readLastMessage){//if y is read, then swap
////                    let yPrev = y?.prevNode;
//                    L.swap(x: w!, y: y!);
//                    sortNodes(x: w!, L: L);
//                }
//            }
            
            w = tempNext;
        }
    }
    
    //keep swapping until w.prevNode.value != 1;
    func swapReadNodes(prevNode: Node<ChatRoom>?, currentNode: Node<ChatRoom>, L: List<ChatRoom>){
        if(prevNode != nil){
            if(prevNode!.value.readLastMessage && !currentNode.value.readLastMessage){
                L.swap(x: currentNode, y: prevNode!);
                let xPrev = currentNode.prevNode;
                swapReadNodes(prevNode: xPrev, currentNode: currentNode, L: L);//keeps going down until it finds either a node who's value is unread, or it falls off (its the only unread message)
            }
            //gets here when the prevNode.value.readLastMessage is unread
        }
        //if nil, then its at the front
    }
    
    func listToArray(L: List<ChatRoom>){
        var n = L.getHead();
        while(n != nil){
            self.chatRooms.append(L.getValue(n: n!));
            n = n?.nextNode;
        }
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
