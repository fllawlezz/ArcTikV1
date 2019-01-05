//
//  Messages.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/3/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

class MessagesPage: UIViewController{
    
    var selector = UISegmentedControl(items: ["Direct","Group"]);
    
    var messagesList: MessagesCollectionView = {
        let layout = UICollectionViewFlowLayout();
        let messagesList = MessagesCollectionView(frame: .zero, collectionViewLayout: layout);
        return messagesList;
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.view.backgroundColor = UIColor.white;
        setupNavBar();
        setupMessagesList();
    }
    
    fileprivate func setupNavBar(){
        let composeButton = UIBarButtonItem(image: UIImage(named: "compose"), style: .plain, target: nil, action: nil);
        self.navigationItem.rightBarButtonItem = composeButton;
        
        selector.selectedSegmentIndex = 0;
        self.navigationItem.titleView = selector;
    }
    
    fileprivate func setupMessagesList(){
        self.view.addSubview(messagesList);
        messagesList.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        messagesList.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        messagesList.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true;
        messagesList.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true;
    }
    
}
