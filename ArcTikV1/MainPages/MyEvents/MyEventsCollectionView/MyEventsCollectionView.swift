//
//  MyEventsCollectionView.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/3/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

class MyEventsCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    let cellReuse = "myEventsCellReuse";
    let cellHeader = "myEventsHeader";
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout);
        
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.backgroundColor = UIColor.veryLightGray;
        self.dataSource = self;
        self.delegate = self;
        self.register(EventsAroundYouCell.self, forCellWithReuseIdentifier: cellReuse);
        self.register(AppliedHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: cellHeader);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuse, for: indexPath) as! EventsAroundYouCell;
        return cell;
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width-20, height: 170)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: cellHeader, for: indexPath) as! AppliedHeader
        if(indexPath.section == 1){
            header.setTitleLabel(title: "Pending");
        }
//        header.backgroundColor = UIColor.blue;
        return header;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.frame.width-20, height: 50);
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
//        return CGSize(width: self.frame.width, height: 10);
//    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 20;
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 10;
//    }
    
    
}
