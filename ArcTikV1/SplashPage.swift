//
//  SplashPage.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/11/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit
import CoreLocation
import AWSS3

class SplashPage: UIViewController, CLLocationManagerDelegate{
    
    var button: NormalUIButton = {
        let button = NormalUIButton(type: .system);
        button.setButtonProperties(backgroundColor: .white, title: "Press", font: .montserratBold(fontSize: 14), fontColor: .black);
        return button;
    }()
    
    var locationManager: CLLocationManager!;
    
    let dispatch = DispatchGroup();
    var json: NSDictionary?;
    var events:[Event]?;
    var downloadedImages = [UIImage]();
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.view.backgroundColor = UIColor.appBlue;
        
        self.view.addSubview(button);
        button.anchorCenter(centerXanchor: self.view.centerXAnchor, centerYAnchor: self.view.centerYAnchor, topAnchor: nil, bottomAnchor: nil);
        button.widthAnchor.constraint(equalToConstant: 50).isActive = true;
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true;
        button.addTarget(self, action: #selector(self.lookupEventsAroundYou), for: .touchUpInside);
        
        handleGetLocation();
        
        //the waving penguin here w/ lottie
    }
    
    
    func handleGetLocation(){
        self.locationManager = CLLocationManager();
        locationManager.requestWhenInUseAuthorization();
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.delegate = self;
        locationManager.requestLocation();
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error);
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.locationManager.stopUpdatingLocation();
        self.locationManager.delegate = nil;
        let locValue:CLLocationCoordinate2D = (locationManager.location?.coordinate)!;
        user?.userLatitude = String(format: "%f",locValue.latitude);
        user?.userLongitude = String(format: "%f",locValue.longitude);
    
        lookupEventsAroundYou();
        translateJson();
        handleToMainPage();
    }
    
    fileprivate func handleToMainPage(){
        let customTabController = CustomTabBar();
        
        customTabController.eventsAroundYouPage!.events = self.events;
        self.present(customTabController, animated: true, completion: nil);
    }
}

extension SplashPage{
    @objc func lookupEventsAroundYou(){
        let url = URL(string: "http://localhost:3000/loadPublicEvents")!;
        var request = URLRequest(url: url);
        let body = "latitude=\(user!.userLatitude!)&longitude=\(user!.userLongitude!)&userID=\(user!.userID)&distance=10&bottomPrice=0&topPrice=1000000"
        request.httpMethod = "POST";
        request.httpBody = body.data(using: .utf8);
        let task = URLSession.shared.dataTask(with: request) { (data, res, err) in
            if(err != nil){
                print("error");
                self.dispatch.leave();
                
            }
            if(data != nil){
                let response = NSString(data: data!, encoding: 8);
                if(response == "error" || response == "none"){
                    if(response == "none"){
                        //none
                        self.dispatch.leave();
                        DispatchQueue.main.async {
                            //handle none
                            self.handleNoneReturned();
                        }
                    }else{
                        //error handle error shown
                        self.dispatch.leave();
                        DispatchQueue.main.async {
                            self.handleError();
                        }
                    }
                    //error
                }else{
                    do{
                        let jsonData = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! NSDictionary;
                        
                        self.json = jsonData;
                        self.dispatch.leave();
                    }catch{
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
    
    func handleNoneReturned(){
//        print("none");
        self.events = [Event]();//empty list of events
    }
    
    func handleError(){
        let alert = UIAlertController(title: "Oops", message: "There was a problem connecting to our servers! Try again later! Sorry for the mess up, we will try and solve the problem as quickly as possible. To help us, you can make sure that you are connected to the internet! Thanks - ArcTik team", preferredStyle: .alert);
        alert.addAction(UIAlertAction(title: "Ok", style: .default
            , handler: nil));
        self.present(alert, animated: true, completion: nil);
    }
}
