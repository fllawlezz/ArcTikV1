//
//  CreateEventMainCell.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/9/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

class CreateEventMainCell: UICollectionViewCell{
    
    var titleLabel: NormalUILabel = {
        let titleLabel = NormalUILabel(textColor: .darkText, font: .montserratSemiBold(fontSize: 14), textAlign: .left);
        titleLabel.text = "Title goes here";
//        titleLabel.backgroundColor = UIColor.blue;
        return titleLabel;
    }()
    
    var continueButton: NormalUIButton = {
        let continueButton = NormalUIButton(type: .system);
        continueButton.setButtonProperties(backgroundColor: .appBlue, title: "Continue", font: .montserratSemiBold(fontSize: 14), fontColor: .white);
        return continueButton;
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
        setupContinueButton();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setupTitleLabel(){
        self.addSubview(titleLabel);
        titleLabel.anchor(left: self.leftAnchor, right: self.rightAnchor, top: self.topAnchor, bottom: nil, constantLeft: 25, constantRight: 0, constantTop: 0, constantBottom: 0, width: 0, height: 50);
    }
    
    fileprivate func setupBorder(){
        self.addSubview(border);
        border.anchor(left: self.leftAnchor, right: self.rightAnchor, top: nil, bottom: self.bottomAnchor, constantLeft: 25, constantRight: 0, constantTop: 0, constantBottom: 0, width: 0, height: 0.4);
    }
    
    fileprivate func setupContinueButton(){
        self.addSubview(continueButton);
        continueButton.anchor(left: self.titleLabel.leftAnchor, right: nil, top: self.titleLabel.bottomAnchor, bottom: nil, constantLeft: 0, constantRight: 0, constantTop: 0, constantBottom: 0, width: 100, height: 40);
        continueButton.isHidden = true;
    }
    
    func setTitle(title:String){
        self.titleLabel.text = title;
    }
    
    func revealContinueButton(){
        self.continueButton.isHidden = false;
    }
    
    
}
