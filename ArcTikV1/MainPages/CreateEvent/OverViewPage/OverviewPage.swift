//
//  CreatedEventsPage.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/17/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit
import CoreData
import NVActivityIndicatorView

let dismissCreateEventPage = "DismissCreatedEventPage";
let reloadOverViewPage = "ReloadOverViewPage";
let overviewPageUpdateIndexPath = "OverViewPageUpdateIndexPath";

class OverviewPage: UICollectionViewController, UICollectionViewDelegateFlowLayout, NVActivityIndicatorViewable, CreatedEventsInProgressCellDelegate{
    
    let titleHeader = "CreatedEventsTitleHeaderReuse";
    let sectionHeader = "CreatedEventsSectionHeader";
    let cellReuse = "CreatedEventsCellReuse";
    let createNewEventReuse = "CreatedEventsNewEventCellReuse";
    
    var myEventsInProgress = [EventInProgress]();
    let dispatch = DispatchGroup();
    var eventID: Int?;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.collectionView?.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 20, right: 0);
        self.collectionView?.backgroundColor = UIColor.superLightGray;
        collectionView?.register(CreatedEventsInProgressCell.self, forCellWithReuseIdentifier: cellReuse);
        collectionView?.register(CreatedEventsNewEventCell.self, forCellWithReuseIdentifier: createNewEventReuse);
        collectionView?.register(CreatedEventsMainTitleHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: titleHeader);
        collectionView?.register(CreatedEventSectionHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: sectionHeader)
        setupNavBar();
        setupObservers();
        getEventsInProgress();
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self);
    }
    
    fileprivate func setupObservers(){
        let dismissName = Notification.Name(rawValue: dismissCreateEventPage);
        NotificationCenter.default.addObserver(self, selector: #selector(self.dismissView(notification:)), name: dismissName, object: nil);
        
        let reloadName = Notification.Name(rawValue: reloadOverViewPage);
        NotificationCenter.default.addObserver(self, selector: #selector(self.reloadCollectionView), name: reloadName, object: nil);
    }
    
    @objc func dismissView(notification: NSNotification){
        /*
         0. get info from notification, holds image names
         1. create new hosted event
         2. save new hosted event
         3. remove in progress event from collection view
         4. delete in progress event
         */
        let removeIndexPath = getIndexToRemove(eventID: Int(currentEventInProgress!.eventID));
        if(removeIndexPath != nil){
            self.myEventsInProgress.remove(at: removeIndexPath!.item);
//            self.collectionView?.deleteItems(at: [removeIndexPath!]);
            self.collectionView?.reloadData();
        }
        PersistenceManager.shared.context.delete(currentEventInProgress!);//class is a reference type not a value type, so we are deleting the object
        PersistenceManager.shared.save();
        currentEventInProgress = nil;
        
        
        self.dismiss(animated: true, completion: nil);
    }
    
    func getIndexToRemove(eventID: Int) -> IndexPath?{
        if(currentEventInProgress != nil){
            var count = 0;
            while(count < myEventsInProgress.count){
                let eventCompare = myEventsInProgress[count];
                if(eventCompare.eventID == eventID){
                    return IndexPath(item: count, section: 1);
                }
                count+=1;
            }
        }
        
        return nil;
    }
    
    fileprivate func setupNavBar(){
        let clearButton = UIBarButtonItem(image: UIImage(named: "clearWhiteNav"), style: .plain, target: self, action: #selector(self.handleClearPressed));
        
        let plusButton = UIBarButtonItem(image: UIImage(named: "whitePlus"), style: .plain, target: self, action: #selector(self.handleCreateEvent));
        
        self.navigationItem.leftBarButtonItem = clearButton;
        self.navigationItem.rightBarButtonItem = plusButton;
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(indexPath.section == 1){
            if(indexPath.item < myEventsInProgress.count){
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuse, for: indexPath) as! CreatedEventsInProgressCell;
//                cell.setTitle(title: "Poker game at my place");
                let eventInProgress = myEventsInProgress[indexPath.item];
                cell.eventID = Int(eventInProgress.eventID);
                cell.indexPath = indexPath;
                cell.delegate = self;
                
                if(eventInProgress.title != nil){
                    cell.setTitle(title: eventInProgress.title!);
                }else{
                    cell.setTitle(title: "Event title goes here");
                }
                
                cell.setSteps(stepNumber: Int(eventInProgress.step));
                
                return cell;
            }else{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: createNewEventReuse, for: indexPath) as! CreatedEventsNewEventCell;
                return cell;
            }
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuse, for: indexPath) as! CreatedEventsInProgressCell;
        return cell;
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2;
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(section == 0){
            return 0;
        }
        if(section == 1){
            return self.myEventsInProgress.count+1;
        }
        
        return 0;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if(indexPath.section == 1 && indexPath.item < myEventsInProgress.count){
            return CGSize(width: self.view.frame.width-40, height: 100);
            
        }
        return CGSize(width: self.view.frame.width-40, height: 40);
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 50);
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if(indexPath.section == 0){
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: titleHeader, for: indexPath) as! CreatedEventsMainTitleHeader;
            header.setTitle(title: "Events");
            return header;
        }else{
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: sectionHeader, for: indexPath) as! CreatedEventSectionHeader;
            header.setTitle(title: "In Progress");
            return header;
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        if(indexPath.item < myEventsInProgress.count){
            let event = self.myEventsInProgress[indexPath.item]
            currentEventInProgress = event;
            //load event
            loadEventCreator();
        }else{
            //MARK: Set current Event
            
                self.handleCreateEvent();
        }
    }
    
    func getEventsInProgress(){
        let eventsInProgress = PersistenceManager.shared.fetch(EventInProgress.self);
        if(eventsInProgress.count > 0){
            myEventsInProgress = eventsInProgress;
        }else{
            print("none");
        }
    }
    
}

extension OverviewPage{
    @objc func handleClearPressed(){
        self.navigationController?.popViewController(animated: true);
    }
    
    @objc func reloadCollectionView(){
        
        getEventsInProgress();
        self.collectionView?.reloadData();
    }
    
    @objc func handleCreateEvent(){
        if(myEventsInProgress.count < 5){
            currentEventInProgress = nil;
            self.stopAnimating();
            loadEventCreator();
        }else{
            self.showErrorAlertCreatingEvent();
        }
    }
    
    func loadEventCreator(){
        let layout = UICollectionViewFlowLayout();
        let createEventPage = CreateEventPage(collectionViewLayout: layout);
        
        let navigationController = UINavigationController(rootViewController: createEventPage);
        navigationController.navigationBar.isTranslucent = false;
        navigationController.navigationBar.barStyle = .blackTranslucent;
        navigationController.navigationBar.tintColor = UIColor.white;
        navigationController.navigationBar.barTintColor = UIColor.appBlue;
        self.present(navigationController, animated: true, completion: nil);
    }
    
    func showLoadingView(){
        let size = CGSize(width: 50, height: 50)
        self.startAnimating(size, message: "Loading", messageFont: UIFont.montserratSemiBold(fontSize: 14), type: NVActivityIndicatorType.circleStrokeSpin, color: UIColor.white, padding: 0, displayTimeThreshold: 20, minimumDisplayTime: 1, backgroundColor: UIColor.black.withAlphaComponent(0.5), textColor: UIColor.white, fadeInAnimation: nil);
    }
    
    func handleLongPress(indexPath: IndexPath) {
        
        let alert = UIAlertController(title: "Delete?", message: "Are you sure you want to delete this event?", preferredStyle: .alert);
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { (action) in
            //delete event
            let eventToDelete = self.myEventsInProgress[indexPath.item];
            PersistenceManager.shared.context.delete(eventToDelete);
            PersistenceManager.shared.save();
            
            self.myEventsInProgress.remove(at: indexPath.item);
            self.collectionView?.deleteItems(at: [indexPath]);
            
            let userInfo = ["indexPath":indexPath];
            
            let name = Notification.Name(rawValue: overviewPageUpdateIndexPath);
            NotificationCenter.default.post(name: name, object: nil, userInfo: userInfo);
        }))
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: nil));
        self.present(alert, animated: true, completion: nil);
    }
    
    fileprivate func showErrorAlertCreatingEvent(){
        let alert = UIAlertController(title: "Warning", message: "You cannot be working on 5 different events at the same time. You host as many events as you want, but you cannot have more than 5 events not completed.", preferredStyle: .alert);
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil));
        self.present(alert, animated: true, completion: nil);
    }
    
}
