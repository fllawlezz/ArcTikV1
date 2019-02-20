//
//  LinkedList.swift
//  ArcTikV1
//
//  Created by Brandon In on 2/19/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import Foundation

public class List<T> {
    fileprivate var head: Node<T>?
    fileprivate var tail: Node<T>?
    
    var length: Int
    
    init(){
        self.length = 0;
        self.head = nil;
        self.tail = nil;
    }
    
    public func getHead()->Node<T>?{
        return head;
    }
    
    public func getTail()->Node<T>?{
        return tail;
    }
    
    public func getValue(n: Node<T>)->T{
        return n.value;
    }
    
    public func append(value: T){
        let tail = getTail();
        if(tail != nil){
            let newNode = Node(value: value);
            newNode.prevNode = tail;
            newNode.nextNode = nil;
            self.tail?.nextNode = newNode;
            
            self.tail = (newNode );
        }else{
            //tail == nil
            let newNode = Node(value: value);
            head = (newNode);
            self.tail = (newNode);
        }
        
        length+=1;
    }
    
    public func prepend(value: T){
        let head = getHead();
        if(head != nil){
            let newNode = Node(value: value);
            newNode.nextNode = self.head;
            newNode.prevNode = nil;
            self.head?.prevNode = newNode;
            self.head = (newNode );
        }else{
            let newNode = Node(value: value);
            self.head = newNode;
            self.tail = newNode;
        }
        
        length+=1;
    }
    
    public func swap(x: Node<T>, y: Node<T>){
        
//        let xPrev = x.prevNode;
//        let yNext = y.nextNode;
        
        let yPrev = y.prevNode;
        let xNext = x.nextNode;
        
        if(yPrev == nil){
            x.prevNode = nil;
            x.nextNode = y;
            self.head = x;
            
            y.prevNode = x;
            y.nextNode = xNext;
            
            if(xNext != nil){
                xNext?.prevNode = y;
            }
            
            return;
        }
        
        if(xNext == nil){
            y.nextNode = nil;
            y.prevNode = x;
            self.tail = y;
            
            x.nextNode = x;
            x.prevNode = yPrev;
            
            if(yPrev != nil){
                yPrev?.nextNode = x;
            }
            
            return;
        }
        
        yPrev?.nextNode = x;
        y.prevNode = x;
        y.nextNode = xNext;
        x.prevNode = yPrev;
        x.nextNode = y;
        xNext?.prevNode = y;
    }
    /*
     1. append
     2. prepend
     3. getValue
     4. isEmpty - returns true or false
     5. swap
     6. remove all
     */
    
    public func removeAll(){
        head = nil;
        tail = nil;
        
        length = 0;
    }
    
    public func printList(){
        var x = getHead();
        while(x != nil){
            let w = getValue(n: x!) as! ChatRoom;
            print("\(w.readLastMessage) ");
            x = x?.nextNode;
        }
    }
    
}

public class Node<T> {
    var value: T
    var prevNode: Node<T>?
    var nextNode: Node<T>?
    
    init(value: T){
        self.value = value;
    }
}
