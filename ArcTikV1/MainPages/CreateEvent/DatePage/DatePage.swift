//
//  DatePage.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/11/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

let resignDatePageNotification = "resignDatePageNotification";

class DatePage: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var nextButton: NormalUIButton = {
        let nextButton = NormalUIButton(type: .system);
        nextButton.setButtonProperties(backgroundColor: .appBlue, title: "Next", font: .montserratSemiBold(fontSize: 14), fontColor: .white)
        return nextButton;
    }()
    
    let datePageReuse = "DatePageReuse"
    let datePageHeaderReuse = "DatePageHeaderReuse";
    
    let cellTitles = ["Start Date","End Date", "Start Time","End Time"];
    let placeholderTitles = ["eg: 1/1/1111","eg: 1/2/1111","eg: 1:00pm","eg 2:00pm"];
    let headerTitles = ["What date(s) does the event take place?","What time does your event start and end?"];
    
    let datePicker = UIDatePicker();
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        setCurrentEventData();
        setupNavBar();
        self.collectionView?.isScrollEnabled = true;
        self.collectionView?.backgroundColor = UIColor.white;
        self.collectionView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.touchCollectionView)));
        self.collectionView!.register(DatePageCell.self, forCellWithReuseIdentifier: datePageReuse);
        self.collectionView?.register(CreateEventMainHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: datePageHeaderReuse)
        setupNextButton();
        // Do any additional setup after loading the view.
    }
    fileprivate func setCurrentEventData(){
//        currentEvent?.stepNumber = 5;
        currentEventInProgress?.step = 5;
        PersistenceManager.shared.save();
        
        let createEventName = Notification.Name(rawValue: reloadCreateEventPage);
        NotificationCenter.default.post(name: createEventName, object: nil);
        
        //set the time stamps
        let name = Notification.Name(rawValue: reloadOverViewPage);
        NotificationCenter.default.post(name: name, object: nil);
    }
    
    fileprivate func setupNavBar(){
        let clearButton = UIBarButtonItem(image: UIImage(named: "clearWhiteNav"), style: .plain, target: self, action: #selector(self.handleClearPressed));
        self.navigationItem.leftBarButtonItem = clearButton;
    }
    
    fileprivate func setupNextButton(){
        
        self.view.addSubview(nextButton);
        nextButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -10).isActive = true;
        nextButton.widthAnchor.constraint(equalToConstant: 100).isActive = true;
        nextButton.heightAnchor.constraint(equalToConstant: 40).isActive = true;
        
        if(UIScreenHeight! == 812.0){// iphone x
            nextButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -(self.view.frame.height/3)+50).isActive = true;
        }else if(UIScreenHeight! == 736){//iphone 6s+,7s+
            nextButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -(self.view.frame.height/3)+80).isActive = true;
        }else if(UIScreenHeight! > 812.0){//iphone XR and Up
            nextButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -(self.view.frame.height/3)).isActive = true;
        }else{//iphone 6s,7s,etc
//            nextButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -(self.view.frame.height/3)+).isActive = true;
            nextButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -100).isActive = true;
        }
        
        nextButton.addTarget(self, action: #selector(self.handleNextButtonPressed), for: .touchUpInside);
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 2
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: datePageReuse, for: indexPath) as! DatePageCell
        if(indexPath.section == 0){
            cell.setTitle(title: self.cellTitles[indexPath.item], placeholder: placeholderTitles[indexPath.item]);
            
                if let event = currentEventInProgress{
                    if(indexPath.item == 0){
                        cell.infoField.text = event.startDate;
                    }else{
                        cell.infoField.text = event.endDate;
                    }
                }
            
            
            cell.setDatePicker();
        }else{
            cell.setTitle(title: self.cellTitles[indexPath.item + 2], placeholder: placeholderTitles[indexPath.item + 2])
            
            if let event = currentEventInProgress{
                if(indexPath.item == 0){
                    cell.infoField.text = event.startTime;
                }else{
                    cell.infoField.text = event.endTime;
                }
            }
            
            cell.setTimePicker();
        }
        // Configure the cell
    
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 70);
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: datePageHeaderReuse, for: indexPath) as! CreateEventMainHeader
        header.setTitle(title: headerTitles[indexPath.section]);
        return header;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 70);
    }
}

extension DatePage{
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
    
    @objc func touchCollectionView(){
        let name = Notification.Name(rawValue: resignDatePageNotification);
        NotificationCenter.default.post(name: name, object: nil);
        
    }
    
    func checkIsEmpty()->Bool{
        var isEmpty = false;
        var count = 0;
        while(count<2){
            let cell = collectionView?.cellForItem(at: IndexPath(item: count, section: 0)) as! DatePageCell;
            let cell2 = collectionView?.cellForItem(at: IndexPath(item: count, section: 1)) as! DatePageCell;
            
            if(cell.infoField.text?.count == 0 || cell2.infoField.text?.count == 0){
                isEmpty = true;
            }
            count+=1;
        }
        return isEmpty;
    }
    
    func populateFields(){
        
    }

    
    @objc func handleNextButtonPressed(){
        let isEmpty = checkIsEmpty();
        if(isEmpty){
            //show error alert
            self.showEmptyAlert();
        }else{
            let cell = collectionView?.cellForItem(at: IndexPath(item: 0, section: 0)) as! DatePageCell;
            let cell2 = collectionView?.cellForItem(at: IndexPath(item: 1, section: 0)) as! DatePageCell;
            
            let cell3 = collectionView?.cellForItem(at: IndexPath(item: 0, section: 1)) as! DatePageCell;
            let cell4 = collectionView?.cellForItem(at: IndexPath(item: 1, section: 1)) as! DatePageCell;
            
//            currentEvent?.startDate = cell.infoField.text!
//            currentEvent?.endDate = cell2.infoField.text!;
//            currentEvent?.startTime = cell3.infoField.text!;
//            currentEvent?.endTime = cell4.infoField.text!;
            
            currentEventInProgress?.startDate = cell.infoField.text!;
            currentEventInProgress?.endDate = cell2.infoField.text!;
            currentEventInProgress?.startTime = cell3.infoField.text!;
            currentEventInProgress?.endTime = cell4.infoField.text!;
            
            PersistenceManager.shared.save();
            
            let pricingPage = PricingPage();
            self.navigationController?.pushViewController(pricingPage, animated: true);
        }
    }
    
    func showEmptyAlert(){
        let alert = UIAlertController(title: "Oops!", message: "There are empty fields! Please fill out all fields!", preferredStyle: .alert);
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil));
        self.present(alert, animated: true, completion: nil);
    }
}
