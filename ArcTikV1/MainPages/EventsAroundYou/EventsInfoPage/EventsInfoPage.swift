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
    let cellData = ["Poker Tournament at my House! We gone have a really good time! Yeah!!!","Henderson, Nevada, United States","Hi everybody, as one of the best poker players on the planet, I am hosting a poker tournament within my home. The buy in is $60, and the prize pool is $5,000. We will only host if at least 90 people sign up! I hope that we can make this a really good time for everyone because I really do feel that poker is and should be considered a very fun and inviting atmosphere. Everyone should be sitting around, having a few drinks, and laughing their asses off. Hopefully everyone signs up! On another note, I'd like to say that I am truly blessed to be where I'm at today, there were and still could be so many different circumstances that would cause me to go bankrupt, but they don't and probably won't happen. That is what is good about America. You can be what you want and who you want. You can change your own life.","- Not Jason Koon \n- Able to play poker \n- Knows the game well\n- Not Phil Hellmuth \n- Yes Phil Hellmuth \n- Yes Tom Dwan \n- Not Andrew Robl \n - Not Elton Tsang \n - Not the president"];
    
    var descriptionIsExpanded = false;
    var requirementsIsExpanded = false;
    var estimatedFrameSize:CGSize?;
    
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
            collectionView?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 110, right: 0);
            setupBottomBarCover();
        }else{
            collectionView?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 80, right: 0);
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
        return 2;
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(section == 0){
            return 2;
        }
        
        return 3;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if(indexPath.section != 0){
            if(descriptionIsExpanded && indexPath.section == 1 && indexPath.item == 0){
                if let height = self.estimatedFrameSize?.height{
//                    print("yes height");
                    return CGSize(width: self.view.frame.width, height: height+60);
                }
//                print("not height");
                return CGSize(width: self.view.frame.width, height: 280);
                
            }
            
            if(indexPath.section == 1 && indexPath.item != 0){
                return CGSize(width: self.view.frame.width, height: 80);
            }
            
            return CGSize(width: self.view.frame.width, height: 160)
        }
        return CGSize(width: self.view.frame.width, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if(section == 0){
            return CGSize(width: self.view.frame.width, height: self.view.frame.height*(1/3));
        }else{
            return CGSize(width: self.view.frame.width, height: 50);
//            return CGSize(width: 0, height: 0 );
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
            if(indexPath.item == 0 && indexPath.section == 1){
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: descriptionCellReuse, for: indexPath) as! EventsInfoDescriptionCell
                cell.indexPath = indexPath;
                cell.delegate = self;
                if(indexPath.section == 1){
                    cell.setupText(description: cellData[2]);
                    cell.isExpanded = self.descriptionIsExpanded;
                }
//                else{
//                    cell.setupText(description: cellData[3]);
//                    cell.isExpanded = self.requirementsIsExpanded;
//                }
                return cell;
            }else{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: thingsToBringCellReuse, for: indexPath) as! EventsInfoThingsToBringCell;
                if(indexPath.section == 1 && indexPath.item == 1){
                    cell.setText(title: "Requirements");
                }
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
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(indexPath.section == 1 && indexPath.item == 1){
            let layout = UICollectionViewFlowLayout();
            let requirementsPage = EventsInfoRequirementsPage(collectionViewLayout: layout);
            let newNavigationController = UINavigationController(rootViewController: requirementsPage);
            newNavigationController.navigationBar.isTranslucent = false;
            newNavigationController.navigationBar.barTintColor = UIColor.white;
            newNavigationController.navigationBar.tintColor = UIColor.black;
            
            self.present(newNavigationController, animated: true, completion: nil);
//            navigationController?.pushViewController(requirementsPage, animated: true);
        }else if(indexPath.section == 1 && indexPath.item == 2){
            let layout = UICollectionViewFlowLayout();
            let thingsToBringPage = EventsInfoToBringPage(collectionViewLayout: layout);
            let newNavigationController = UINavigationController(rootViewController: thingsToBringPage);
            newNavigationController.navigationBar.isTranslucent = false;
            newNavigationController.navigationBar.barTintColor = UIColor.white;
            newNavigationController.navigationBar.tintColor = UIColor.black;
            self.present(newNavigationController, animated: true, completion: nil);
        }
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
//        print(indexPath);
        let cell = collectionView?.cellForItem(at: indexPath) as! EventsInfoDescriptionCell
        let size = CGSize(width: self.view.frame.width-20, height: .infinity)
        self.estimatedFrameSize = cell.descriptionTextView.sizeThatFits(size)
        
        if(descriptionIsExpanded){
            UIView.animate(withDuration: 0.3) {
                self.collectionView?.reloadItems(at: [indexPath]);
            }
            
        }
    }
    
    func seeMoreRequirements(indexPath: IndexPath){
        requirementsIsExpanded = true;
        if(requirementsIsExpanded){
            UIView.animate(withDuration: 0.3) {
                self.collectionView?.reloadItems(at: [indexPath]);
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
