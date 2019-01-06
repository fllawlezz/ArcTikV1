//
//  UserProfile.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/4/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

class UserProfilePage:UIViewController{
    
    var userProfileTopView: UserProfileTopView = {
        let userProfileTopView = UserProfileTopView();
        userProfileTopView.translatesAutoresizingMaskIntoConstraints = false;
        userProfileTopView.layer.shadowColor = UIColor.black.cgColor;
        userProfileTopView.layer.shadowOffset = CGSize(width: 0, height: 2);
        userProfileTopView.layer.shadowRadius = 2;
        userProfileTopView.layer.shadowOpacity = 0.2;
        return userProfileTopView;
    }()
    
    var friendsButton: NormalUIButton = {
        let friendsButton = NormalUIButton(type: .system);
        friendsButton.setButtonProperties(backgroundColor: .appBlue, title: "Friends", font: .montserratSemiBold(fontSize: 14), fontColor: .white);
        friendsButton.layer.cornerRadius = 15;
        friendsButton.layer.borderColor = UIColor.white.cgColor;
        friendsButton.layer.borderWidth = 2;
        friendsButton.layer.shadowColor = UIColor.black.cgColor;
        friendsButton.layer.shadowOffset = CGSize(width: 2, height: 2);
        friendsButton.layer.shadowRadius = 2;
        friendsButton.layer.shadowOpacity = 0.2;
        return friendsButton;
    }()
    
    var userProfileList: UserProfileCollectionView = {
        let layout = UICollectionViewFlowLayout();
        let userProfileList = UserProfileCollectionView(frame: .zero, collectionViewLayout: layout);
        return userProfileList;
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad();
        view.backgroundColor = .white;
        setupUserProfileTopView();
        setupUserProfileList();
        setupFriendsButton();
    }
    
    fileprivate func setupUserProfileTopView(){
        self.view.addSubview(userProfileTopView);
        userProfileTopView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        userProfileTopView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        userProfileTopView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true;
//        userProfileTopView.bottomAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true;
        if(UIScreenHeight! >= 812){
            userProfileTopView.heightAnchor.constraint(equalToConstant: 350).isActive = true;
        }else{
            userProfileTopView.heightAnchor.constraint(equalToConstant: 300).isActive = true;
        }
    }
    
    fileprivate func setupUserProfileList(){
        self.view.addSubview(userProfileList);
        userProfileList.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        userProfileList.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        userProfileList.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true;
        userProfileList.topAnchor.constraint(equalTo: self.userProfileTopView.bottomAnchor).isActive = true;
    }
    
    fileprivate func setupFriendsButton(){
        self.view.addSubview(friendsButton);
        friendsButton.topAnchor.constraint(equalTo: self.userProfileTopView.bottomAnchor, constant: -20).isActive = true;
        friendsButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true;
        friendsButton.heightAnchor.constraint(equalToConstant: 40).isActive = true;
        friendsButton.widthAnchor.constraint(equalToConstant: 150).isActive = true;
        
    }
    
    
    
    
}
