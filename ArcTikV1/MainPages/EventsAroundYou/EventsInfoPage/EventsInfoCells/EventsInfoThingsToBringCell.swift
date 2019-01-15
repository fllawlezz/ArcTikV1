//
//  EventsInfoThingsToBringCell.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/15/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

class EventsInfoThingsToBringCell: UICollectionViewCell{
    
    var titleLabel: NormalUILabel = {
        let titleLabel = NormalUILabel(textColor: .darkText, font: .montserratMedium(fontSize: 16), textAlign: .left);
        titleLabel.text = "Things to Bring";
        return titleLabel;
    }()
    
    var rightArrowImageView: UIImageView = {
        let rightArrowImageView = UIImageView(image: #imageLiteral(resourceName: "rightArrow"));
        rightArrowImageView.translatesAutoresizingMaskIntoConstraints = false;
        rightArrowImageView.contentMode = .scaleAspectFill;
        return rightArrowImageView;
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = UIColor.white;
        setupTitleLabel();
        setupRightArrowImageView();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setupTitleLabel(){
        self.addSubview(titleLabel);
        titleLabel.anchor(left: self.leftAnchor, right: self.rightAnchor, top: nil, bottom: nil, constantLeft: 25, constantRight: -50, constantTop: 0, constantBottom: 0, width: 0, height: 30);
        titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true;
        
    }
    
    fileprivate func setupRightArrowImageView(){
        self.addSubview(rightArrowImageView);
        rightArrowImageView.anchor(left: nil, right: self.rightAnchor, top: nil, bottom: nil, constantLeft: 0, constantRight: -10, constantTop: 0, constantBottom: 0, width: 25, height: 25);
        rightArrowImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true;
    }
}
