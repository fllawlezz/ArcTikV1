//
//  CreatedEventSectionHeader.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/17/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

class CreatedEventSectionHeader: UICollectionReusableView{
    
    var titleLabel: NormalUILabel = {
        let titleLabel = NormalUILabel(textColor: .darkText, font: .montserratSemiBold(fontSize: 16), textAlign: .left);
//        titleLabel.backgroundColor = UIColor.white;
        return titleLabel;
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = UIColor.superLightGray;
        setupTitleLabel();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setupTitleLabel(){
        self.addSubview(titleLabel);
        titleLabel.anchor(left: self.leftAnchor, right: self.rightAnchor, top: nil, bottom: nil, constantLeft: 25, constantRight: -25, constantTop: 0, constantBottom: 0, width: 0, height: 50);
        titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true;
    }
    
    func setTitle(title: String){
        self.titleLabel.text = title;
    }
}
