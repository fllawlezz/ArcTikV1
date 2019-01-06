//
//  FiltersCell.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/6/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

class FiltersDistanceCell: UICollectionViewCell{
    
    var distanceList: DistanceCollectionView = {
        let layout = UICollectionViewFlowLayout();
        let distanceList = DistanceCollectionView(frame: .zero, collectionViewLayout: layout);
        return distanceList;
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = UIColor.white;
        setupDistanceList();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setupDistanceList(){
        self.addSubview(distanceList);
        distanceList.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true;
        distanceList.topAnchor.constraint(equalTo: self.topAnchor).isActive = true;
        distanceList.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true;
        distanceList.widthAnchor.constraint(equalToConstant: 350).isActive = true;
    }
    
}
