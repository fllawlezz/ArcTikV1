//
//  ChatCell.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/8/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

class ChatCell: UITableViewCell{
    
    var senderNameLabel:UILabel = {
        let senderNameLabel = NormalUILabel(textColor: .gray, font: .montserratMedium(fontSize: 12), textAlign: .left);
        senderNameLabel.translatesAutoresizingMaskIntoConstraints = false;
        senderNameLabel.text = "Lebron";
        return senderNameLabel;
    }()
    var messageLabel = UILabel();
    var bubbleBackgroundView = UIView();
    
    var leftConstraint: NSLayoutConstraint!;
    var rightConstraint: NSLayoutConstraint!;
    var topConstraint: NSLayoutConstraint!;
    
    var message: Message?;
    
    var isIncoming: Bool!{
        didSet{
            bubbleBackgroundView.backgroundColor = isIncoming ? .veryLightGray : .appBlue; //false : true
            messageLabel.textColor = isIncoming ? .darkText : .white;
            
            if(isIncoming){//from another person
                self.rightConstraint.isActive = false;
                self.leftConstraint.isActive = false;
                
                self.leftConstraint.isActive = true;
                
            }else{
                self.leftConstraint.isActive = false;
                self.rightConstraint.isActive = false;
                
                self.rightConstraint.isActive = true;
            }
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        self.isUserInteractionEnabled = false;
        self.backgroundColor = UIColor.white;
        
        setupNameLabel();
        
        messageLabel.translatesAutoresizingMaskIntoConstraints = false;
        bubbleBackgroundView.translatesAutoresizingMaskIntoConstraints = false;
        
        messageLabel.numberOfLines = 0;
        messageLabel.font = UIFont.montserratRegular(fontSize: 14);
        
        bubbleBackgroundView.backgroundColor = UIColor.veryLightGray;
        bubbleBackgroundView.layer.cornerRadius = 10;
        
        self.addSubview(bubbleBackgroundView);
        
        self.addSubview(messageLabel);
        setupMessageAndBackground();
        leftConstraint = messageLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20);
        leftConstraint.isActive = true;
        rightConstraint = messageLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20);
        rightConstraint.isActive = false;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    func setMessageText(message: String){
        self.messageLabel.text = message;
    }
    
    func setupNameLabel(){
        self.addSubview(senderNameLabel);
        senderNameLabel.anchor(left: self.leftAnchor, right: self.rightAnchor, top: self.topAnchor, bottom: nil, constantLeft: 15, constantRight: -10, constantTop: 0, constantBottom: 0, width: 0, height: 15);
        senderNameLabel.isHidden = true;
    }
    
    func setupMessageAndBackground(){

        topConstraint = messageLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20);
        topConstraint.isActive = true;

        messageLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15).isActive = true;
        messageLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 250).isActive = true;
        
        bubbleBackgroundView.topAnchor.constraint(equalTo: self.messageLabel.topAnchor, constant: -10).isActive = true;
        bubbleBackgroundView.leftAnchor.constraint(equalTo: self.messageLabel.leftAnchor, constant: -10).isActive = true;
        bubbleBackgroundView.rightAnchor.constraint(equalTo: self.messageLabel.rightAnchor, constant: 10).isActive = true;
        bubbleBackgroundView.bottomAnchor.constraint(equalTo: self.messageLabel.bottomAnchor, constant: 10).isActive = true;
    }
    

    
    func setSenderName(senderName: String){
        self.senderNameLabel.text = senderName;
        self.topConstraint.constant = 30;
        senderNameLabel.isHidden = false;
    }
    
    func hideSenderNameLabel(){
        self.senderNameLabel.isHidden = true;
        self.topConstraint.constant = 20;
    }
    
    func setSameSenderConstant(){
        self.topConstraint.constant = 10;
    }
}
