//
//  CustomTabBar.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/2/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

class CustomTabBar: UITabBarController, UITabBarControllerDelegate{
    
    var eventsAroundYouController: UINavigationController?
    var messagesController: UINavigationController?;
    var myEventsController: UINavigationController?;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.view.backgroundColor = UIColor.white;
        self.delegate = self;
        self.tabBar.isTranslucent = false;
        self.tabBar.tintColor = UIColor.black;
        
        setupEventsAroundYou();
        setupMessages();
        setupMyEvents();
        
        viewControllers = [eventsAroundYouController!, messagesController!, myEventsController!];
    }
    
    func setupEventsAroundYou(){
        let eventsAroundYouPage = EventsAroundYou();
        
        eventsAroundYouController = UINavigationController(rootViewController: eventsAroundYouPage);
        eventsAroundYouController?.navigationBar.isTranslucent = false;
        eventsAroundYouController?.navigationBar.barTintColor = UIColor.appBlue;
        eventsAroundYouController?.navigationBar.tintColor = UIColor.white;
        eventsAroundYouController?.title = "Events";
        eventsAroundYouController?.tabBarItem.image = UIImage(named: "events");
    }
    
    fileprivate func setupMessages(){
        let messagesPage = MessagesPage();
        
        messagesController = UINavigationController(rootViewController: messagesPage);
        messagesController?.navigationBar.isTranslucent = false;
        messagesController?.navigationBar.barTintColor = UIColor.appBlue;
        messagesController?.navigationBar.tintColor = UIColor.white;
        messagesController?.title = "Messages";
        messagesController?.tabBarItem.image = UIImage(named: "chatRoomTab");
        
    }
    
    fileprivate func setupMyEvents(){
        let myEventsPage = MyEventsPage();
        
        myEventsController = UINavigationController(rootViewController: myEventsPage);
        myEventsController?.navigationBar.isTranslucent = false;
        myEventsController?.navigationBar.barTintColor = UIColor.appBlue;
        myEventsController?.navigationBar.tintColor = UIColor.white;
        myEventsController?.title = "My Events";
        myEventsController?.tabBarItem.image = UIImage(named: "applied");
    }
    
}
