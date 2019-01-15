//
//  StretchyHeaderLayout.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/8/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

class StretchyHeaderLayout: UICollectionViewFlowLayout{
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let layoutAttributes = super.layoutAttributesForElements(in: rect);
        
        layoutAttributes?.forEach({ (attributes) in
            if(attributes.representedElementKind == UICollectionElementKindSectionHeader && attributes.indexPath.section == 0){
                guard let collectionView = collectionView else{ return }
                let width = collectionView.frame.width;
                
                let contentOffSetY = collectionView.contentOffset.y;
//                print(contentOffSetY);
                if(contentOffSetY > 0){
                    return;
                }
                let height = attributes.frame.height - contentOffSetY;
                
                attributes.frame = CGRect(x: 0, y: contentOffSetY, width: width, height: height);
            }
        })
        return layoutAttributes;
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true;
    }
    
}
