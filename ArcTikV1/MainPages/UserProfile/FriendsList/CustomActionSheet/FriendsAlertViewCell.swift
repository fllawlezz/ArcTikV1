//
//  FriendsAlertViewCel.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/9/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

class FriendsAlertViewCell: UIView{
    
    var titleLabel: NormalUILabel = {
        let titleLabel = NormalUILabel(textColor: .white, font: .montserratSemiBold(fontSize: 14), textAlign: .center);
        titleLabel.text = "Message this person";
        titleLabel.backgroundColor = UIColor.appBlue;
        return titleLabel;
    }()
    
    var messageLabel: NormalUILabel = {
        let messageLabel = NormalUILabel(textColor: .darkText, font: .montserratRegular(fontSize: 14), textAlign: .center);
        messageLabel.text = "Would you like to message this person?";
        messageLabel.numberOfLines = 2;
//        messageLabel.backgroundColor = UIColor.red;
        return messageLabel;
    }()
    
    var buttonBorderTop: UIView = {
        let buttonBorderTop = UIView();
        buttonBorderTop.translatesAutoresizingMaskIntoConstraints = false;
        buttonBorderTop.backgroundColor = UIColor.lightGray;
        return buttonBorderTop;
    }()
    
    var yesButton: NormalUIButton = {
        let yesButton = NormalUIButton(type: .system);
        yesButton.setButtonProperties(backgroundColor: .appBlue, title: "Yes", font: .montserratSemiBold(fontSize: 16), fontColor: .white);
        yesButton.layer.cornerRadius = 0;
        return yesButton;
    }()
    
    var buttonBorderMiddle: UIView = {
        let buttonBorderMiddle = UIView();
        buttonBorderMiddle.translatesAutoresizingMaskIntoConstraints = false;
        buttonBorderMiddle.backgroundColor = UIColor.lightGray;
        return buttonBorderMiddle;
    }()
    
    var noButton: NormalUIButton = {
        let noButton = NormalUIButton(type: .system);
        noButton.setButtonProperties(backgroundColor: .white, title: "No", font: .montserratSemiBold(fontSize: 16), fontColor: .darkText);
        noButton.layer.cornerRadius = 0;
        noButton.layer.borderColor = UIColor.darkText.cgColor;
//        noButton.layer.borderWidth = 1;
        return noButton;
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = UIColor.white;
        self.clipsToBounds = true;
        self.layer.cornerRadius = 5;
        self.translatesAutoresizingMaskIntoConstraints = false;
        setupTitleLabel();
        setupMessageLabel();
        setupYesButton();
        setupButtonBorderTop()
        setupNoButton()
        setupButtonBorderMiddle();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setupTitleLabel(){
        self.addSubview(titleLabel);
        titleLabel.anchor(left: self.leftAnchor, right: self.rightAnchor, top: self.topAnchor, bottom: nil, constantLeft: 0, constantRight: 0, constantTop: 0, constantBottom: 0, width: 0, height: 50);
    }
    
    fileprivate func setupMessageLabel(){
        self.addSubview(messageLabel);
        messageLabel.anchor(left: self.leftAnchor, right: self.rightAnchor, top: self.titleLabel.bottomAnchor, bottom: nil, constantLeft: 0, constantRight: 0, constantTop: 0, constantBottom: 0, width: 0, height: 60);
    }
    
    fileprivate func setupYesButton(){
        self.addSubview(yesButton);
        yesButton.anchor(left: self.leftAnchor, right: nil, top: nil, bottom: self.bottomAnchor, constantLeft: 0, constantRight: 0, constantTop: 0, constantBottom: 0, width: 125, height: 40);
    }
    
    fileprivate func setupButtonBorderTop(){
        self.addSubview(buttonBorderTop);
        buttonBorderTop.anchor(left: self.leftAnchor, right: self.rightAnchor, top: nil, bottom: self.yesButton.topAnchor, constantLeft: 0, constantRight: 0, constantTop: 0, constantBottom: 0, width: 0, height: 0.3);
    }
    
    fileprivate func setupNoButton(){
        self.addSubview(noButton);
        noButton.anchor(left: nil, right: self.rightAnchor, top: nil, bottom: self.bottomAnchor, constantLeft: 0, constantRight: 0, constantTop: 0, constantBottom: 0, width: 125, height: 40);
    }
    
    fileprivate func setupButtonBorderMiddle(){
        self.addSubview(buttonBorderMiddle);
        buttonBorderMiddle.anchor(left: self.yesButton.rightAnchor, right: self.noButton.leftAnchor, top: self.buttonBorderTop.bottomAnchor, bottom: self.bottomAnchor, constantLeft: -0.2, constantRight: 0.2, constantTop: 0, constantBottom: 0, width: 0, height: 0);
    }
}
