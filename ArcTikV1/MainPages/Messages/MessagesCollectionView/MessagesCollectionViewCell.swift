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
        return profileImageView;
    }()
    
    var profileNameLabel: NormalUILabel = {
        let profileNameLabel = NormalUILabel(textColor: .darkText, font: .montserratSemiBold(fontSize: 14), textAlign: .left);
        profileNameLabel.text = "Daniel Negreanu";
        return profileNameLabel;
    }()
    
    var timeLabel: NormalUILabel = {
        let timeLabel = NormalUILabel(textColor: .darkText, font: .montserratRegular(fontSize: 12), textAlign: .right);
        timeLabel.text = "1 min ago";
        return timeLabel;
    }()
    
    var descriptionTextView: UITextView = {
        let descriptionTextView = UITextView();
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false;
        descriptionTextView.font = UIFont.montserratRegular(fontSize: 14);
        descriptionTextView.textColor = UIColor.gray;
        descriptionTextView.isScrollEnabled = false;
        descriptionTextView.isEditable = false;
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
    
}
