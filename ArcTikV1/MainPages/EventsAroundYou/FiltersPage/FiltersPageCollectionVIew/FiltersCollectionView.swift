//
//  FiltersCollectionView.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/6/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

let resignFiltersCategoryField = "ResignFiltersCategoryField";

class FiltersViewCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    let filtersHeaderReuse = "FiltersReuse";
    let distanceCellReuse = "FiltersDistanceCell";
    let categoryCellReuse = "FiltersCategoryCell";
    let priceCellReuse = "FiltersPriceCell";
    
    let headerTitles = ["Distance", "Category", "Price"];
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout);
        
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = UIColor.veryLightGray;
//        self.backgroundColor = UIColor.red;
        self.register(FiltersDistanceCell.self, forCellWithReuseIdentifier: distanceCellReuse);
        self.register(FiltersCategoryCell.self, forCellWithReuseIdentifier: categoryCellReuse);
        self.register(FiltersPriceCell.self, forCellWithReuseIdentifier: priceCellReuse);
        self.register(FiltersHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: filtersHeaderReuse);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(indexPath.section == 0){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: distanceCellReuse, for: indexPath) as! FiltersDistanceCell
            return cell;
        }else if(indexPath.section == 1){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: categoryCellReuse, for: indexPath) as! FiltersCategoryCell;
            return cell;
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: priceCellReuse, for: indexPath) as! FiltersPriceCell;
            return cell;
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if(indexPath.section == 1){
//            return CGSize(width: 200, height: 40)
            return CGSize(width: 250, height: 40)
        }
        if(indexPath.section == 2){
            return CGSize(width: 280, height: 50);
        }
        
        return CGSize(width: 350, height: 50);
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.frame.width, height: 50);
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: filtersHeaderReuse, for: indexPath) as! FiltersHeader;
        cell.setTitle(title: headerTitles[indexPath.section]);
        return cell;
    }
    
}

extension FiltersViewCollectionView{
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let name = Notification.Name(rawValue: resignFiltersCategoryField);
        NotificationCenter.default.post(name: name, object: nil);
    }
}
