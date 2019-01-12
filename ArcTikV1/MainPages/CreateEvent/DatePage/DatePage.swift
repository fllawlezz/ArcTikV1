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
        setupNavBar();
        self.collectionView?.isScrollEnabled = true;
        self.collectionView?.backgroundColor = UIColor.white;
        self.collectionView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.touchCollectionView)));
        self.collectionView!.register(DatePageCell.self, forCellWithReuseIdentifier: datePageReuse);
        self.collectionView?.register(CreateEventMainHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: datePageHeaderReuse)
        setupNextButton();
        // Do any additional setup after loading the view.
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
            cell.setDatePicker();
        }else{
            cell.setTitle(title: self.cellTitles[indexPath.item + 2], placeholder: placeholderTitles[indexPath.item + 2])
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

    
    @objc func handleNextButtonPressed(){
        let pricingPage = PricingPage();
        self.navigationController?.pushViewController(pricingPage, animated: true);
    }
}
