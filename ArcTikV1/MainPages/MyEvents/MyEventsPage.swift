//
//  MyEvents.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/3/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

class MyEventsPage: UIViewController{
    
    var selector = UISegmentedControl(items: ["Applied","Hosting"]);
    
    var myEventsList: MyEventsCollectionView = {
        let layout = UICollectionViewFlowLayout();
        let myEventsList = MyEventsCollectionView(frame: .zero, collectionViewLayout: layout);
        return myEventsList;
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.view.backgroundColor = UIColor.veryLightGray;
        setupNavBar();
        setupMyEventsList();
    }
    
    fileprivate func setupNavBar(){
        selector.selectedSegmentIndex = 0;
        self.navigationItem.titleView = selector;
    }
    
    fileprivate func setupMyEventsList(){
        self.view.addSubview(myEventsList);
        myEventsList.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        myEventsList.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        myEventsList.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true;
        myEventsList.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true;
    }
}
