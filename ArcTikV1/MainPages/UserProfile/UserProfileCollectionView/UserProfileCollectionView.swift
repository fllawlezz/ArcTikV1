//
//  UserProfileCollectionView.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/5/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

class UserProfileCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    let cellReuse = "userProfileCollectionViewCell";
    
    let cellTitles = ["Your Friends (186)", "Past Events", "Account Info", "Settings"];
    let cellDescriptions = ["Requests: 2", "View your past events", "View/Edit your account information", "Change your app Settings"];
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout);
        
        self.contentInset = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.delegate = self;
        self.dataSource = self;
        self.register(UserProfileCollectionViewCell.self, forCellWithReuseIdentifier: cellReuse);
        self.backgroundColor = UIColor.white;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuse, for: indexPath) as! UserProfileCollectionViewCell;
        cell.setTitle(title: cellTitles[indexPath.item]);
        cell.setDescription(description: cellDescriptions[indexPath.item]);
        return cell;
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width, height: 70);
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
    
}
