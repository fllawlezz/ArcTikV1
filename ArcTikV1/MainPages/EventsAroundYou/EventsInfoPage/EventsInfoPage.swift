//
//  EventsInfoPage.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/6/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class EventsInfoPage: UICollectionViewController, UICollectionViewDelegateFlowLayout, EventsInfoHeaderDelegate, EventsInfoMainCellDelegate, EventsInfoDescriptionCellProtocol, EventsInfoBottomBarDelegate, NVActivityIndicatorViewable{

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
    
    var descriptionIsExpanded = false;
    var requirementsIsExpanded = false;
    var estimatedFrameSize:CGSize?;
    var event: Event?{
        didSet{
//            self.collectionView?.reloadData();
        }
    }
    
    
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
        
        if(event!.eventDescription!.count < 150){
            self.descriptionIsExpanded = true;
        }
        
        if(UIScreenHeight! >= 812){
            collectionView?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 110, right: 0);
            setupBottomBarCover();
        }else{
            collectionView?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 80, right: 0);
        }
        
        setupEventsBottomBar();
        setBottomBarText();
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent;
    }
    
    fileprivate func setupEventsBottomBar(){
        self.view.addSubview(eventsInfoBottomBar);
        eventsInfoBottomBar.anchor(left: self.view.leftAnchor, right: self.view.rightAnchor, top: nil, bottom: self.view.safeAreaLayoutGuide.bottomAnchor, constantLeft: 0, constantRight: 0, constantTop: 0, constantBottom: 0, width: 0, height: 80);
        eventsInfoBottomBar.delegate = self;
        if(event!.appliedToEvent! == 1){
            eventsInfoBottomBar.applyButton.setTitle("Applied", for: .normal);
            eventsInfoBottomBar.applyButton.setTitleColor(.appBlue, for: .normal);
            eventsInfoBottomBar.applyButton.backgroundColor = UIColor.veryLightGray;
            eventsInfoBottomBar.applyButton.layer.borderColor = UIColor.darkText.cgColor;
            eventsInfoBottomBar.applyButton.layer.borderWidth = 1;
            eventsInfoBottomBar.applyButton.isEnabled = false;
        }
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
            if(descriptionIsExpanded && indexPath.section == 1 && indexPath.item == 0 && event!.eventDescription!.count > 150){
                if let height = self.estimatedFrameSize?.height{
//                    print("yes height");
                    return CGSize(width: self.view.frame.width, height: height+60);
                }
                
                return CGSize(width: self.view.frame.width, height: 280);
                
            }
            
            if(indexPath.section == 1 && indexPath.item == 0 && event!.eventDescription!.count < 150){
                return CGSize(width: self.view.frame.width, height: 100);
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
//                cell.setTitle(title: cellData[indexPath.item]);
                cell.setTitle(title: event!.eventTitle!);
                return cell;
            }else{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: locationCellReuse, for: indexPath) as! EventsInfoLocationCell
//                cell.setLocation(location: cellData[indexPath.item]);
                cell.setLocation(location: "\(self.event!.city!), CA \(self.event!.country!)")
                return cell;
            }
        }else{
            if(indexPath.item == 0 && indexPath.section == 1){
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: descriptionCellReuse, for: indexPath) as! EventsInfoDescriptionCell
                cell.indexPath = indexPath;
                cell.delegate = self;
                if(indexPath.section == 1){
                    cell.setupText(description: self.event!.eventDescription!);
                    cell.isExpanded = self.descriptionIsExpanded;
                }
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
            if(self.event!.eventImages!.count > 0){
                header.setImage(image: self.event!.eventImages![0]);
            }else{
                header.setImage(image: #imageLiteral(resourceName: "camera"));
            }
            
            header.setName(name: self.event!.posterName!);
            header.setDateAndTime(date: self.event!.startDate!, time: self.event!.startTime!);
            header.setProfileImage(image: self.event!.posterImage);
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
            requirementsPage.requirementsList = self.event!.requirements!;
            let newNavigationController = UINavigationController(rootViewController: requirementsPage);
            newNavigationController.navigationBar.isTranslucent = false;
            newNavigationController.navigationBar.barTintColor = UIColor.white;
            newNavigationController.navigationBar.tintColor = UIColor.black;
            
            self.present(newNavigationController, animated: true, completion: nil);
//            navigationController?.pushViewController(requirementsPage, animated: true);
        }else if(indexPath.section == 1 && indexPath.item == 2){
            let layout = UICollectionViewFlowLayout();
            let thingsToBringPage = EventsInfoToBringPage(collectionViewLayout: layout);
            thingsToBringPage.thingsToBring = self.event!.thingsToBring!;
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
    
    func setBottomBarText(){
        self.eventsInfoBottomBar.setCost(cost: event!.price!);
        self.eventsInfoBottomBar.setPeople(currentPeople: self.event!.currentPeople!, people: self.event!.people!);
    }
    
}

extension EventsInfoPage{
    func showLoadingView(){
        let size = CGSize(width: 50, height: 50)
        self.startAnimating(size, message: "Loading", messageFont: UIFont.montserratSemiBold(fontSize: 14), type: NVActivityIndicatorType.circleStrokeSpin, color: UIColor.white, padding: 0, displayTimeThreshold: 20, minimumDisplayTime: 1, backgroundColor: UIColor.black.withAlphaComponent(0.5), textColor: UIColor.white, fadeInAnimation: nil);
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true;
    }
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false;
    }
}

extension EventsInfoPage{
    func handlePressedApply() {
        //handle pressed apply
        self.showLoadingView();
//        print("apply");
        if let event = self.event{
            applyToEvent(eventID: event.eventID!, userID: user!.userID, hosterID: event.hosterID!) { (bool) in
                if(bool){
                    self.stopAnimating();
                    self.showServerAlert();
                }else{
                    self.stopAnimating();
                    self.showAppliedSuccessful();
                }
            }
        }
        
    }
    
    func applyToEvent(eventID: Int, userID: Int, hosterID: Int, completion: @escaping (Bool)->()){
        DispatchQueue.global(qos: .default).async{
            let url = URL(string: "http://localhost:3000/applyToEvent")!;
            //        let url = URL(string: "http://arctikllc.com:3000/startCreateEvent")!;
            var request = URLRequest(url: url);
            let requestBody = "eventID=\(eventID)&userID=\(userID)&hosterID=\(hosterID)"
            request.httpMethod = "POST";
            request.httpBody = requestBody.data(using: .utf8);
            request.timeoutInterval = 10;
            let task = URLSession.shared.dataTask(with: request) { (data, res, err) in
                if(err != nil){
                    DispatchQueue.main.async {
                        completion(true);
                    }
                }else{
                    if(data != nil){
                        let response = NSString(data: data!, encoding: 8)! as String
                        DispatchQueue.main.async {
                            if(response == "success"){
                                print("success");
                                completion(false);
                            }else{
                                completion(true);
                            }
                            
                        }
                    }else{
                        DispatchQueue.main.async {
                            completion(true);
                        }
                    }
                }
            }
            task.resume();
        }
    }
    
    fileprivate func showServerAlert(){
        let alert = UIAlertController(title: "Oops!", message: "There was a problem submitting your title! Try again later!", preferredStyle: .alert);
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            self.navigationController?.popViewController(animated: true);
        }))
        self.present(alert, animated: true, completion: nil);
    }
    
    fileprivate func showAppliedSuccessful(){
        let alert = UIAlertController(title: "Applied!", message: "You have applied to this event! We have already sent a message to the hoster for you! Hope you get accepted!", preferredStyle: .alert);
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            self.navigationController?.popViewController(animated: true);
        }))
        self.present(alert, animated: true, completion: nil);
    }
}
