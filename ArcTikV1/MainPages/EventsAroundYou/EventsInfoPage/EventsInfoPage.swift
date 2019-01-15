//
//  EventsInfoPage.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/6/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

class EventsInfoPage: UICollectionViewController, UICollectionViewDelegateFlowLayout, EventsInfoHeaderDelegate, EventsInfoMainCellDelegate, EventsInfoDescriptionCellProtocol{

    var eventsInfoBottomBar: EventsInfoBottomBarView = {
        let eventsInfoBottomBar = EventsInfoBottomBarView();
        return eventsInfoBottomBar;
    }()
    
    var bottomBarCover: UIView = {
        let bottomBarCover = UIView();
        bottomBarCover.translatesAutoresizingMaskIntoConstraints = false;
        bottomBarCover.backgroundColor = UIColor.white;
        return bottomBarCover;
    }()
    
    let headerCellReuse = "EventsInfoReuseHeader";
    let sectionHeaderReuse = "EventsInfoSectionHeaderReuse";
    let eventsInfoCellReuse = "EventsInfoCellReuse";
    let titleCellReuse = "EventsInfoTitleCellReuse";
    let locationCellReuse = "EventsInfoLocationCellReuse";
    let descriptionCellReuse = "EventsInfoDescriptionCellReuse";
    let thingsToBringCellReuse = "EventsInfoThingsToBringReuse";
    
    let headerTitles = ["Description","Requirements"];
    let cellData = ["Poker Tournament at my House! We gone have a really good time! Yeah!!!","Henderson, Nevada, United States","Hi everybody, as one of the best poker players on the planet, I am hosting a poker tournament within my home. The buy in is $60, and the prize pool is $5,000. We will only host if at least 90 people sign up!","- Not Jason Koon \n- Able to play poker \n- Knows the game well\n- Not Phil Hellmuth \n- Yes Phil Hellmuth \n- Yes Tom Dwan \n- Not Andrew Robl \n - Not Elton Tsang \n - Not the president"];
    var descriptionIsExpanded = false;
    var requirementsIsExpanded = false;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.collectionView?.backgroundColor = UIColor.white;
        collectionView?.delegate = self;
        collectionView?.dataSource = self;
        collectionView?.showsVerticalScrollIndicator = false;
        collectionView?.register(EventsInfoMainCell.self, forCellWithReuseIdentifier: eventsInfoCellReuse);
        self.collectionView?.register(EventsInfoHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerCellReuse);
        collectionView?.register(EventsInfoSectionHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: sectionHeaderReuse);
        collectionView?.register(EventInfoTitleCell.self, forCellWithReuseIdentifier: titleCellReuse);
        collectionView?.register(EventsInfoLocationCell.self, forCellWithReuseIdentifier: locationCellReuse);
        collectionView?.register(EventsInfoDescriptionCell.self, forCellWithReuseIdentifier: descriptionCellReuse);
        collectionView?.register(EventsInfoThingsToBringCell.self, forCellWithReuseIdentifier: thingsToBringCellReuse);
        collectionView?.contentInsetAdjustmentBehavior = .never;
        if(UIScreenHeight! >= 812){
            collectionView?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 120, right: 0);
            setupBottomBarCover();
        }else{
            collectionView?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 90, right: 0);
        }
        
        setupEventsBottomBar();
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent;
    }
    
    fileprivate func setupEventsBottomBar(){
        self.view.addSubview(eventsInfoBottomBar);
        eventsInfoBottomBar.anchor(left: self.view.leftAnchor, right: self.view.rightAnchor, top: nil, bottom: self.view.safeAreaLayoutGuide.bottomAnchor, constantLeft: 0, constantRight: 0, constantTop: 0, constantBottom: 0, width: 0, height: 80);
    }
    
    fileprivate func setupBottomBarCover(){
        self.view.addSubview(bottomBarCover);
        bottomBarCover.anchor(left: self.view.leftAnchor, right: self.view.rightAnchor, top: nil, bottom: self.view.bottomAnchor, constantLeft: 0, constantRight: 0, constantTop: 0, constantBottom: 0, width: 0, height: 60);
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3;
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(section == 0){
            return 2;
        }
        
        if(section == 2){
            return 2;
        }
        
        return 1;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if(indexPath.section != 0){
            if(descriptionIsExpanded && indexPath.section == 1){
                return CGSize(width: self.view.frame.width, height: 250);
            }
            
            if(requirementsIsExpanded && indexPath.section == 2 && indexPath.item == 0){
                return CGSize(width: self.view.frame.width, height: 250);
            }
            
            if(indexPath.section == 2 && indexPath.item == 1){
                return CGSize(width: self.view.frame.width, height: 50);
            }
            
            return CGSize(width: self.view.frame.width, height: 140)
        }
        return CGSize(width: self.view.frame.width, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if(section == 0){
            return CGSize(width: self.view.frame.width, height: self.view.frame.height*(1/3));
        }else{
            return CGSize(width: self.view.frame.width, height: 50);
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(indexPath.section == 0){
            if(indexPath.item == 0){
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: titleCellReuse, for: indexPath) as! EventInfoTitleCell
                cell.setTitle(title: cellData[indexPath.item]);
                return cell;
            }else{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: locationCellReuse, for: indexPath) as! EventsInfoLocationCell
                cell.setLocation(location: cellData[indexPath.item]);
                return cell;
            }
        }else{
            if(indexPath.item == 0){
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: descriptionCellReuse, for: indexPath) as! EventsInfoDescriptionCell
                cell.indexPath = indexPath;
                cell.delegate = self;
                if(indexPath.section == 1){
                    cell.setupText(description: cellData[2]);
                    cell.isExpanded = self.descriptionIsExpanded;
                }else{
                    cell.setupText(description: cellData[3]);
                    cell.isExpanded = self.requirementsIsExpanded;
                }
                return cell;
            }else{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: thingsToBringCellReuse, for: indexPath) as! EventsInfoThingsToBringCell;
                return cell;
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if(indexPath.section == 0){
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerCellReuse, for: indexPath) as! EventsInfoHeader;
            header.delegate = self;
            return header;
        }else{
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: sectionHeaderReuse, for: indexPath) as! EventsInfoSectionHeader;
            header.setTitle(title: headerTitles[indexPath.section-1]);
            return header;
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
}

extension EventsInfoPage{
    func handleBack() {
        self.navigationController?.popViewController(animated: true);
    }
    
    func handleApplied(){
        let alert = UIAlertController(title: "Applied!", message: "You have applied to this event! We will send you a notifiation if you are accepted!", preferredStyle: .alert);
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            self.navigationController?.popViewController(animated: true);
        }))
        self.present(alert, animated: true, completion: nil);
    }
    
    func seeMoreDescription(indexPath: IndexPath) {
        descriptionIsExpanded = true;
        if(descriptionIsExpanded){
            print(indexPath);
//            let cell = self.collectionView?.cellForItem(at: indexPath) as! EventsInfoDescriptionCell;
            UIView.animate(withDuration: 0.3) {
                self.collectionView?.reloadItems(at: [indexPath]);
            }
            
        }
    }
    
    func seeMoreRequirements(indexPath: IndexPath){
        requirementsIsExpanded = true;
        if(requirementsIsExpanded){
            print(indexPath);
            UIView.animate(withDuration: 0.3) {
                self.collectionView?.reloadItems(at: [indexPath]);
//                print("expandedRequirements");
            }
        }
    }
    
    
    
}

extension EventsInfoPage{
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true;
    }
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false;
    }
}
