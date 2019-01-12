//
//  ReviewPage.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/11/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

class ReviewPage: UICollectionViewController, UICollectionViewDelegateFlowLayout{
    
    let headerReuse = "ReviewPageHeaderCell";
    let descriptionCellReuse = "ReviewPageDescriptionCellReuse";
    let reviewInfoCellReuse = "ReviewInfoCellReuse";
    let createEventButtonReuse = "CreateEventButtonReuse";
    
    let headerTitles = [
        "Description",
        "Location",
        "Requirements",
        "Privacy/People",
        "Dates and Times",
        "Charge"
    ]
    
    let reviewPageInfoCellTitles = ["Location","Public/Private","Number of People"];
    let reviewPageInfoFieldText = ["1234 my house", "Public","80"]
    let datesTitles = ["Start Date","End Date","Start Time","End Time"];
    let datesInfo = ["1/11/2019","2/1/2019","1:00pm","3:00pm"];
//    let timeTitles = ["Start Time","End Time"];
//    let timeInfo = ["1:00pm","3:00pm"]
    
    var descriptionText = "Hi everybody, as one of the best poker players on the planet, I am hosting a poker tournament within my home. The buy in is $60, and the prize pool is $5,000. We will only host if at least 90 people sign up!"
    
    var requirementsText = "- Not Jason Koon \n - Able to play poker \n- Knows the game well\n- Not Phil Hellmuth \n- Yes Phil Hellmuth \n- Yes Tom Dwan \n- Not Andrew Robl \n - Not Elton Tsang \n - Not the president"
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        collectionView?.backgroundColor = UIColor.white;
        collectionView?.showsVerticalScrollIndicator = false;
        self.collectionView?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0);
        self.collectionView?.register(CreateEventMainHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerReuse);
        self.collectionView?.register(ReviewPageDescriptionCell.self, forCellWithReuseIdentifier: descriptionCellReuse);
        self.collectionView?.register(ReviewPageInfoCell.self, forCellWithReuseIdentifier: reviewInfoCellReuse);
        self.collectionView?.register(CreateEventButtonCell.self, forCellWithReuseIdentifier: createEventButtonReuse);
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(indexPath.section == 0 || indexPath.section == 2){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: descriptionCellReuse, for: indexPath) as! ReviewPageDescriptionCell;
            if(indexPath.section == 0){
                cell.setDescription(description: descriptionText);
            }else{
                cell.setDescription(description: requirementsText);
            }
            return cell;
        }else if(indexPath.section == 5 && indexPath.item == 1){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: createEventButtonReuse, for: indexPath) as! CreateEventButtonCell
            return cell;
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reviewInfoCellReuse, for: indexPath) as! ReviewPageInfoCell
            if(indexPath.section == 1){
                cell.setTitle(title: reviewPageInfoCellTitles[indexPath.item]);
                cell.setInfoFieldText(text: reviewPageInfoFieldText[indexPath.item]);
            }
            if(indexPath.section == 3){
                cell.setTitle(title: reviewPageInfoCellTitles[indexPath.item+1]);
                cell.setInfoFieldText(text: reviewPageInfoFieldText[indexPath.item+1]);
            }
            
            if(indexPath.section == 4){
                cell.setTitle(title: datesTitles[indexPath.item]);
                cell.setInfoFieldText(text: datesInfo[indexPath.item]);
            }
            
            if(indexPath.section == 5){
                cell.setTitle(title: "Charge");
                cell.setInfoFieldText(text: "$60");
            }
            
            return cell;
        }
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 6;
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(section == 3 || section == 5){
            return 2;
        }
        if(section == 4){
            return 4;
        }
        return 1;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if(indexPath.section == 0 || indexPath.section == 2){
            return CGSize(width: self.view.frame.width, height: 115);
        }
        
        if(indexPath.section == 4){
            return CGSize(width: self.view.frame.width/2, height: 80);
        }
        
        if(indexPath.section == 5 && indexPath.item == 1){
            return CGSize(width: self.view.frame.width, height: 100);
        }
        
        return CGSize(width: self.view.frame.width, height: 80);
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 70);
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerReuse, for: indexPath) as! CreateEventMainHeader
        header.setTitle(title: headerTitles[indexPath.section]);
        return header;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
    
}
