//
//  SplashPage.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/11/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit
import CoreLocation

class SplashPage: UIViewController, CLLocationManagerDelegate{
    
    var locationManager: CLLocationManager!;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.view.backgroundColor = UIColor.appBlue;
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
        
    }
    
    fileprivate func handleToMainPage(){
        let customTabController = CustomTabBar();
        self.present(customTabController, animated: true, completion: nil);
    }
}
