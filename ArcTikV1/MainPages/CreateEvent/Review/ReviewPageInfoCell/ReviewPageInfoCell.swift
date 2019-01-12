//
//  ReviewPageInfoCell.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/11/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

class ReviewPageInfoCell: UICollectionViewCell{
    
    var titleLabel: NormalUILabel = {
        let titleLabel = NormalUILabel(textColor: .darkGray, font: .montserratSemiBold(fontSize: 16), textAlign: .left);
        titleLabel.text = "Sample Text";
        return titleLabel;
    }()
    
    var infoField: NormalUITextField = {
        let infoField = NormalUITextField();
        infoField.translatesAutoresizingMaskIntoConstraints = false;
        infoField.font = UIFont.systemFont(ofSize: 14);
        infoField.textColor = UIColor.darkText;
        infoField.isUserInteractionEnabled = false;
        return infoField;
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
        setupInfoField();
        setupBorder();
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setupTitleLabel(){
        self.addSubview(titleLabel);
        titleLabel.anchor(left: self.leftAnchor, right: self.rightAnchor, top: self.topAnchor, bottom: nil, constantLeft: 25, constantRight: -25, constantTop: 5, constantBottom: 0, width: 0, height: 30);
    }
    
    fileprivate func setupInfoField(){
        self.addSubview(infoField);
        infoField.anchor(left: self.titleLabel.leftAnchor, right: self.titleLabel.rightAnchor, top: self.titleLabel.bottomAnchor, bottom: nil, constantLeft: 0, constantRight: 0, constantTop: 5, constantBottom: 0, width: 0, height: 30);
    }
    
    fileprivate func setupBorder(){
        self.addSubview(border);
        border.anchor(left: self.leftAnchor, right: self.rightAnchor, top: nil, bottom: self.bottomAnchor, constantLeft: 25, constantRight: 0, constantTop: 0, constantBottom: 0, width: 0, height: 0.4);
    }
    
    func setTitle(title: String){
        self.titleLabel.text = title;
    }
    
    func setInfoFieldText(text: String){
        self.infoField.text = text;
    }
}
