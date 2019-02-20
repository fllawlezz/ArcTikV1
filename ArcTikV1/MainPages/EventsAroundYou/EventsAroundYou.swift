//
//  EventsAroundYou.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/2/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class EventsAroundYou: UIViewController, EventsAroundYouCollectionViewDelegate,FiltersPageDelegate, NVActivityIndicatorViewable{

    var selector = UISegmentedControl(items: ["Public","Private"]);
    
    var events:[Event]?{
        didSet{
            if(events != nil){
                self.eventsAroundYouList.events = self.events!;
            }
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
        filtersPage.delegate = self;
        
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
        
    }
    
    func handleToEventsInfoPage(event: Event) {
        
        self.stopAnimating();
        
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

extension EventsAroundYou{
    func handleSearchFilters(events: [Event]) {
        self.stopAnimating();
        self.events = events;
        self.eventsAroundYouList.reloadData();

    }
    
    func showLoading(){
        self.showLoadingView();
    }
    
    func handleShowError(){
        self.stopAnimating();
        self.showServerAlert();
    }
    
    func showLoadingView(){
        let size = CGSize(width: 50, height: 50)
        self.startAnimating(size, message: "Loading", messageFont: UIFont.montserratSemiBold(fontSize: 14), type: NVActivityIndicatorType.circleStrokeSpin, color: UIColor.white, padding: 0, displayTimeThreshold: 20, minimumDisplayTime: 1, backgroundColor: UIColor.black.withAlphaComponent(0.5), textColor: UIColor.white, fadeInAnimation: nil);
    }
    
    fileprivate func showServerAlert(){
        let alert = UIAlertController(title: "Oops!", message: "There was a problem loading the event! Try again later!", preferredStyle: .alert);
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
        }))
        self.present(alert, animated: true, completion: nil);
    }
}
