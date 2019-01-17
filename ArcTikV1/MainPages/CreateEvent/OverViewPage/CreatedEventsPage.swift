//
//  CreatedEventsPage.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/17/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

class CreatedEventsPage: UICollectionViewController, UICollectionViewDelegateFlowLayout{
    
    let titleHeader = "CreatedEventsTitleHeaderReuse";
    let sectionHeader = "CreatedEventsSectionHeader";
    let cellReuse = "CreatedEventsCellReuse";
    let createNewEventReuse = "CreatedEventsNewEventCellReuse";
    
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
            if(indexPath.item == 0){
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
            return 1+1;
        }
        
        return 0;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if(indexPath.section == 1 && indexPath.item == 1){
            return CGSize(width: self.view.frame.width-40, height: 40);
        }
        
        return CGSize(width: self.view.frame.width-40, height: 100);
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
//        if(indexPath.item == 0){
//            self.handleCreateEvent();
//
//        }
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
        let layout = UICollectionViewFlowLayout();
        let createEventPage = CreateEventPage(collectionViewLayout: layout);
        
        let navigationController = UINavigationController(rootViewController: createEventPage);
        navigationController.navigationBar.isTranslucent = false;
        navigationController.navigationBar.barStyle = .blackTranslucent;
        navigationController.navigationBar.tintColor = UIColor.white;
        navigationController.navigationBar.barTintColor = UIColor.appBlue;
        self.present(navigationController, animated: true, completion: nil);
    }
}
