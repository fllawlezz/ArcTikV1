//
//  MainFiltersPage.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/15/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit
import AWSS3;

let setDistanceFiltersPage = "SetDistanceForFiltersPage";
let setPriceFiltersPage = "SetPriceFiltersPage";
let resetDistanceFiltersPage = "ResetDistanceForFiltersPage";
let resetPriceFiltersPage = "ResetPriceFiltersPage";

protocol FiltersPageDelegate{
    func handleSearchFilters(events: [Event]);
}

class MainFiltersPage: UICollectionViewController, UICollectionViewDelegateFlowLayout, FiltersButtonViewDelegate{
    
    var searchButtonView: FiltersButtonView = {
        let searchButtonView = FiltersButtonView();
        return searchButtonView;
    }()
    
    var backgroundView: UIView = {
        let backgroundView = UIView();
        backgroundView.translatesAutoresizingMaskIntoConstraints = false;
        backgroundView.backgroundColor = UIColor.white;
        return backgroundView;
    }()
    
    let cellReuse = "MainFiltersPageReuse";
    let headerReuse = "MainFiltersHeaderReuse";
    
    let headerTitles = ["Distance","Price"];
    let cellTitlesSection0 = ["5 miles","10 miles","20 miles","50 miles"];
    let cellDescriptionSection0 = ["All events up to 5 miles around you","All events upt to 10 miles around you","All events up to 20 miles around you","All events up to 50 miles around you"];
    let distances = [5,10,20,50];
    
    let cellTitlesSection1 = ["$","$$","$$$","$$$$","$$$$$"]
    let cellDescriptionSection1 = ["Free to $10","$10 to $30","$30 to $75","$75 to $200","$200 and up"];
    let priceInfos = [[0.0,10.0],[10.0,30.0],[30.0,75.0],[75.0,200.0],[200.0,1000000.0]];
    
    let dispatch = DispatchGroup();
    var json: NSDictionary?;
    var delegate:FiltersPageDelegate?;
    var events:[Event]?;
    
    var distance:Int?;
    var bottomPrice: Double?;
    var topPrice: Double?;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        addObservers();
        setupNavBar();
        collectionView?.showsVerticalScrollIndicator = false;
        collectionView?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 80, right: 0);
        self.collectionView?.backgroundColor = UIColor.white;
        collectionView?.register(MainFilterCell.self, forCellWithReuseIdentifier: cellReuse);
        collectionView?.register(MainFilterHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerReuse);
        setupSearchButtonView();
        if(UIScreenHeight! >= 812.0){
            setupBackground();
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self);
    }
    
    fileprivate func addObservers(){
        let name = Notification.Name(rawValue: setDistanceFiltersPage);
        NotificationCenter.default.addObserver(self, selector: #selector(self.setDistance(notification:)), name: name, object: nil);
        
        let priceName = Notification.Name(rawValue: setPriceFiltersPage);
        NotificationCenter.default.addObserver(self, selector: #selector(self.setPrices(notification:)), name: priceName, object: nil);
        
        let resetDistanceName = Notification.Name(rawValue: resetDistanceFiltersPage);
        let resetPricename = Notification.Name(rawValue: resetPriceFiltersPage);
        NotificationCenter.default.addObserver(self, selector: #selector(self.resetDistance), name: resetDistanceName, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(self.resetPrices), name: resetPricename, object: nil);
    }
    
    fileprivate func setupNavBar(){
        let clearButton = UIBarButtonItem(image: #imageLiteral(resourceName: "clearWhiteNav"), style: .plain, target: self, action: #selector(handleClearPressed));
        self.navigationItem.leftBarButtonItem = clearButton;
        
        let searchButton = UIBarButtonItem(title: "Clear All", style: .plain, target: self, action: #selector(self.handleClearAll));
        self.navigationItem.rightBarButtonItem = searchButton;
        
        self.navigationItem.title = "Filters";
    }
    
    fileprivate func setupSearchButtonView(){
        self.view.addSubview(searchButtonView);
        searchButtonView.anchor(left: self.view.leftAnchor, right: self.view.rightAnchor, top: nil, bottom: self.view.safeAreaLayoutGuide.bottomAnchor, constantLeft: 0, constantRight: 0, constantTop: 0, constantBottom: 0, width: 0, height: 80);
        searchButtonView.delegate = self;
    }
    
    fileprivate func setupBackground(){
        self.view.addSubview(backgroundView);
        backgroundView.anchor(left: self.view.leftAnchor, right: self.view.rightAnchor, top: nil, bottom: self.view.bottomAnchor, constantLeft: 0, constantRight: 0, constantTop: 0, constantBottom: 0, width: 0, height: 50);
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuse, for: indexPath) as! MainFilterCell;
        if(indexPath.section == 0){
            cell.section = 0;
            cell.setTitle(text: cellTitlesSection0[indexPath.item]);
            cell.setDescription(text: cellDescriptionSection0[indexPath.item]);
            cell.distance = distances[indexPath.item];
        }else{
            cell.section = 1;
            cell.setTitle(text: cellTitlesSection1[indexPath.item])
            cell.setDescription(text: cellDescriptionSection1[indexPath.item]);
            let prices = priceInfos[indexPath.item];
            cell.bottomPrice = prices[0];
            cell.topPrice = prices[1];
        }
        return cell;
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2;
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(section == 0){
            return 4;
        }else{
            return 5;
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 70);
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerReuse, for: indexPath) as! MainFilterHeader;
        if(indexPath.section == 0){
            header.setTitleLabel(text: "Distance");
        }else{
            header.setTitleLabel(text: "Price");
        }
        return header;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 70);
    }
}

extension MainFiltersPage{
    
    @objc func handleClearPressed(){
        self.dismiss(animated: true, completion: nil);
    }
    
    @objc func handleClearAll(){
        let name = Notification.Name(rawValue: clearAllFiltersCellUnCheck);
        NotificationCenter.default.post(name: name, object: nil);
    }
    
    func handleSearchButtonPressed() {
        if(self.distance != nil && self.topPrice != nil && self.bottomPrice != nil){
            if(self.distance! > 0 && self.topPrice! > 0){
                handleFiltersSearch(distance: self.distance!, bottomPrice: self.bottomPrice!, topPrice: self.topPrice!);
                self.translateJson();
                delegate?.handleSearchFilters(events: self.events!);
                self.dismiss(animated: true, completion: nil);
            }else{
                print("none");
            }
        }
    }
    
    
    @objc func handleFiltersSearch(distance: Int, bottomPrice: Double, topPrice: Double){
        let url = URL(string: "http://localhost:3000/loadPublicEvents")!;
        var request = URLRequest(url: url);
        let body = "latitude=\(user!.userLatitude!)&longitude=\(user!.userLongitude!)&userID=\(user!.userID)&distance=\(distance)&bottomPrice=\(bottomPrice)&topPrice=\(topPrice)"
        request.httpMethod = "POST";
        request.httpBody = body.data(using: .utf8);
        let task = URLSession.shared.dataTask(with: request) { (data, res, err) in
            if(err != nil){
                print("error");
                self.dispatch.leave();
            }
            
            if(data != nil){
                let response = NSString(data: data!, encoding: 8);
                if(response == "error"){
                    //error
                    print("error");
                }else{
                    do{
                        let jsonData = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! NSDictionary;
                        
                        self.json = jsonData;
                        self.dispatch.leave();
                    }catch{
                        print("jsonError");
                        print(error);
                    }
                }
                
            }
        }
        dispatch.enter();
        task.resume();
        dispatch.wait();
    }
    
    func translateJson(){
        guard let json = self.json else{
            return;
        }
        
        print(json);
        
        var eventArray = [Event]();
        
        let eventIDs = json["eventIDs"] as! NSArray;
        let hosterIDs = json["hosterIDs"] as! NSArray;
        let titles = json["titles"] as! NSArray;
        let descriptions = json["descriptions"] as! NSArray;
        let countries = json["countries"] as! NSArray;
        let streets = json["streets"] as! NSArray;
        let cities = json["cities"] as! NSArray;
        let zipcodes = json["zipcodes"] as! NSArray;
        let privacy = json["privacy"] as! NSArray;
        let people = json["people"] as! NSArray;
        let startDates = json["startDates"] as! NSArray;
        let endDates = json["endDates"] as! NSArray;
        let startTimes = json["startTimes"] as! NSArray;
        let endTimes = json["endTimes"] as! NSArray;
        let prices = json["prices"] as! NSArray;
        let userNames = json["userNames"] as! NSArray;
        //        let userProfileUrls = json["userProfileUrls"] as! NSArray;
        let numberOfPhotos = json["numberOfPhotos"] as! NSArray;
        let currentPeople = json["currentPeople"] as! NSArray;
        let photoUrls = json["photoUrls"] as! NSArray//array of links that are ordered by descending events
        
        var count = 0;
        var previousPhotosCount = 0;
        while(count<eventIDs.count){
            let newEvent = Event();
            newEvent.posterName = (userNames[count] as! String);
            newEvent.eventID = (eventIDs[count] as! Int);
            newEvent.hosterID = (hosterIDs[count] as! Int);
            newEvent.eventTitle = (titles[count] as! String);
            newEvent.eventDescription = (descriptions[count] as! String);
            newEvent.country = (countries[count] as! String);
            newEvent.street = (streets[count] as! String);
            newEvent.city = (cities[count] as! String);
            newEvent.zipcode = (zipcodes[count] as! String);
            newEvent.privacy = (privacy[count] as! String);
            newEvent.people = (people[count] as! Int);
            newEvent.startDate = (startDates[count] as! String);
            newEvent.endDate = (endDates[count] as! String);
            newEvent.startTime = (startTimes[count] as! String);
            newEvent.endTime = (endTimes[count] as! String);
            newEvent.price = (prices[count] as! Double);
            newEvent.currentPeople = (currentPeople[count] as! Int);
            
            //use numberofPhotos[count] as a indicator for how many photos to filter through
            let eventPhotosCount = (numberOfPhotos[count] as! Int)
            
            var eventImages = [UIImage]();
            
            var countPhotos = 0;
            while(countPhotos < eventPhotosCount){
                //get the url from photoUrls
                let url = (photoUrls[previousPhotosCount] as! String);
                let image = downloadImage(filePath: url);
                if(image != nil){
                    eventImages.append(image!);
                }
                previousPhotosCount+=1;//says that we saved one photo
                countPhotos+=1;
            }
            
            newEvent.eventImages = eventImages;
            //            print("downloading cell image: \(cellImages[count] as! String)")
            //            let cellImage = downloadImage(filePath: cellImages[count] as! String);
            //            let profileImage = downloadImage(filePath: userProfileUrls[count] as! String);
            
            //            newEvent.cellImage = cellImage;
            //            newEvent.posterImage = profileImage;
            
            eventArray.append(newEvent);
            
            count += 1;
        }
        
        //        print(eventArray.count);
        self.events = eventArray;
        
        
    }
    
    func downloadImage(filePath: String) -> UIImage?{
        
        var downloadedImage: UIImage?;
        let credentialsProvider = AWSCognitoCredentialsProvider(regionType:.USWest2,
                                                                identityPoolId:"us-west-2:e9c5dc3f-acac-4006-b512-af168e1e47a9")
        let configuration = AWSServiceConfiguration(region:.USWest2, credentialsProvider:credentialsProvider)
        AWSServiceManager.default().defaultServiceConfiguration = configuration
        let transferUtility = AWSS3TransferUtility.default();
        
        dispatch.enter();
        transferUtility.downloadData(
        fromBucket: "arctikimages", key: "EventImages/\(filePath)", expression: nil) { (task, url, data, err) in
            if(err != nil){
                //                print(err);
                print("error downloading images splash page");
            }else{
                if(data != nil){
                    let image = UIImage(data: data!)
                    //                    self.downloadedImages.append(image!);
                    downloadedImage = image;
                    
                }
            }
            self.dispatch.leave();
        }
        dispatch.wait()
        return downloadedImage;
    }
}

extension MainFiltersPage{
    
    func handleShowError(){
        let alert = UIAlertController(title: "Ooops", message: "There was a problem with geting your filters! We apologize! Please try again later!", preferredStyle: .alert);
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            self.dismiss(animated: true, completion: nil);
        }))
        self.present(alert, animated: true, completion: nil);
    }
    
    @objc func setDistance(notification: NSNotification){
        if let userInfo = notification.userInfo{
            let distance = userInfo["distance"] as! Int;
            self.distance = distance;
        }
    }
    
    @objc func resetDistance(){
        self.distance = 0;
    }
    
    @objc func setPrices(notification: NSNotification){
        if let userInfo = notification.userInfo{
            let bottomPrice = userInfo["bottomPrice"] as? Double;
            let topPrice = userInfo["topPrice"] as? Double;
            self.bottomPrice = bottomPrice;
            self.topPrice = topPrice;
            
            print(self.bottomPrice);
            print(self.topPrice);
        }
    }
    
    @objc func resetPrices(){
        self.bottomPrice = 0;
        self.topPrice = 0;
    }
}
