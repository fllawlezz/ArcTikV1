//
//  EventsAroundYou.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/2/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

class EventsAroundYou: UIViewController{
    
    var selector = UISegmentedControl(items: ["Public","Private"])
    
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
        let filtersButton = UIBarButtonItem(title: "Filters", style: .plain, target: nil, action: nil);
        let plusButton = UIBarButtonItem(image: UIImage(named: "whitePlus"), style: .plain, target: nil, action: nil);
        
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
    }
    
    
    
}
