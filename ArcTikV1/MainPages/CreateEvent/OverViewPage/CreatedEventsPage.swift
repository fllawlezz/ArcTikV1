//
//  CreatedEventsPage.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/17/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class CreatedEventsPage: UICollectionViewController, UICollectionViewDelegateFlowLayout, NVActivityIndicatorViewable{
    
    let titleHeader = "CreatedEventsTitleHeaderReuse";
    let sectionHeader = "CreatedEventsSectionHeader";
    let cellReuse = "CreatedEventsCellReuse";
    let createNewEventReuse = "CreatedEventsNewEventCellReuse";
    
    var myEventsInProgress = [MyEvent]();
    let dispatch = DispatchGroup();
    var eventID: Int?;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.collectionView?.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0);
        self.collectionView?.backgroundColor = UIColor.superLightGray;
        collectionView?.register(CreatedEventsInProgressCell.self, forCellWithReuseIdentifier: cellReuse);
        collectionView?.register(CreatedEventsNewEventCell.self, forCellWithReuseIdentifier: createNewEventReuse);
        collectionView?.register(CreatedEventsMainTitleHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: titleHeader);
        collectionView?.register(CreatedEventSectionHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: sectionHeader)
        setupNavBar();
        
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
                cell.setTitle(title: "Poker game at my place");
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
            currentEvent = self.myEventsInProgress[indexPath.item];
        }else{
            
            //MARK: Set current Event
            currentEvent = MyEvent();
            currentEvent?.stepNumber = 0;
        }
        
        self.handleCreateEvent();
        
    }
    
}

extension CreatedEventsPage{
    @objc func handleClearPressed(){
        self.navigationController?.popViewController(animated: true);
//        self.dismiss(animated: true, completion: nil);
        //        self.navigationController?.dismiss(animated: true, completion: nil);
    }
    
    @objc func handleCreateEvent(){
        startCreateEvent();
        self.stopAnimating();
        
        let layout = UICollectionViewFlowLayout();
        let createEventPage = CreateEventPage(collectionViewLayout: layout);

        let navigationController = UINavigationController(rootViewController: createEventPage);
        navigationController.navigationBar.isTranslucent = false;
        navigationController.navigationBar.barStyle = .blackTranslucent;
        navigationController.navigationBar.tintColor = UIColor.white;
        navigationController.navigationBar.barTintColor = UIColor.appBlue;
        self.present(navigationController, animated: true, completion: nil);
    }
    
    func startCreateEvent(){
        showLoadingView();
        
//        let url = URL(string: "http://localhost:3000/createEvent")!;
//        var request = URLRequest(url: url);
//        let postBody = "username=XXXX";
//        let params = ["username" : "hello", "password" : "none"] as Dictionary<String, AnyObject>
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
////        let data = try? JSONSerialization.data(withJSONObject: params, options: .prettyPrinted);
//        let data = try? JSONSerialization.data(withJSONObject: params, options: []);
//        request.httpMethod = "POST";
////        request.httpBody = postBody.data(using: .utf8);
//        request.httpBody = data;
//        let task = URLSession.shared.dataTask(with: request) { (data, res, err) in
//        }
//
//        task.resume();
        

        let url = URL(string: "http://localhost:3000/startCreateEvent")!;
        var request = URLRequest(url: url);
        let requestBody = "userID=\(user!.userID)"
//        print(requestBody);

        request.httpMethod = "POST";
        request.httpBody = requestBody.data(using: .utf8);
        let dataTask = URLSession.shared.dataTask(with: request) { (data, res, err) in
            if(err != nil){
                print("error");
                return;
            }

            let response = NSString(data: data!, encoding: 8);
//            print("response: \(response)");
            self.eventID = Int(response! as String);
            self.dispatch.leave();
        }
        self.dispatch.enter();
        dataTask.resume();
        self.dispatch.wait();
        if let event = currentEvent{
            event.eventID = self.eventID;
//            print(event.eventID)
        }
//        print("event id");
//        print(currentEvent?.eventID);
        
    }
    
    func showLoadingView(){
        let size = CGSize(width: 50, height: 50)
        self.startAnimating(size, message: "Loading", messageFont: UIFont.montserratSemiBold(fontSize: 14), type: NVActivityIndicatorType.circleStrokeSpin, color: UIColor.white, padding: 0, displayTimeThreshold: 20, minimumDisplayTime: 1, backgroundColor: UIColor.black.withAlphaComponent(0.5), textColor: UIColor.white, fadeInAnimation: nil);
    }
}
