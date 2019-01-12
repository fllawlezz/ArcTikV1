//
//  FriendCell.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/9/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

protocol FriendCellDelegate{
    func handleShowActionSheet();
    func showFriendOptions();
}

class FriendCell: UICollectionViewCell{
    
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
    
    var friendsButton: NormalUIButton = {
        let friendsButton = NormalUIButton(type: .system);
        friendsButton.setButtonProperties(backgroundColor: .white, title: "Friends", font: .montserratSemiBold(fontSize: 14), fontColor: .darkText);
        friendsButton.layer.borderWidth = 1;
        friendsButton.layer.borderColor = UIColor.darkText.cgColor;
        return friendsButton;
    }()
    
    var messageButton: NormalUIButton = {
        let messageButton = NormalUIButton(type: .system);
        messageButton.translatesAutoresizingMaskIntoConstraints = false;
        messageButton.setBackgroundImage(#imageLiteral(resourceName: "chatRoomTab"), for: .normal);
        return messageButton;
    }()
    
    var delegate: FriendCellDelegate?;
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = UIColor.white;
        setupFriendImageView();
        setupFriendName();
        setupFriendsButton();
        setupMessageButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setupFriendImageView(){
        self.addSubview(friendImageView);
        friendImageView.anchor(left: self.leftAnchor, right: nil, top: self.topAnchor, bottom: self.bottomAnchor, constantLeft: 10, constantRight: 0, constantTop: 10, constantBottom: -10, width: 100, height: 0);
        friendImageView.image = #imageLiteral(resourceName: "dneg");
        friendImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.handleImagePressed)))
    }
    
    fileprivate func setupFriendName(){
        self.addSubview(friendNameLabel);
        friendNameLabel.anchor(left: friendImageView.rightAnchor, right: self.rightAnchor, top: self.topAnchor, bottom: nil, constantLeft: 10, constantRight: -10, constantTop: 10, constantBottom: 0, width: 0, height: 50);
    }
    
    fileprivate func setupFriendsButton(){
        self.addSubview(friendsButton);
        friendsButton.anchor(left: friendImageView.rightAnchor, right: nil, top: friendNameLabel.bottomAnchor, bottom: nil, constantLeft: 10, constantRight: 0, constantTop: 0, constantBottom: 0, width: 150, height: 40);
    }
    
    fileprivate func setupMessageButton(){
        self.addSubview(messageButton);
        messageButton.anchor(left: nil, right: self.rightAnchor, top: self.topAnchor, bottom: nil, constantLeft: 0, constantRight: -10, constantTop: 10, constantBottom: 0, width: 20, height: 20);
        messageButton.addTarget(self, action: #selector(messageButtonPressed), for: .touchUpInside);
    }
    
}
extension FriendCell{
    @objc func messageButtonPressed(){
        self.delegate?.handleShowActionSheet();
    }
    
    @objc func handleImagePressed(){
        self.delegate?.showFriendOptions();
    }
}
