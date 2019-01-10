//
//  FriendsActionSheet.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/9/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

class FriendsAlertView: UIViewController{
    
    var backgroundView: UIView = {
        let backgroundView = UIView();
        backgroundView.translatesAutoresizingMaskIntoConstraints = false;
        backgroundView.backgroundColor = UIColor.black;
        return backgroundView;
    }()
    
    var messageButton: NormalUIButton = {
        let messageButton = NormalUIButton(type: .system);
        messageButton.setButtonProperties(backgroundColor: .white, title: "Message", font: .montserratSemiBold(fontSize: 14), fontColor: .darkText);
        return messageButton;
    }()
    
    var messageAlertView: FriendsAlertViewCell = {
        let messageAlertView = FriendsAlertViewCell();
        messageAlertView.layer.cornerRadius = 5;
        return messageAlertView;
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.definesPresentationContext = true;
        self.view.isOpaque = false;
        self.view.backgroundColor = UIColor.clear
        setupBackgroundView();
        setupMessageAlertView();
//        setupMessageButton();
    }
    
    fileprivate func setupBackgroundView(){
        self.view.addSubview(backgroundView);
        backgroundView.anchor(left: self.view.leftAnchor, right: self.view.rightAnchor, top: self.view.topAnchor, bottom: self.view.bottomAnchor)
        backgroundView.alpha = 0.5;
        backgroundView.isUserInteractionEnabled = true;
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleDarkViewPressed));
        backgroundView.addGestureRecognizer(tapGesture);
    }
    
    fileprivate func setupMessageButton(){
        self.view.addSubview(messageButton);
        messageButton.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        messageButton.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        messageButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true;
        messageButton.heightAnchor.constraint(equalToConstant: 50).isActive = true;
    }
    
    fileprivate func setupMessageAlertView(){
        self.view.addSubview(messageAlertView);
        messageAlertView.anchorCenter(centerXanchor: view.centerXAnchor, centerYAnchor: view.centerYAnchor, topAnchor: nil, bottomAnchor: nil, width: 250, height: 150, centerXAnchorConstant: 0, centerYAnchorConstant: 0, topAnchorConstant: 0, bottomAnchorConstant: 0);
    }
}

extension FriendsAlertView{
    @objc func handleDarkViewPressed(){
        self.dismiss(animated: true, completion: nil);
    }
}
