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
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.view.backgroundColor = UIColor.white;
        self.delegate = self;
        self.tabBar.isTranslucent = false;
        self.tabBar.tintColor = UIColor.black;
        
        setupEventsAroundYou();
        
        viewControllers = [eventsAroundYouController!];
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
    
}
