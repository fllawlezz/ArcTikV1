//
//  ReviewPage.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/11/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit
import AWSS3
import NVActivityIndicatorView

class ReviewPage: UICollectionViewController, UICollectionViewDelegateFlowLayout, CreateEventButtonCellDelegate, ReviewPageDescriptionCellDelegate, NVActivityIndicatorViewable{
    
    let headerReuse = "ReviewPageHeaderCell";
    let descriptionCellReuse = "ReviewPageDescriptionCellReuse";
    let reviewInfoCellReuse = "ReviewInfoCellReuse";
    let createEventButtonReuse = "CreateEventButtonReuse";
    let toListReuse = "CreateEventToListReuse";
    let titleCell = "CreateEventTitleLabel";
    let imagesCell = "CreateEventImagesCell";
    
    let headerTitles = [
        "Description",//1
        "Location",//2
        "Privacy/People",//3
        "Dates and Times",//4
        "Images",//5
        "Charge"//6
        //7 = create button
    ]
    
    let reviewPageInfoCellTitles = ["Location","Public/Private","Number of People"];
    let datesTitles = ["Start Date","End Date","Start Time","End Time"];
    
    var descriptionIsExpanded = false;
    var imageNamesForHostEvent: [String]?;
    var estimatedFrameSize:CGSize?;
    var dispatch = DispatchGroup();
    
    override func viewDidLoad() {
        super.viewDidLoad();
        setCurrentEventData()
        setupNavBar();
        collectionView?.backgroundColor = UIColor.white;
        collectionView?.showsVerticalScrollIndicator = false;
        self.collectionView?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0);
        self.collectionView?.register(CreateEventMainHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerReuse);
        self.collectionView?.register(ReviewPageDescriptionCell.self, forCellWithReuseIdentifier: descriptionCellReuse);
        self.collectionView?.register(ReviewPageInfoCell.self, forCellWithReuseIdentifier: reviewInfoCellReuse);
        self.collectionView?.register(CreateEventButtonCell.self, forCellWithReuseIdentifier: createEventButtonReuse);
        self.collectionView?.register(ReviewPageListCell.self, forCellWithReuseIdentifier: toListReuse);
        self.collectionView?.register(ReviewPageTitleCell.self, forCellWithReuseIdentifier: titleCell)
        self.collectionView?.register(ReviewImagesCell.self, forCellWithReuseIdentifier: imagesCell);
        
    }
    
    fileprivate func setCurrentEventData(){
//        currentEvent?.stepNumber = 9;
        currentEventInProgress?.step = 9;
        PersistenceManager.shared.save();
        
//        print(currentEventInProgress?.step);
        
        let createEventName = Notification.Name(rawValue: reloadCreateEventPage);
        NotificationCenter.default.post(name: createEventName, object: nil);
        
        let name = Notification.Name(rawValue: reloadOverViewPage);
        NotificationCenter.default.post(name: name, object: nil);
    }
    
    fileprivate func setupNavBar(){
        let clearButton = UIBarButtonItem(image: UIImage(named: "clearWhiteNav"), style: .plain, target: self, action: #selector(self.handleClearPressed));
        self.navigationItem.leftBarButtonItem = clearButton;
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(indexPath.section == 0){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: titleCell, for: indexPath) as! ReviewPageTitleCell
//            cell.setTitle(title: currentEvent!.eventTitle!);
            cell.setTitle(title: currentEventInProgress!.title!);
            return cell;
        }
        
        if(indexPath.section == 1){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: descriptionCellReuse, for: indexPath) as! ReviewPageDescriptionCell;//description cell
            cell.delegate = self;
            cell.isExpanded = self.descriptionIsExpanded;
//            cell.setDescription(description: currentEvent!.description!);
            cell.setDescription(description: currentEventInProgress!.eventDescription!);
            return cell;
        }
        if(indexPath.section == 2){
            if(indexPath.item == 0){
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reviewInfoCellReuse, for: indexPath) as! ReviewPageInfoCell
                cell.setTitle(title: reviewPageInfoCellTitles[indexPath.item]);
                let infoString = "\(currentEventInProgress!.street!), \(currentEventInProgress!.city!)"
                cell.setInfoFieldText(text: infoString);
                return cell;
            }
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: toListReuse, for: indexPath) as! ReviewPageListCell
            cell.setDescriptionText(description: "Requirements");
            return cell;
        }
        
        if(indexPath.section == 5){//images
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: imagesCell, for: indexPath) as! ReviewImagesCell
            
            let images = NSKeyedUnarchiver.unarchiveObject(with: currentEventInProgress!.images! as Data) as! [UIImage];
            cell.images = images;
            return cell;
        }
        
        if(indexPath.section == 6 && indexPath.item == 1){//things to bring section 6
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: toListReuse, for: indexPath) as! ReviewPageListCell
            cell.setDescriptionText(description: "Things To Bring");
            return cell;
        }
        
        if(indexPath.section == 7 && indexPath.item == 0){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: createEventButtonReuse, for: indexPath) as! CreateEventButtonCell
            cell.delegate = self;
            return cell;
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reviewInfoCellReuse, for: indexPath) as! ReviewPageInfoCell
        
        if(indexPath.section == 3 && indexPath.item == 0){
            cell.setTitle(title: "Public/Private");
//            cell.setInfoFieldText(text: currentEvent!.privacy!);
            cell.setInfoFieldText(text: currentEventInProgress!.privacy!);
        }
        
        if(indexPath.section == 3 && indexPath.item == 1){
            cell.setTitle(title: "Number of People");
//            cell.setInfoFieldText(text: "\(currentEvent!.people!)");
            cell.setInfoFieldText(text: "\(currentEventInProgress!.people)")
        }

        if(indexPath.section == 4){
            cell.setTitle(title: datesTitles[indexPath.item]);
            switch(indexPath.item){
            case 0: cell.setInfoFieldText(text: currentEventInProgress!.startDate!);break;
            case 1: cell.setInfoFieldText(text: currentEventInProgress!.endDate!);break;
            case 2: cell.setInfoFieldText(text: currentEventInProgress!.startTime!);break;
            case 3: cell.setInfoFieldText(text: currentEventInProgress!.endTime!);break;
            default: break;
            }
        }

        if(indexPath.section == 6){
            cell.setTitle(title: "Charge");
            cell.setInfoFieldText(text: "$\(currentEventInProgress!.price)");
        }
        
        return cell;
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 8;
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(section == 4){
            return 4;
        }
        
        if(section == 2 || section == 6 || section == 3){
            return 2;
        }
        return 1;
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(indexPath.section == 2 && indexPath.item == 1){
            //requirements
            if let event = currentEventInProgress{
                let requirementsPage = RequirementsPage();
                requirementsPage.fromEventsInfo = true;
                let requirementsList = NSKeyedUnarchiver.unarchiveObject(with: event.requirements! as Data) as! [String];
                requirementsPage.requirementsListView.requirementsList = requirementsList;
                
                let navigationController = UINavigationController(rootViewController: requirementsPage);
                navigationController.navigationBar.isTranslucent = false;
                navigationController.navigationBar.barStyle = .blackTranslucent;
                navigationController.navigationBar.tintColor = UIColor.white;
                navigationController.navigationBar.barTintColor = UIColor.appBlue;
                self.present(navigationController, animated: true, completion: nil);
                
            }
            
        }
        
        if(indexPath.section == 6 && indexPath.item == 1){
            //things to bring
            if let event = currentEventInProgress{
                let thingsToBringPage = ThingsToBringPage();
                thingsToBringPage.fromEventsInfo = true;
                
                let thingsToBringList = NSKeyedUnarchiver.unarchiveObject(with: event.thingsToBring! as Data) as! [String];
                
                thingsToBringPage.thingsToBringTableView.thingsToBringList = thingsToBringList
                
                let navigationController = UINavigationController(rootViewController: thingsToBringPage);
                navigationController.navigationBar.isTranslucent = false;
                navigationController.navigationBar.barStyle = .blackTranslucent;
                navigationController.navigationBar.tintColor = UIColor.white;
                navigationController.navigationBar.barTintColor = UIColor.appBlue;
                self.present(navigationController, animated: true, completion: nil);
                
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if(indexPath.section == 1){
            if(descriptionIsExpanded){
                if let height = self.estimatedFrameSize?.height{
                    return CGSize(width: self.view.frame.width, height: height+60);
                }
                return CGSize(width: self.view.frame.width, height: 280);
            }
            
            if(currentEventInProgress!.eventDescription!.count < 40){
                return CGSize(width: self.view.frame.width, height: 100);
            }
            
            return CGSize(width: self.view.frame.width, height: 150);
        }
        
        if((indexPath.section == 2 && indexPath.item == 1) || (indexPath.section == 6 && indexPath.item == 1)){
            return CGSize(width: self.view.frame.width, height: 60)
        }
        
        if(indexPath.section == 4){
            return CGSize(width: self.view.frame.width/2, height: 80);
        }
        if(indexPath.section == 5){
             return CGSize(width: self.view.frame.width, height: 170);
        }
        
        if(indexPath.section == 7 && indexPath.item == 0){
            return CGSize(width: self.view.frame.width, height: 100);
        }
        
        return CGSize(width: self.view.frame.width, height: 80);
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if(section < 7 && section != 0){
            return CGSize(width: self.view.frame.width, height: 70);
        }else{
            return CGSize(width: 0, height: 0);
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerReuse, for: indexPath) as! CreateEventMainHeader
        header.setTitle(title: headerTitles[indexPath.section-1]);
        return header;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
    
}

extension ReviewPage{
    @objc func handleClearPressed(){
        let alert = UIAlertController(title: "Exit", message: "Do you want to save your listing?", preferredStyle: .alert);
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action) in
            //save
            PersistenceManager.shared.save();
            self.dismiss(animated: true, completion: nil);
            //            self.navigationController?.popToRootViewController(animated: true);
        }))
        alert.addAction(UIAlertAction(title: "Discard", style: .destructive, handler: { (action) in
            //not save
            self.dismiss(animated: true, completion: nil);
        }))
        self.present(alert, animated: true, completion: nil);
    }
    
    func seeMoreDescription() {
        if((currentEventInProgress?.eventDescription!.count)! > 40){
            descriptionIsExpanded = true;
            
            let cell = collectionView?.cellForItem(at: IndexPath(item: 0, section: 1)) as! ReviewPageDescriptionCell
            let size = CGSize(width: self.view.frame.width-20, height: .infinity)
            self.estimatedFrameSize = cell.descriptionTextView.sizeThatFits(size);
            
            if(descriptionIsExpanded){
                UIView.animate(withDuration: 0.3) {
                    self.collectionView?.reloadItems(at: [IndexPath(item: 0, section: 0)]);
                }
                
            }
        }
    }
}

extension ReviewPage{
    func handleCreatePressed(){
        self.showLoadingView();
        var serverResponse: String?;
        
//        user?.userLongitude = "0.0000";
//        user?.userLatitude = "0.00000";
        
        if let event = currentEventInProgress{
            let requirementsList = NSKeyedUnarchiver.unarchiveObject(with: event.requirements! as Data) as! [String];
            let thingsToBringList = NSKeyedUnarchiver.unarchiveObject(with: event.thingsToBring! as Data) as! [String];
            let images = NSKeyedUnarchiver.unarchiveObject(with: event.images! as Data) as! [UIImage];
            
            let body = constructBody(userID: user!.userID, eventID: Int(event.eventID),eventTitle: event.title!, description: event.eventDescription!, latitude: user!.userLatitude!, longitude: user!.userLongitude!, country: event.country!, street: event.street!, city: event.city!, zipcode: event.zipcode!, requirements: requirementsList, privacy: event.privacy!, people: Int(event.people), startDate: event.startDate!, endDate: event.endDate!, startTime: event.startTime!, endTime: event.endTime!, price: event.price,thingsToBring: thingsToBringList, images: images);
            
            let url = URL(string: "http://localhost:3000/createEvent")!;
//            let url = URL(string: "http://arctikllc.com:3000/createEvent")!;
            var request = URLRequest(url: url);
            request.httpMethod = "POST";
            request.httpBody = body;
            request.addValue("application/json", forHTTPHeaderField: "Content-Type");
            
            let task = URLSession.shared.dataTask(with: request) { (data, res, err) in
                if(err != nil){
                    print("error");
                    serverResponse = "error";
                    self.dispatch.leave();
                }
                if(data != nil){
                    let response = NSString(data: data!, encoding: 8);
                    serverResponse = (response! as String);
                    self.dispatch.leave();
                }
                
            }
            dispatch.enter();
            task.resume();
            dispatch.wait();
            
            self.stopAnimating();
            if(serverResponse == "success"){
                // tell user that their event has been created
                self.showSuccessAlert();
//                print("success");
            }else{
                //tell user that their event creation has failed and to try again later
                self.showErrorAlert();
//                print("error");
            }
            
        }
    }
    
    func constructBody(userID:Int,eventID: Int ,eventTitle: String, description: String, latitude: String, longitude: String, country: String, street: String, city: String, zipcode: String, requirements: [String], privacy: String, people: Int, startDate: String, endDate: String, startTime: String, endTime: String, price: Double, thingsToBring: [String],images: [UIImage]) -> Data?{
        
        var imageNames = [String]();
        var count = 0;
        for _ in images{
            let newName = "\(currentEventInProgress!.eventID)_pic\(count).png"
            imageNames.append(newName);
            count+=1;
        }
        
        self.imageNamesForHostEvent = imageNames;
        
        if(images.count > 0){
            dispatch.enter();
            uploadPhotos(images: images, imageNames: imageNames);
            dispatch.wait();
        }
        
        let bodyObject = NSMutableDictionary();
        
        bodyObject.setValue(eventID, forKey: "eventID");
        bodyObject.setValue(userID, forKey: "userID");
        bodyObject.setValue(eventTitle, forKey: "eventTitle");
        bodyObject.setValue(description, forKey: "description");
        bodyObject.setValue(latitude, forKey: "latitude");
        bodyObject.setValue(longitude, forKey: "longitude");
        bodyObject.setValue(country, forKey: "country");
        bodyObject.setValue(street, forKey: "street");
        bodyObject.setValue(city, forKey: "city");
        bodyObject.setValue(zipcode, forKey: "zipcode");
        bodyObject.setValue(requirements, forKey: "requirements");
        bodyObject.setValue(privacy, forKey: "privacy");
        bodyObject.setValue(people, forKey: "people");
        bodyObject.setValue(startDate, forKey: "startDate");
        bodyObject.setValue(endDate, forKey: "endDate");
        bodyObject.setValue(startTime, forKey: "startTime");
        bodyObject.setValue(endTime, forKey: "endTime");
        bodyObject.setValue(price, forKey: "price");
        bodyObject.setValue(thingsToBring, forKey: "thingsToBring");
        bodyObject.setValue(imageNames, forKey: "imageNames");
        
        
        do{
            let jsonData = try JSONSerialization.data(withJSONObject: bodyObject, options: .prettyPrinted);
            return jsonData;
        }catch{
            print("error parsing json");
        }
        
        return nil
        
    }
    
    func uploadPhotos(images: [UIImage], imageNames: [String]){
        var count = 0;
        while(count < images.count){
            let image = images[count];
            let fileName = imageNames[count];
            
            let imageData = UIImagePNGRepresentation(image);
            
            let credentialsProvider = AWSCognitoCredentialsProvider(regionType:.USWest2,
                                                                    identityPoolId:"us-west-2:e9c5dc3f-acac-4006-b512-af168e1e47a9")
            let configuration = AWSServiceConfiguration(region:.USWest2, credentialsProvider:credentialsProvider)
            AWSServiceManager.default().defaultServiceConfiguration = configuration
            
            
            let transferUtility = AWSS3TransferUtility.default();
            transferUtility.uploadData(imageData!, bucket: "arctikimages", key: "EventImages/\(fileName)", contentType: "image/png", expression: nil, completionHandler: nil).continueWith { (task) -> Any? in
                if let _ = task.error{
                    print("error");
                }
                
                if let _ = task.result{
                    //do something
                    print("success");
                }
                return nil
            }
            count += 1;
        }
        dispatch.leave();

    }
    
    func showErrorAlert(){
        let alert = UIAlertController(title: "Oops", message: "There was a problem creating your event! Try again later!", preferredStyle: .alert);
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            self.dismiss(animated: true, completion: nil);
        }))
        self.present(alert, animated: true, completion: nil);
    }
    
    func showSuccessAlert(){
        let alert = UIAlertController(title: "Created!", message: "Your event was created successfully!", preferredStyle: .alert);
        alert.addAction(UIAlertAction(title: "Ok!", style: .default, handler: { (alert) in

            let notification = Notification.Name(rawValue: dismissCreateEventPage);
            NotificationCenter.default.post(name: notification, object: nil);
        }))
        self.present(alert, animated: true, completion: nil);
    }
    
    
    func createHostedEvent(){
        let event = currentEventInProgress!;
        
        guard let hostedImageNames = self.imageNamesForHostEvent else {
            return;
        }
        
        let imageNameData = NSKeyedArchiver.archivedData(withRootObject: hostedImageNames);
        
        let newHostedEvent = HostedEvent(context: PersistenceManager.shared.context);
        newHostedEvent.eventID = event.eventID;
        newHostedEvent.eventTitle = event.title;
        newHostedEvent.thingsToBring = event.thingsToBring;
        newHostedEvent.city = event.city;
        newHostedEvent.country = event.country;
        newHostedEvent.endDate = event.endDate;
        newHostedEvent.endTime = event.endTime;
        newHostedEvent.eventDescription = event.eventDescription;
        newHostedEvent.hosterID = event.hosterID;
        newHostedEvent.imageNames = imageNameData as NSData;
        newHostedEvent.people = event.people;
        newHostedEvent.price = event.price;
        newHostedEvent.privacy = event.privacy;
        newHostedEvent.requirements = event.requirements;
        newHostedEvent.startDate = event.startDate;
        newHostedEvent.startTime = event.startTime;
        newHostedEvent.street = event.street;
        newHostedEvent.zipcode = event.zipcode;
        
        PersistenceManager.shared.save();
        
    }
    
    func showLoadingView(){
        let size = CGSize(width: 50, height: 50)
        self.startAnimating(size, message: "Loading", messageFont: UIFont.montserratSemiBold(fontSize: 14), type: NVActivityIndicatorType.circleStrokeSpin, color: UIColor.white, padding: 0, displayTimeThreshold: 20, minimumDisplayTime: 1, backgroundColor: UIColor.black.withAlphaComponent(0.5), textColor: UIColor.white, fadeInAnimation: nil);
    }
}
