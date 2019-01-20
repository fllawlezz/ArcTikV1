//
//  LocationPage.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/10/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit
import GooglePlaces

let setCountryNotification = "SetCountryNotification";
let resignLocationPage = "ResignLocationPageCells";

class LocationPage: UICollectionViewController, UICollectionViewDelegateFlowLayout, LocationPageCellDelegate, AskForAddressPageDelegate{

    let reuseIdentifier = "Cell"
    
    let headerIdentifier = "headerIdentifier";
    
    var nextButton: NormalUIButton = {
        let nextButton = NormalUIButton(type: .system);
        nextButton.setButtonProperties(backgroundColor: .appBlue, title: "Next", font: .montserratSemiBold(fontSize: 14), fontColor: .white);
        return nextButton;
    }()
    
    
    let titles = [
        "Country/Region",
        "Street",
        "City",
        "Zipcode"
    ]
    
    let placeholders = [
        "eg: United States",
        "eg: 111 11 ave",
        "eg: Oakland",
        "Eg: 91234"
    ]
    
    var country, street, city, zipcode: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.touchCollectionView));
        self.collectionView?.addGestureRecognizer(tapGesture);
        
        self.collectionView?.backgroundColor = UIColor.white;
        self.collectionView!.register(LocationPageCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView?.register(CreateEventMainHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerIdentifier);
        setupNextButton();
        setupNavBar();
        setCurrentEventData();
        // Do any additional setup after loading the view.
    }
    
    fileprivate func setCurrentEventData(){
        currentEvent?.stepNumber = 2;
        let name = Notification.Name(rawValue: reloadCreateEventPage);
        NotificationCenter.default.post(name: name, object: nil);
        
        if let country = currentEvent?.country{
            self.country = country;
        }
        
        if let street = currentEvent?.street{
            self.street = street;
        }
        if let city = currentEvent?.city{
            self.city = city;
        }
        if let zipcode = currentEvent?.zipcode{
            self.zipcode = zipcode;
        }
    }
    
    fileprivate func setupNavBar(){
        let clearButton = UIBarButtonItem(image: UIImage(named: "clearWhiteNav"), style: .plain, target: self, action: #selector(self.handleClearPressed));
        self.navigationItem.leftBarButtonItem = clearButton;
    }
    
    fileprivate func setupNextButton(){
        self.view.addSubview(nextButton);
//        nextButton.anchor(left: nil, right: self.view.rightAnchor, top: nil, bottom: self.view.safeAreaLayoutGuide.bottomAnchor, constantLeft: 0, constantRight: -20, constantTop: 0, constantBottom: -40, width: 100, height: 40);
//        nextButton.addTarget(self, action: #selector(self.handleNextButtonPressed), for: .touchUpInside);
        nextButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -25).isActive = true;
        nextButton.widthAnchor.constraint(equalToConstant: 100).isActive = true;
        nextButton.heightAnchor.constraint(equalToConstant: 40).isActive = true;
        if(UIScreenHeight! == 812.0){// iphone x
            nextButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -(self.view.frame.height/3)).isActive = true;
        }else if(UIScreenHeight! == 736){//iphone 6s+,7s+
            nextButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -(self.view.frame.height/3)+20).isActive = true;
        }else if(UIScreenHeight! > 812.0){//iphone XR and Up
            nextButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -(self.view.frame.height/3)-40).isActive = true;
        }else{//iphone 6s,7s,etc
            //            nextButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -(self.view.frame.height/3)+).isActive = true;
            nextButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant:  -(self.view.frame.height/3)+70).isActive = true;
        }
        nextButton.addTarget(self, action: #selector(self.handleNextButtonPressed), for: .touchUpInside);
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 4;
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! LocationPageCell
        cell.setTitle(title: titles[indexPath.item], placeholder: placeholders[indexPath.item]);
        // Configure the cell
        cell.indexPath = indexPath.item;
        cell.delegate = self;
        if(indexPath.item == 0){
            cell.infoField.text = self.country;
        }
        
        if(indexPath.item == 1){
            cell.infoField.text = self.street;
        }
        
        if(indexPath.item == 2){
            cell.infoField.text = self.city
        }
        
        if(indexPath.item == 3){
            cell.infoField.text = self.zipcode;
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 80);
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 70);
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier, for: indexPath) as! CreateEventMainHeader
        header.setTitle(title: "Where will the event take place?");
        header.titleLabel.font = UIFont.montserratSemiBold(fontSize: 18);
        return header;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
    
    @objc func touchCollectionView(){
//        print("touched");
        let name = Notification.Name(rawValue: resignLocationPage);
        NotificationCenter.default.post(name: name, object: nil);

    }
    
    func getData()->[String]{
        var count = 0;
        var data = [String]();
        while(count < 4){
            let cell = self.collectionView?.cellForItem(at: IndexPath(item: count, section: 0)) as! LocationPageCell;
            data.append(cell.infoField.text!);//in order from : country, street, city, region
            count+=1;
        }
        return data;
    }
    
    func checkIfEmpty()->Bool{
        var empty = false;
        var count = 0;
        while(count < 4){
            let cell = self.collectionView?.cellForItem(at: IndexPath(item: count, section: 0)) as! LocationPageCell;
            switch(count){//0: Country, 1: Address, 2: City, 3: Zipcode
            case 0: if(cell.infoField.text!.count < 2){ empty = true};break;
            case 1: if(cell.infoField.text!.count < 5){ empty = true};break;
            case 2: if(cell.infoField.text!.count < 2){ empty = true};break;
            case 3: if(cell.infoField.text!.count < 5){ empty = true};break;
            default:break;
            }
            count += 1;
        }
        return empty;
    }

}

extension LocationPage{
    @objc func handleNextButtonPressed(){
        let emptyCheck = checkIfEmpty();
        if(emptyCheck){
            //get alert
            showEmptyAlert();
        }else{
            
            var locationData = getData();
            
            currentEvent?.country = locationData[0];
            currentEvent?.street = locationData[1];
            currentEvent?.city = locationData[2];
            currentEvent?.zipcode = locationData[3];
            
            let requirementsPage = RequirementsPage();
            
//            let requirementsPage = RequirementsPageList();
            
            self.navigationController?.pushViewController(requirementsPage, animated: true);
        }
    }
    
    @objc func handleClearPressed(){
        let alert = UIAlertController(title: "Exit", message: "Do you want to save your listing?", preferredStyle: .alert);
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action) in
            //save
            self.dismiss(animated: true, completion: nil);
            //            self.navigationController?.popToRootViewController(animated: true);
        }))
        alert.addAction(UIAlertAction(title: "Discard", style: .destructive, handler: { (action) in
            //not save
            self.dismiss(animated: true, completion: nil);
            //            self.navigationController?.popToRootViewController(animated: true);
        }))
        self.present(alert, animated: true, completion: nil);
    }
    
    func setAddressData(address: String, zipcode: String, city: String, country: String) {
        var count = 0;
        while(count < titles.count){
             let cell = self.collectionView?.cellForItem(at: IndexPath(item: count, section: 0)) as! LocationPageCell;
            switch(count){//0: Country, 1: Address, 2: City, 3: Zipcode
            case 0: cell.infoField.text = country;break;
            case 1: cell.infoField.text = address;break;
            case 2: cell.infoField.text = city;break;
            case 3: cell.infoField.text = zipcode;break;
            default:break;
            }
            count += 1;
        }
    }

    
    fileprivate func showEmptyAlert(){
        let alert = UIAlertController(title: "Oops!", message: "You must fill out all fields!", preferredStyle: .alert);
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil));
        self.present(alert, animated: true, completion: nil);
    }
    
    func handleEnterStreet() {
        
        
        
        let layout = UICollectionViewFlowLayout();
        let addressPage = AskForAddressPage(collectionViewLayout: layout);
        
        addressPage.addressPageDelegate = self;
        
        let navigationController = UINavigationController(rootViewController: addressPage);
        navigationController.navigationBar.isTranslucent = false;
        navigationController.navigationBar.barStyle = .blackTranslucent;
        navigationController.navigationBar.tintColor = UIColor.white;
        navigationController.navigationBar.barTintColor = UIColor.appBlue;
        self.present(navigationController, animated: true, completion: nil);

    }
}
