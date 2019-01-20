//
//  ReviewPageTitleCell.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/20/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

class ReviewPageTitleCell: UICollectionViewCell{
    
    var titleLabel: NormalUILabel = {
        let titleLabel = NormalUILabel(textColor: .darkText, font: .montserratSemiBold(fontSize: 18), textAlign: .left);
        titleLabel.numberOfLines = 0;
        titleLabel.text = "Title Goes here";
        return titleLabel;
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        setupTitleLabel();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setupTitleLabel(){
        self.addSubview(titleLabel);
        titleLabel.anchor(left: self.leftAnchor, right: self.rightAnchor, top: self.topAnchor, bottom: self.bottomAnchor, constantLeft: 25, constantRight: -25, constantTop: 0, constantBottom: 0, width: 0, height: 0);
    }
    
    func setTitle(title: String){
        self.titleLabel.text = title;
    }
}
