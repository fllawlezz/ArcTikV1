//
//  ChatCell.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/8/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

class ChatCell: UITableViewCell{
    
    var messageLabel = UILabel();
    var bubbleBackgroundView = UIView();
    
    var leftConstraint: NSLayoutConstraint!;
    var rightConstraint: NSLayoutConstraint!;
    
    var isIncoming: Bool!{
        didSet{
            bubbleBackgroundView.backgroundColor = isIncoming ? .veryLightGray : .appBlue; //false : true
            messageLabel.textColor = isIncoming ? .darkText : .white;
            
            if(isIncoming){//from another person
                self.leftConstraint.isActive = true;
                self.rightConstraint.isActive = false;
            }else{
                self.leftConstraint.isActive = false;
                self.rightConstraint.isActive = true;
            }
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        self.backgroundColor = UIColor.white;
        
        messageLabel.translatesAutoresizingMaskIntoConstraints = false;
        bubbleBackgroundView.translatesAutoresizingMaskIntoConstraints = false;
        
        messageLabel.numberOfLines = 0;
        messageLabel.font = UIFont.montserratRegular(fontSize: 14);
        
        bubbleBackgroundView.backgroundColor = UIColor.veryLightGray;
        bubbleBackgroundView.layer.cornerRadius = 10;
        
        self.addSubview(bubbleBackgroundView);
        
        self.addSubview(messageLabel);
//        messageLabel.anchor(left: self.leftAnchor, right: nil, top: self.topAnchor, bottom: self.bottomAnchor, constantLeft: 20, constantRight: 0, constantTop: 20, constantBottom: -20, width: 250, height: 0);
        setupMessageAndBackground();
        leftConstraint = messageLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20);
        leftConstraint.isActive = false;
        rightConstraint = messageLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20);
        rightConstraint.isActive = true;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    func setMessageText(message: String){
        self.messageLabel.text = message;
    }
    
    func setupMessageAndBackground(){
//        messageLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true;
        messageLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true;
        messageLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20).isActive = true;
        messageLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 250).isActive = true;
        //        setupBackgroundView();
        bubbleBackgroundView.topAnchor.constraint(equalTo: self.messageLabel.topAnchor, constant: -10).isActive = true;
        bubbleBackgroundView.leftAnchor.constraint(equalTo: self.messageLabel.leftAnchor, constant: -10).isActive = true;
        bubbleBackgroundView.rightAnchor.constraint(equalTo: self.messageLabel.rightAnchor, constant: 10).isActive = true;
        bubbleBackgroundView.bottomAnchor.constraint(equalTo: self.messageLabel.bottomAnchor, constant: 10).isActive = true;
    }
    
}
