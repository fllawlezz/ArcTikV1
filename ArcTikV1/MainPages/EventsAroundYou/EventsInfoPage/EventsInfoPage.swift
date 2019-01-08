//
//  EventsInfoPage.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/6/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

class EventsInfoPage: UICollectionViewController, UICollectionViewDelegateFlowLayout, EventsInfoHeaderDelegate, EventsInfoMainCellDelegate{
    
    let headerCellReuse = "EventsInfoReuseHeader";
    let eventsInfoCellReuse = "EventsInfoCellReuse";
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.collectionView?.backgroundColor = UIColor.appBlue;
        collectionView?.delegate = self;
        collectionView?.dataSource = self;
        collectionView?.register(EventsInfoMainCell.self, forCellWithReuseIdentifier: eventsInfoCellReuse);
        self.collectionView?.register(EventsInfoHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerCellReuse);
        collectionView?.contentInsetAdjustmentBehavior = .never;
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent;
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 600)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.view.frame.width, height: self.view.frame.height*(1/3));
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: eventsInfoCellReuse, for: indexPath) as! EventsInfoMainCell
        cell.delegate = self;
        return cell;
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerCellReuse, for: indexPath) as! EventsInfoHeader;
        header.delegate = self;
        return header;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
}

extension EventsInfoPage{
    func handleBack() {
        self.navigationController?.popViewController(animated: true);
    }
    
    func handleApplied(){
        let alert = UIAlertController(title: "Applied!", message: "You have applied to this event! We will send you a notifiation if you are accepted!", preferredStyle: .alert);
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            self.navigationController?.popViewController(animated: true);
        }))
        self.present(alert, animated: true, completion: nil);
    }
    
}

extension EventsInfoPage{
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true;
    }
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false;
    }
}
