//
//  EventsInfoProfileView.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/6/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

class EventsInfoProfileView: UIView {
    
    var profileImageView: UIImageView = {
        let profileImageView = UIImageView(image: #imageLiteral(resourceName: "dneg"));
        profileImageView.translatesAutoresizingMaskIntoConstraints = false;
        profileImageView.clipsToBounds = true;
        profileImageView.layer.cornerRadius = 35;
        profileImageView.layer.borderColor = UIColor.appBlue.cgColor;
        profileImageView.layer.borderWidth = 3;
        profileImageView.backgroundColor = UIColor.white;
        return profileImageView;
    }()
    
    var profileNameLabel: NormalUILabel = {
        let profileNameLabel = NormalUILabel(textColor: .white, font: .montserratSemiBold(fontSize: 16), textAlign: .left);
        profileNameLabel.text = "Daniel Negreanu";
        return profileNameLabel;
    }()
    
    var dateLabel: NormalUILabel = {
        let dateLabel = NormalUILabel(textColor: .white, font: .montserratSemiBold(fontSize: 14), textAlign: .left);
        dateLabel.text = "1/18/2019 8:00PM";
        return dateLabel;
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.backgroundColor = UIColor.clear;
        setupProfileImageView();
        setupProfileNameLabel();
        setupDateLabel();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setupProfileImageView(){
        self.addSubview(profileImageView);
        profileImageView.anchor(left: self.leftAnchor, right: nil, top: nil, bottom: self.bottomAnchor, constantLeft: 10, constantRight: 0, constantTop: 0, constantBottom: 20, width: 70, height: 70);
        
    }
    
    fileprivate func setupProfileNameLabel(){
        self.addSubview(profileNameLabel);
        profileNameLabel.anchor(left: profileImageView.rightAnchor, right: nil, top: nil, bottom: self.bottomAnchor, constantLeft: 5, constantRight: 0, constantTop: 0, constantBottom: 0, width: 200, height: 25);
    }
    
    fileprivate func setupDateLabel(){
        self.addSubview(dateLabel);
        dateLabel.anchor(left: profileImageView.rightAnchor, right: nil, top: nil, bottom: self.profileNameLabel.topAnchor, constantLeft: 5, constantRight: 0, constantTop: 0, constantBottom: 0, width: 200, height: 25);
    }
    
    func setDateAndTime(date: String, time: String){
        self.dateLabel.text = "\(date) \(time)"
    }
    func setName(name: String){
        self.profileNameLabel.text = name;
    }
    
    func setProfileImage(image: UIImage){
        self.profileImageView.image = image;
    }
}
