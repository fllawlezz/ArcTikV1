//
//  EventsAroundYou.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/2/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

class EventsAroundYou: UIViewController, EventsAroundYouCollectionViewDelegate{
    
    var selector = UISegmentedControl(items: ["Public","Private"]);
    
    var events:[Event]?{
        didSet{
            self.eventsAroundYouList.events = self.events!;
        }
    }
    
    var eventsAroundYouList: EventsAroundYouCollectionView = {
        let layout = UICollectionViewFlowLayout();
        let eventsAroundYouList = EventsAroundYouCollectionView(frame: .zero, collectionViewLayout: layout);
        return eventsAroundYouList;
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.view.backgroundColor = UIColor.veryLightGray;
        
        setupNavBar();
        setupCollectionView();
    }
    
    fileprivate func setupNavBar(){
        let filtersButton = UIBarButtonItem(title: "Filters", style: .plain, target: self, action: #selector(self.handleFiltersPressed));
        let plusButton = UIBarButtonItem(image: UIImage(named: "whitePlus"), style: .plain, target: self, action: #selector(self.handleCreateEvent));
        
        selector.selectedSegmentIndex = 0;
        
        self.navigationItem.leftBarButtonItem = filtersButton;
        self.navigationItem.rightBarButtonItem = plusButton;
        self.navigationItem.titleView = selector;
    }
    
    fileprivate func setupCollectionView(){
        self.view.addSubview(eventsAroundYouList);
        eventsAroundYouList.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        eventsAroundYouList.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        eventsAroundYouList.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true;
        eventsAroundYouList.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true;
        
        eventsAroundYouList.eventsAroundYouDelegate = self;
    }
    
    
    
}

extension EventsAroundYou{
    @objc func handleFiltersPressed(){
        let layout = UICollectionViewFlowLayout();
        let filtersPage = MainFiltersPage(collectionViewLayout: layout)
//        let filtersPage = FiltersPage();
        
        let filtersNavigationController = UINavigationController(rootViewController: filtersPage);
        filtersNavigationController.navigationBar.tintColor = UIColor.white;
        filtersNavigationController.navigationBar.barTintColor = UIColor.appBlue;
        filtersNavigationController.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: UIFont.montserratSemiBold(fontSize: 18)];
        
        self.present(filtersNavigationController, animated: true, completion: nil);
    }
    
    @objc func handleCreateEvent(){
        let layout = UICollectionViewFlowLayout();
//        let createEventPage = CreateEventPage(collectionViewLayout: layout);
        let createdEventsPage = OverviewPage(collectionViewLayout: layout);
        createdEventsPage.hidesBottomBarWhenPushed = true;
        self.navigationController?.pushViewController(createdEventsPage, animated: true);
        
//        let navigationController = UINavigationController(rootViewController: createdEventsPage);
//        navigationController.navigationBar.isTranslucent = false;
//        navigationController.navigationBar.barStyle = .blackTranslucent;
//        navigationController.navigationBar.tintColor = UIColor.white;
//        navigationController.navigationBar.barTintColor = UIColor.appBlue;
//        self.present(navigationController, animated: true, completion: nil);
    }
    
    func handleToEventsInfoPage(event: Event) {
        let layout = StretchyHeaderLayout();
        let eventsInfo = EventsInfoPage(collectionViewLayout: layout);
        eventsInfo.event = event;
        eventsInfo.hidesBottomBarWhenPushed = true;
        navigationController?.navigationBar.barStyle = UIBarStyle.blackTranslucent;
        self.navigationController?.pushViewController(eventsInfo, animated: true);
    }
    
    func handleProfileImagePressed(){
        let alert = UIAlertController(title: "View profile?", message: "Yes", preferredStyle: .alert);
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil));
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: nil));
        self.present(alert, animated: true, completion: nil);
    }
}
