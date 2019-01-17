//
//  CreatedEventsNewEvent.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/17/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

class CreatedEventsNewEventCell: UICollectionViewCell{
    
    var titleLabel: NormalUILabel = {
        let titleLabel = NormalUILabel(textColor: .darkText, font: .montserratMedium(fontSize: 12), textAlign: .left);
        titleLabel.text = "Create a new Event";
        return titleLabel;
    }()
    
    var plusImageView: UIImageView = {
        let plusImageView = UIImageView(image: #imageLiteral(resourceName: "plus"));
        plusImageView.translatesAutoresizingMaskIntoConstraints = false;
        plusImageView.contentMode = .scaleAspectFill;
        return plusImageView;
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = UIColor.white;
        self.layer.borderColor = UIColor.veryLightGray.cgColor;
        self.layer.borderWidth = 0.4;
        setupTitleLabel();
        setupPlusImageView();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setupTitleLabel(){
        self.addSubview(titleLabel);
        titleLabel.anchor(left: self.leftAnchor, right: self.rightAnchor, top: nil , bottom: nil, constantLeft: 25, constantRight: -40, constantTop: 0, constantBottom: 0, width: 0, height: 30);
        titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true;
    }
    
    fileprivate func setupPlusImageView(){
        self.addSubview(plusImageView);
        plusImageView.anchor(left: nil, right: self.rightAnchor, top: nil, bottom: nil, constantLeft: 0, constantRight: -10, constantTop: 0, constantBottom: 0, width: 15, height: 15);
        plusImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true;
    }
}
