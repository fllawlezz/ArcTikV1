//
//  ReviewImagesCell.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/22/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

class ReviewImagesCell: UICollectionViewCell{
    
    var imagesList: ReviewImagesCollectionView = {
        let layout = UICollectionViewFlowLayout();
        layout.scrollDirection = .horizontal;
        layout.itemSize = CGSize(width: 150, height: 170);
        let imagesList = ReviewImagesCollectionView(frame: .zero, collectionViewLayout: layout);
        return imagesList;
    }()
    
    var images:[UIImage]?{
        didSet{
            self.imagesList.images = images!;
            self.imagesList.reloadData();
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = UIColor.white;
        setupImagesList();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setupImagesList(){
        self.addSubview(imagesList);
        imagesList.anchor(left: self.leftAnchor, right: self.rightAnchor, top: self.topAnchor, bottom: self.bottomAnchor, constantLeft: 10, constantRight: -10, constantTop: 0, constantBottom: 0, width: 0, height: 0);
    }
    
}
