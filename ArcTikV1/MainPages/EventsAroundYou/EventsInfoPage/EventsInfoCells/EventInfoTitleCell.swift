//
//  TitleCell.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/13/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

class EventInfoTitleCell: UICollectionViewCell{
    
    var titleLabel: NormalUILabel = {
        let titleLabel = NormalUILabel(textColor: .darkText, font: .montserratSemiBold(fontSize: 18), textAlign: .left);
        titleLabel.numberOfLines = 2;
        titleLabel.text = "Title goes here";
        return titleLabel;
    }()
    
    var border: UIView = {
        let border = UIView();
        border.translatesAutoresizingMaskIntoConstraints = false;
        border.backgroundColor = UIColor.lightGray;
        return border;
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = UIColor.white;
        setupTitleLabel();
        setupBorder();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setupTitleLabel(){
        self.addSubview(titleLabel);
        titleLabel.anchor(left: self.leftAnchor, right: self.rightAnchor, top: self.topAnchor, bottom: self.bottomAnchor, constantLeft: 25, constantRight: -25, constantTop: 10, constantBottom: 0, width: 0, height: 0);
    }
    
    fileprivate func setupBorder(){
        self.addSubview(border);
        border.anchor(left: self.leftAnchor, right: self.rightAnchor, top: nil, bottom: self.bottomAnchor, constantLeft: 25, constantRight: 0, constantTop: 0, constantBottom: 0, width: 0, height: 0.4);
    }
    
    func setTitle(title:String){
        self.titleLabel.text = title;
    }
    
}
