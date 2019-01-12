//
//  PastEventsPage.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/9/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

class PastEventsPage: UICollectionViewController, UICollectionViewDelegateFlowLayout{
    
    let pastEventsCellReuse = "PastEventsCellReuse";
    let pastEventsHeader = "PastEventsHeaderReuse"
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.collectionView?.backgroundColor = .veryLightGray;
        
        self.collectionView?.register(EventsAroundYouCell.self, forCellWithReuseIdentifier: pastEventsCellReuse);
        self.collectionView?.register(AppliedHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: pastEventsHeader);
        
        setupNavBar();
    }
    
    fileprivate func setupNavBar(){
        self.navigationItem.title = "Past Events";
        
        let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil);
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton;
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false;
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true;
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: pastEventsCellReuse, for: indexPath) as! EventsAroundYouCell;
        return cell;
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2;
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width-20, height: 170);
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.view.frame.width-20, height: 50);
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: pastEventsHeader, for: indexPath) as! AppliedHeader
        if(indexPath.section == 0){
            header.setTitleLabel(title: "Last Week");
        }else if(indexPath.section == 1){
            header.setTitleLabel(title: "Last Month");
        }
        return header;
    }
}
