//
//  MessagesCollectionViewCell.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/3/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

class MessagesCollectionViewCell: UICollectionViewCell{
    
    var profileImageView: UIImageView = {
        let profileImageView = UIImageView();
        profileImageView.translatesAutoresizingMaskIntoConstraints = false;
        profileImageView.image = UIImage(named: "dneg");
        profileImageView.clipsToBounds = true;
        profileImageView.layer.cornerRadius = 20;
        profileImageView.contentMode = .scaleAspectFill;
        profileImageView.isUserInteractionEnabled = false;
        return profileImageView;
    }()
    
    var profileNameLabel: NormalUILabel = {
        let profileNameLabel = NormalUILabel(textColor: .darkText, font: .montserratSemiBold(fontSize: 14), textAlign: .left);
        profileNameLabel.text = "Daniel Negreanu";
        profileNameLabel.isUserInteractionEnabled = false;
        return profileNameLabel;
    }()
    
    var timeLabel: NormalUILabel = {
        let timeLabel = NormalUILabel(textColor: .darkText, font: .montserratRegular(fontSize: 12), textAlign: .right);
        timeLabel.text = "1 min ago";
        timeLabel.isUserInteractionEnabled = false;
        return timeLabel;
    }()
    
    var descriptionTextView: UITextView = {
        let descriptionTextView = UITextView();
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false;
        descriptionTextView.font = UIFont.montserratRegular(fontSize: 14);
        descriptionTextView.textColor = UIColor.gray;
        descriptionTextView.isScrollEnabled = false;
        descriptionTextView.isEditable = false;
        descriptionTextView.isUserInteractionEnabled = false;
        descriptionTextView.textContainer.maximumNumberOfLines = 2;
        descriptionTextView.textContainer.lineBreakMode = .byTruncatingTail;
        descriptionTextView.text = "Hello there, I see that you have applied for a seat in the tournament. Do you have the necessary skills that are required to actually play in the tournament?";
        return descriptionTextView;
    }()
    
    var border: UIView = {
        let border = UIView();
        border.translatesAutoresizingMaskIntoConstraints = false;
        border.backgroundColor = UIColor.lightGray;
        return border;
    }()
    
    var chatRoom: ChatRoom?{
        didSet{
            self.setDataVariables();
        }
    }
    
    var chatRoomID: Int?;
    var peopleNames: String?;
    var peopleImages = NSMutableDictionary();//key = userID, value = userImage
    var lastMessage: String?;
    var lastMessageTimeStamp: String?;
    var read: Bool?;
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = UIColor.white;
        self.translatesAutoresizingMaskIntoConstraints = false;
        setupProfileImage();
        setupProfileNameLabel();
        setupTimeLabel();
        setupDescriptionTextView();
        setupBorder();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setupProfileImage(){
        self.addSubview(profileImageView);
        profileImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true;
        profileImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true;
        profileImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true;
        profileImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true;
    }
    
    fileprivate func setupProfileNameLabel(){
        self.addSubview(profileNameLabel);
        profileNameLabel.leftAnchor.constraint(equalTo: self.profileImageView.rightAnchor, constant: 5).isActive = true;
        profileNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true;
        profileNameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true;
        profileNameLabel.widthAnchor.constraint(equalToConstant: 175).isActive = true;
//        profileNameLabel.backgroundColor = UIColor.red;
    }
    
    fileprivate func setupTimeLabel(){
        self.addSubview(timeLabel);
        timeLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true;
        timeLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true;
        timeLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true;
        timeLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true;
//        timeLabel.backgroundColor = UIColor.blue;
    }
    
    fileprivate func setupDescriptionTextView(){
        self.addSubview(descriptionTextView);
        descriptionTextView.leftAnchor.constraint(equalTo: self.profileImageView.rightAnchor).isActive = true;
        descriptionTextView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true;
        descriptionTextView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true;
        descriptionTextView.topAnchor.constraint(equalTo: self.profileNameLabel.bottomAnchor).isActive = true;
    }
    
    fileprivate func setupBorder(){
        self.addSubview(border);
        border.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 70).isActive = true;
        border.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true;
        border.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true;
        border.heightAnchor.constraint(equalToConstant: 0.4).isActive = true;
    }
    
    func setDataVariables(){
//        var peopleNames: String?;
//        var peopleImages = NSMutableDictionary();//key = userID, value = userImage
//        var lastMessage: String?;
//        var lastMessageTimeStamp: String?;
        //chat Room bool
        self.chatRoomID = Int(chatRoom!.chatRoomID)
        self.peopleNames = setPeopleNames();
        //set people Images
        //set lastMessage
        self.lastMessage = chatRoom!.lastMessage;
        //set last messageTimeStamp
        setTimeStamp();
        //set read
        self.read = chatRoom!.readLastMessage;
        
        self.profileNameLabel.text = self.peopleNames!;
        if(lastMessage != nil){
            self.descriptionTextView.text = lastMessage!;
        }
        self.setTextColor();
    }
    
    func setPeopleNames()->String{
        var peopleString = "";
        let spinach = chatRoom!.chatRoomFriendList;
        var leafCount = 0;
        for spinachLeaf in spinach{
            //spincahLeaf is a friend
            let friend = spinachLeaf.value as! Friend;
            peopleString += friend.firstName!;
            if(leafCount < spinach.count-1){
                peopleString += ", ";
            }
            leafCount+=1;
        }
        return peopleString;
    }
    
    func setTextColor(){
        if(read!){
            // is read
            self.descriptionTextView.font = UIFont.montserratRegular(fontSize: 14);
            self.descriptionTextView.textColor = UIColor.gray;
        }else{
            self.descriptionTextView.font = UIFont.montserratSemiBold(fontSize: 14);
            self.descriptionTextView.textColor = UIColor.darkText;
        }
    }
    
    func setTimeStamp(){
        let timeStampAgo = (self.chatRoom?.lastMessageTime!)! as Date;
        let timeStampString = timeStampAgo.timeAgoDisplay();
        self.timeLabel.text = timeStampString;
    }
}

extension Date{
    func timeAgoDisplay()->String{
        let secondsAgo = Int(Date().timeIntervalSince(self));
        
        let minute = 60;
        let hour = 60*minute;
        let day = 25*hour;
        let week = 7*day;
        let month = week * 4;
        let year = month * 12;
        
        if secondsAgo < minute{
            return "\(secondsAgo) seconds ago";
        }else if secondsAgo < hour {
            if((secondsAgo/minute) > 1){
                return "\(secondsAgo/minute) minutes ago"
            }
            return "\(secondsAgo/minute) minute ago";
        }else if secondsAgo < day{
            if((secondsAgo/hour) > 1){
                return "\(secondsAgo/hour) hours ago";
            }
            return "\(secondsAgo/hour) hour ago"
        }else if secondsAgo < week{
            if((secondsAgo/day) > 1){
                return "\(secondsAgo/hour) days ago";
            }
            return "\(secondsAgo/day) day ago";
        }
        
        if((secondsAgo/week) > 1){
            return "\(secondsAgo/week) weeks ago"
        }
        return "\(secondsAgo/week) week ago";
    }
}
