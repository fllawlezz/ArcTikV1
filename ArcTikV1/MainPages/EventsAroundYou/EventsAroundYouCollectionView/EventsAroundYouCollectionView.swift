//
//  EventsAroundYouCollectionView.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/3/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

protocol EventsAroundYouCollectionViewDelegate{
    func handleToEventsInfoPage(event:Event);
    func handleProfileImagePressed();
}

class EventsAroundYouCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, EventsAroundYouCellDelegate, EventsAroundYouImageCellDelegate{
    
    let eventsReuse = "eventsReuse";
    let eventsImageReuse = "eventsImageReuse";
    
    var events = [Event]();
    
    var eventsAroundYouDelegate: EventsAroundYouCollectionViewDelegate?;
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout);
        
        self.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.backgroundColor = UIColor.veryLightGray;
        self.alwaysBounceVertical = true;
        self.delegate = self;
        self.dataSource = self;
        self.register(EventsAroundYouCell.self, forCellWithReuseIdentifier: eventsReuse);
        self.register(EventsAroundYouImageCell.self, forCellWithReuseIdentifier: eventsImageReuse);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return events.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let event = self.events[indexPath.item];
        if(event.cellImage != nil){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: eventsImageReuse, for: indexPath) as! EventsAroundYouImageCell
            cell.delegate = self;
            cell.cellEvent = event;
            return cell;
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: eventsReuse, for: indexPath) as! EventsAroundYouCell
            cell.delegate = self;
            cell.cellEvent = events[indexPath.item];
            return cell;
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let event = events[indexPath.item];
        if(event.cellImage != nil){
            return CGSize(width: self.frame.width-20, height: 240);
        }else{
            if(event.eventDescription!.count < 100){
                return CGSize(width: self.frame.width-20, height: 180);
            }
            return CGSize(width: self.frame.width-20, height: 200);
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        eventsAroundYouDelegate?.handleToEventsInfoPage(event: self.events[indexPath.item]);
    }
}

extension EventsAroundYouCollectionView{
    func handleProfileImagePressed() {
        eventsAroundYouDelegate?.handleProfileImagePressed();
    }
    
    func handlePosterImageViewPressed() {
        eventsAroundYouDelegate?.handleProfileImagePressed();
    }
    
    
}
