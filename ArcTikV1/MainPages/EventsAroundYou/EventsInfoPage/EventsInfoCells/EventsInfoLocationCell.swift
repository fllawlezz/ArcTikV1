//
//  EventsInfoLocationCell.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/13/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

class EventsInfoLocationCell: UICollectionViewCell{
    
    var locationLabel: NormalUILabel = {
        let locationLabel = NormalUILabel(textColor: .darkText, font: .montserratRegular(fontSize: 14), textAlign: .left);
        locationLabel.text = "Location goes here";
        locationLabel.numberOfLines = 2;
        return locationLabel;
    }()
    
    var warningLabel: NormalUILabel = {
        let warningLabel = NormalUILabel(textColor: .darkText, font: .montserratRegular(fontSize: 12), textAlign: .right);
        warningLabel.text = "(Address revealed after accepted)";
        warningLabel.numberOfLines = 2;
        return warningLabel;
    }()
    
    var border = BorderView();
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = UIColor.white;
        setupLocationLabel();
        setupWarningLabel();
        setupBorder();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setupLocationLabel(){
        self.addSubview(locationLabel);
        locationLabel.anchor(left: self.leftAnchor, right: self.rightAnchor, top: self.topAnchor, bottom: nil, constantLeft: 25, constantRight: -25, constantTop: 15, constantBottom: 0, width: 0, height: 30);
    }
    
    fileprivate func setupWarningLabel(){
        self.addSubview(warningLabel);
//        warningLabel.backgroundColor = UIColor.red;
        warningLabel.anchor(left: nil, right: self.rightAnchor, top: nil, bottom: self.bottomAnchor, constantLeft: 0, constantRight: -10, constantTop: 0, constantBottom: -10, width: 200, height: 20);
    }
    
    fileprivate func setupBorder(){
        self.addSubview(border);
        border.anchor(left: self.leftAnchor, right: self.rightAnchor, top: nil, bottom: self.bottomAnchor, constantLeft: 25, constantRight: 0, constantTop: 0, constantBottom: 0, width: 0, height: 0.4);
    }
    
    func setLocation(location: String){
        self.locationLabel.text = location;
    }
}
