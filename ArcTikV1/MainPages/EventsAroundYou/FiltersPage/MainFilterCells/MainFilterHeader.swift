//
//  MainFilterHeader.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/15/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

class MainFilterHeader: UICollectionReusableView{
    
    var titleLabel: NormalUILabel = {
        let titleLabel = NormalUILabel(textColor: .darkText, font: .montserratSemiBold(fontSize: 18), textAlign: .left);
        titleLabel.text = "Title goes here";
        return titleLabel;
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = UIColor.white;
//        self.backgroundColor = UIColor.blue;
        setupTitleLabel();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setupTitleLabel(){
        self.addSubview(titleLabel);
        titleLabel.anchor(left: self.leftAnchor, right: self.rightAnchor, top: nil, bottom: nil, constantLeft: 25, constantRight: -25, constantTop: 0, constantBottom: 0, width: 0, height: 30);
        titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true;
    }
    
    func setTitleLabel(text: String){
        self.titleLabel.text = text;
    }
}
