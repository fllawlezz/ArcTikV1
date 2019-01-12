//
//  FriendsListCell.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/9/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

protocol FriendRequestCellDelegate{
    func handleFriendRequestImagePressed()
}

class FriendRequestCell: UICollectionViewCell{
    
    var friendImageView: UIImageView = {
        let friendImageView = UIImageView();
        friendImageView.translatesAutoresizingMaskIntoConstraints = false;
        friendImageView.backgroundColor = UIColor.orange;
        friendImageView.clipsToBounds = true;
        friendImageView.contentMode = .scaleAspectFill;
        friendImageView.layer.cornerRadius = 50;
        friendImageView.isUserInteractionEnabled = true;
        return friendImageView;
    }()
    
    var friendNameLabel: NormalUILabel = {
        let friendNameLabel = NormalUILabel(textColor: .darkText, font: .montserratSemiBold(fontSize: 16), textAlign: .left);
        friendNameLabel.text = "Friend Name";
        return friendNameLabel;
    }()
    
    var confirmButton: NormalUIButton = {
        let confirmButton = NormalUIButton(type: .system);
        confirmButton.setButtonProperties(backgroundColor: .appBlue, title: "Confirm", font: .montserratSemiBold(fontSize: 14), fontColor: .white);
        return confirmButton;
    }()
    
    var denyButton: NormalUIButton = {
        let denyButton = NormalUIButton(type: .system);
        denyButton.setButtonProperties(backgroundColor: .white, title: "Deny", font: .montserratSemiBold(fontSize: 14), fontColor: .darkText)
        denyButton.layer.borderColor = UIColor.darkText.cgColor;
        denyButton.layer.borderWidth = 1;
        return denyButton;
    }()
    
    var messageButton: NormalUIButton = {
        let messageButton = NormalUIButton(type: .system);
        messageButton.translatesAutoresizingMaskIntoConstraints = false;
        messageButton.setBackgroundImage(#imageLiteral(resourceName: "chatRoomTab"), for: .normal);
        return messageButton;
    }()
    
    var delegate: FriendRequestCellDelegate?;
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = UIColor.white;
        setupFriendImageView();
        setupFriendNameLabel();
        setupConfirmButton();
        setupDenyButton();
        setupMessageButton();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setupFriendImageView(){
        self.addSubview(friendImageView);
        friendImageView.anchor(left: self.leftAnchor, right: nil, top: self.topAnchor, bottom: self.bottomAnchor, constantLeft: 10, constantRight: 0, constantTop: 10, constantBottom: -10, width: 100, height: 0);
    }
    
    fileprivate func setupFriendNameLabel(){
        self.addSubview(friendNameLabel);
        friendNameLabel.anchor(left: friendImageView.rightAnchor, right: self.rightAnchor, top: self.topAnchor, bottom: nil, constantLeft: 10, constantRight: -10, constantTop: 10, constantBottom: 0, width: 0, height: 50);
    }
    
    fileprivate func setupConfirmButton(){
        self.addSubview(confirmButton);
        confirmButton.anchor(left: friendImageView.rightAnchor, right: nil, top: nil, bottom: friendImageView.bottomAnchor, constantLeft: 10, constantRight: 0, constantTop: 0, constantBottom: 0, width: 100, height: 40);
    }
    
    fileprivate func setupDenyButton(){
        self.addSubview(denyButton);
        denyButton.anchor(left: confirmButton.rightAnchor, right: nil, top: nil, bottom: friendImageView.bottomAnchor, constantLeft: 10, constantRight: 0, constantTop: 0, constantBottom: 0, width: 100, height: 40);
    }
    
    fileprivate func setupMessageButton(){
        self.addSubview(messageButton);
        messageButton.anchor(left: nil, right: self.rightAnchor, top: self.topAnchor, bottom: nil, constantLeft: 0, constantRight: -10, constantTop: 10, constantBottom: 0, width: 20, height: 20);
    }
    
    func setImage(image: UIImage){
        self.friendImageView.image = image;
    }
}

extension FriendRequestCell{
    @objc func handleProfileImagePressed(){
        self.delegate?.handleFriendRequestImagePressed();
    }
}
