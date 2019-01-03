//
//  EventsAroundYouCollectionView.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/3/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

class EventsAroundYouCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    let eventsReuse = "eventsReuse";
    let eventsImageReuse = "eventsImageReuse";
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout);
        
        self.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: -10, right: 0)
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.backgroundColor = UIColor.veryLightGray;
        self.delegate = self;
        self.dataSource = self;
        self.register(EventsAroundYouCell.self, forCellWithReuseIdentifier: eventsReuse);
        self.register(EventsAroundYouImageCell.self, forCellWithReuseIdentifier: eventsImageReuse);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(indexPath.item == 1){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: eventsReuse, for: indexPath) as! EventsAroundYouCell
            return cell;
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: eventsImageReuse, for: indexPath) as! EventsAroundYouImageCell
            return cell;
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width-20, height: 170);
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
}
