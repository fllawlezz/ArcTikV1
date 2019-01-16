//
//  EventsInfoToBringPage.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/15/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

class EventsInfoToBringPage: UICollectionViewController, UICollectionViewDelegateFlowLayout{
    
    let headerReuse = "ToBringPageHeaderReuse"
    let cellReuse = "ToBringPageCellReuse";
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.collectionView?.backgroundColor = UIColor.white;
        self.collectionView?.register(EventsInfoRequirementsCell.self, forCellWithReuseIdentifier: cellReuse);
        self.collectionView?.register(EventsInfoRequirementsPageHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerReuse);
        setupNavBar()
    }
    
    fileprivate func setupNavBar(){
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "clearWhiteNav"), style: .plain, target: self, action: #selector(self.handleClearPressed));
        self.navigationItem.leftBarButtonItem = backButton;
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuse, for: indexPath) as! EventsInfoRequirementsCell;
        cell.setTitle(text: "$60");
        return cell;
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 50);
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 50);
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerReuse, for: indexPath) as! EventsInfoRequirementsPageHeader
        header.setTitle(text: "Things to Bring");
        return header;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
    
}

extension EventsInfoToBringPage{
    @objc func handleClearPressed(){
        self.dismiss(animated: true, completion: nil);
    }
}
