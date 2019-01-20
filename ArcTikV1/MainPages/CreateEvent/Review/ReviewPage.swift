//
//  ReviewPage.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/11/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

class ReviewPage: UICollectionViewController, UICollectionViewDelegateFlowLayout, CreateEventButtonCellDelegate, ReviewPageDescriptionCellDelegate{
    
    let headerReuse = "ReviewPageHeaderCell";
    let descriptionCellReuse = "ReviewPageDescriptionCellReuse";
    let reviewInfoCellReuse = "ReviewInfoCellReuse";
    let createEventButtonReuse = "CreateEventButtonReuse";
    let toListReuse = "CreateEventToListReuse";
    let titleCell = "CreateEventTitleLabel";
    
    let headerTitles = [
        "Description",
        "Location",
        "Privacy/People",
        "Dates and Times",
        "Charge"
    ]
    
    let reviewPageInfoCellTitles = ["Location","Public/Private","Number of People"];
    let reviewPageInfoFieldText = ["1234 my house", "Public","80"]
    let datesTitles = ["Start Date","End Date","Start Time","End Time"];
    let datesInfo = ["1/11/2019","2/1/2019","1:00pm","3:00pm"];
    
    var descriptionText = "Hi everybody, as one of the best poker players on the planet, I am hosting a poker tournament within my home. The buy in is $60, and the prize pool is $5,000. We will only host if at least 90 people sign up!asdofjaosdt aokstdjaojdtokajkotj asodj toajsdoktjaodstj aojt oajtdokajsdot jaoksdjt okaj toajto jaoksdjtokasjdt okajsokdt jakotj oajtdokdajo tdjaosjtdokajtdok ajsokdt jaokstj okat jaoktj aoksdjtoka js taojtokasjdt oajt koajtd oajoktd jaoksdtj okajt okajsdotkjadokdtjakotj koasjt koas jtokasjtd "
    
    var requirementsText = "- Not Jason Koon \n - Able to play poker \n- Knows the game well\n- Not Phil Hellmuth \n- Yes Phil Hellmuth \n- Yes Tom Dwan \n- Not Andrew Robl \n - Not Elton Tsang \n - Not the president"
    
    var descriptionIsExpanded = false;
    var estimatedFrameSize:CGSize?;
    
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
    }
    
    fileprivate func setCurrentEventData(){
        currentEvent?.stepNumber = 9;
        let name = Notification.Name(rawValue: reloadCreateEventPage);
        NotificationCenter.default.post(name: name, object: nil);
    }
    
    fileprivate func setupNavBar(){
        let clearButton = UIBarButtonItem(image: UIImage(named: "clearWhiteNav"), style: .plain, target: self, action: #selector(self.handleClearPressed));
        self.navigationItem.leftBarButtonItem = clearButton;
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(indexPath.section == 0){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: titleCell, for: indexPath) as! ReviewPageTitleCell
            cell.setTitle(title: currentEvent!.eventTitle!);
            return cell;
        }
        
        if(indexPath.section == 1){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: descriptionCellReuse, for: indexPath) as! ReviewPageDescriptionCell;//description cell
            cell.delegate = self;
            cell.isExpanded = self.descriptionIsExpanded;
            cell.setDescription(description: currentEvent!.description!);
            return cell;
        }
        if(indexPath.section == 2){
            if(indexPath.item == 0){
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reviewInfoCellReuse, for: indexPath) as! ReviewPageInfoCell
                cell.setTitle(title: reviewPageInfoCellTitles[indexPath.item]);
                let infoString = "\(currentEvent!.street!), \(currentEvent!.city!)"
                cell.setInfoFieldText(text: infoString);
                return cell;
            }
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: toListReuse, for: indexPath) as! ReviewPageListCell
            cell.setDescriptionText(description: "Requirements");
            return cell;
        }
        
        if(indexPath.section == 5 && indexPath.item == 1){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: toListReuse, for: indexPath) as! ReviewPageListCell
            cell.setDescriptionText(description: "Things To Bring");
            return cell;
        }
        
        if(indexPath.section == 6 && indexPath.item == 0){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: createEventButtonReuse, for: indexPath) as! CreateEventButtonCell
            cell.delegate = self;
            return cell;
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reviewInfoCellReuse, for: indexPath) as! ReviewPageInfoCell
        
        if(indexPath.section == 3 && indexPath.item == 0){
            
            cell.setTitle(title: "Public/Private");
            cell.setInfoFieldText(text: currentEvent!.privacy!);
//            cell.setInfoFieldText(text: reviewPageInfoFieldText[indexPath.item+1]);
        }
        
        if(indexPath.section == 3 && indexPath.item == 1){
            cell.setTitle(title: "Number of People");
            cell.setInfoFieldText(text: "\(currentEvent!.people!)");
        }

        if(indexPath.section == 4){
            cell.setTitle(title: datesTitles[indexPath.item]);
            switch(indexPath.item){
            case 0: cell.setInfoFieldText(text: currentEvent!.startDate!);break;
            case 1: cell.setInfoFieldText(text: currentEvent!.endDate!);break;
            case 2: cell.setInfoFieldText(text: currentEvent!.startTime!);break;
            case 3: cell.setInfoFieldText(text: currentEvent!.endTime!);break;
            default: break;
            }
        }

        if(indexPath.section == 5){
            cell.setTitle(title: "Charge");
            cell.setInfoFieldText(text: "$\(currentEvent!.charge!)");
        }
        
        return cell;
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 7;
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(section == 4){
            return 4;
        }
        
        if(section == 2 || section == 5 || section == 3){
            return 2;
        }
        return 1;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if(indexPath.section == 1){
            if(descriptionIsExpanded){
                if let height = self.estimatedFrameSize?.height{
                    return CGSize(width: self.view.frame.width, height: height+60);
                }
                return CGSize(width: self.view.frame.width, height: 280);
            }
            
            return CGSize(width: self.view.frame.width, height: 150);
        }
        
        if((indexPath.section == 2 && indexPath.item == 1) || (indexPath.section == 5 && indexPath.item == 1)){
            return CGSize(width: self.view.frame.width, height: 60)
        }
        
        if(indexPath.section == 4){
            return CGSize(width: self.view.frame.width/2, height: 80);
        }
        
        if(indexPath.section == 6 && indexPath.item == 1){
            return CGSize(width: self.view.frame.width, height: 100);
        }
        
        return CGSize(width: self.view.frame.width, height: 80);
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if(section < 6 && section != 0){
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
    
    func handleCreatePressed(){
        //create event
        self.dismiss(animated: true, completion: nil);
    }
    
    func seeMoreDescription() {
        descriptionIsExpanded = true;
        
        let cell = collectionView?.cellForItem(at: IndexPath(item: 0, section: 0)) as! ReviewPageDescriptionCell
        let size = CGSize(width: self.view.frame.width-20, height: .infinity)
        self.estimatedFrameSize = cell.descriptionTextView.sizeThatFits(size)
        
        if(descriptionIsExpanded){
            UIView.animate(withDuration: 0.3) {
                self.collectionView?.reloadItems(at: [IndexPath(item: 0, section: 0)]);
            }
            
        }
    }
}
