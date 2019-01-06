//
//  FiltersPriceCell.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/6/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

class FiltersPriceCell: UICollectionViewCell{
    
    var priceList: PriceCollectionView = {
        let layout = UICollectionViewFlowLayout();
        let priceList = PriceCollectionView(frame: .zero, collectionViewLayout: layout);
        return priceList;
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = UIColor.white;
        setupPriceList();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setupPriceList(){
        self.addSubview(priceList);
        priceList.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true;
        priceList.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true;
        priceList.topAnchor.constraint(equalTo: self.topAnchor).isActive = true;
        priceList.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true;
    }
    
}
