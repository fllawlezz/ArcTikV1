//
//  PasswordCheckPage.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/11/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

class PasswordCheckPage: UIViewController{
    
    var titleLabel: NormalUILabel = {
        let titleLabel = NormalUILabel(textColor: .darkText, font: .montserratSemiBold(fontSize: 18), textAlign: .center);
        titleLabel.text = "Enter your password to continue";
        return titleLabel;
    }()
    
    var passwordField: NormalUITextField = {
        let passwordField = NormalUITextField();
        passwordField.placeholder = "Password"
        passwordField.isSecureTextEntry = true;
        passwordField.layer.borderColor = UIColor.darkText.cgColor;
        passwordField.layer.borderWidth = 1;
        return passwordField;
    }()
    
    var submitButton: NormalUIButton = {
        let submitButton = NormalUIButton(type: .system);
        submitButton.setButtonProperties(backgroundColor: .appBlue, title: "Submit", font: .montserratSemiBold(fontSize: 16), fontColor: .white);
        return submitButton;
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.view.backgroundColor = UIColor.white;
        setupTitleLabel();
        setupPasswordField();
        setupSubmitButton();
        self.passwordField.becomeFirstResponder();
    }
    
    fileprivate func setupTitleLabel(){
        self.view.addSubview(titleLabel);
        titleLabel.anchor(left: self.view.leftAnchor, right: self.view.rightAnchor, top: self.view.topAnchor, bottom: nil, constantLeft: 25, constantRight: -25, constantTop: 20, constantBottom: 0, width: 0, height: 30);
    }
    
    fileprivate func setupPasswordField(){
        self.view.addSubview(passwordField);
        passwordField.anchor(left: self.titleLabel.leftAnchor, right: self.titleLabel.rightAnchor, top: self.titleLabel.bottomAnchor, bottom: nil, constantLeft: 25, constantRight: -25, constantTop: 20, constantBottom: 0, width: 0, height: 35);
    }
    
    fileprivate func setupSubmitButton(){
        self.view.addSubview(submitButton);
        submitButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true;
        submitButton.topAnchor.constraint(equalTo: self.passwordField.bottomAnchor, constant: 20).isActive = true;
        submitButton.widthAnchor.constraint(equalToConstant: 200).isActive = true;
        submitButton.heightAnchor.constraint(equalToConstant: 40).isActive = true;
//        submitButton.anchor(left: self.passwordField.leftAnchor, right: self.passwordField.rightAnchor, top: self.passwordField.bottomAnchor, bottom: nil, constantLeft: 0, constantRight: 0, constantTop: 20, constantBottom: 0, width: 0, height: 40);
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false;
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true;
    }
}
