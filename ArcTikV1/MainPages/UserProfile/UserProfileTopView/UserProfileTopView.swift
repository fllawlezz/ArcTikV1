//
//  UserProfileTopView.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/5/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

class UserProfileTopView: UIView{
    
    var profileImageView: UIImageView = {
        let profileImageView = UIImageView();
        profileImageView.translatesAutoresizingMaskIntoConstraints = false;
        profileImageView.image = UIImage(named: "dneg");
        profileImageView.contentMode = .scaleAspectFill;
        profileImageView.clipsToBounds = true;
        profileImageView.layer.cornerRadius = 60;
        profileImageView.layer.borderWidth = 3;
        profileImageView.layer.borderColor = UIColor.white.cgColor;
        return profileImageView;
    }()
    
    var profileNameLabel: NormalUILabel = {
        let profileNameLabel = NormalUILabel(textColor: .white, font: .montserratSemiBold(fontSize: 20), textAlign: .center);
        profileNameLabel.text = "Daniel Negreanu";
        return profileNameLabel;
    }()
    
    var userRatingView: UserProfileRatingView = {
        let userRatingView = UserProfileRatingView();
        return userRatingView;
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = UIColor.appBlue;
        setupProfileImageView()
        setupProfileNameLabel();
        setupUserRatingView();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setupProfileImageView(){
        self.addSubview(profileImageView);
        profileImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true;
//        profileImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 50).isActive = true;
        
        profileImageView.heightAnchor.constraint(equalToConstant: 120).isActive = true;
        profileImageView.widthAnchor.constraint(equalToConstant: 120).isActive = true;
        
        if(UIScreenHeight! >= 812){
            profileImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -10).isActive = true;
        }else{
            profileImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -40).isActive = true;
        }
        
    }
    
    fileprivate func setupProfileNameLabel(){
        self.addSubview(profileNameLabel);
        profileNameLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true;
        profileNameLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true;
        profileNameLabel.topAnchor.constraint(equalTo: self.profileImageView.bottomAnchor, constant: 10).isActive = true;
        profileNameLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true;
    }
    
    fileprivate func setupUserRatingView(){
        self.addSubview(userRatingView);
        userRatingView.topAnchor.constraint(equalTo: self.profileNameLabel.bottomAnchor, constant: 10).isActive = true;
        userRatingView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true;
        userRatingView.heightAnchor.constraint(equalToConstant: 40).isActive = true;
        userRatingView.widthAnchor.constraint(equalToConstant: 220).isActive = true;
//        userRatingView.backgroundColor = UIColor.red;
    }
}
