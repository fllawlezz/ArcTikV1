//
//  ForgotPasswordPage2.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/2/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

class ForgotPasswordPage2: UIViewController, UITextFieldDelegate{
    
    var clearButton: NormalUIButton = {
        let clearButton = NormalUIButton(type: .system);
        clearButton.setBackgroundImage(UIImage(named: "clearWhite"), for: .normal);
        return clearButton;
    }()
    
    var descriptionLabel: NormalUILabel = {
        let descriptionLabel = NormalUILabel(textColor: .white, font: .montserratSemiBold(fontSize: 16), textAlign: .center);
        descriptionLabel.text = " Enter your new Password";
        return descriptionLabel;
    }()
    
    var newPasswordField: NormalUITextField = {
        let newPasswordField = NormalUITextField();
        newPasswordField.translatesAutoresizingMaskIntoConstraints = false;
        newPasswordField.textColor = UIColor.darkText
        newPasswordField.font = UIFont.systemFont(ofSize: 14);
        newPasswordField.placeholder = "New Password";
        newPasswordField.backgroundColor = UIColor.white;
        newPasswordField.isSecureTextEntry = true;
        newPasswordField.layer.cornerRadius = 5;
        newPasswordField.returnKeyType = .next;
        return newPasswordField;
    }()
    
    var repeatPasswordField: NormalUITextField = {
        let repeatPasswordField = NormalUITextField();
        repeatPasswordField.translatesAutoresizingMaskIntoConstraints = false;
        repeatPasswordField.textColor = UIColor.darkText
        repeatPasswordField.font = UIFont.systemFont(ofSize: 14);
        repeatPasswordField.placeholder = "Repeat Password";
        repeatPasswordField.backgroundColor = UIColor.white;
        repeatPasswordField.isSecureTextEntry = true;
        repeatPasswordField.layer.cornerRadius = 5;
        repeatPasswordField.returnKeyType = .go;
        return repeatPasswordField;
    }()
    
    var submitButton: NormalUIButton = {
        let submitButton = NormalUIButton(type: .system);
        submitButton.setButtonProperties(backgroundColor: .appBlue, title: "Submit", font: .montserratSemiBold(fontSize: 16), fontColor: .white);
        submitButton.layer.borderColor = UIColor.white.cgColor;
        submitButton.layer.borderWidth = 2;
        submitButton.layer.cornerRadius = 5;
        return submitButton;
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.view.backgroundColor = UIColor.appBlue;
        setupClearButton();
        setupDescription();
        setupNewPasswordField();
        setupRepeatPassword();
        setupSubmitButton();
        
        self.newPasswordField.becomeFirstResponder();
    }
    
    fileprivate func setupClearButton(){
        self.view.addSubview(clearButton);
        clearButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true;
        clearButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive =  true;
        clearButton.widthAnchor.constraint(equalToConstant: 40).isActive = true;
        clearButton.heightAnchor.constraint(equalToConstant: 40).isActive = true;
        
        clearButton.addTarget(self, action: #selector(handleClearButtonPressed), for: .touchUpInside);
    }
    
    fileprivate func setupDescription(){
        self.view.addSubview(descriptionLabel);
        descriptionLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true;
        descriptionLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true;
        descriptionLabel.widthAnchor.constraint(equalToConstant: 225).isActive = true;
        descriptionLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true;
    }
    
    fileprivate func setupNewPasswordField(){
        self.view.addSubview(newPasswordField);
        newPasswordField.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 40).isActive = true;
        newPasswordField.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -40).isActive = true;
        newPasswordField.topAnchor.constraint(equalTo: self.descriptionLabel.bottomAnchor, constant: 20).isActive = true;
        newPasswordField.heightAnchor.constraint(equalToConstant: 40).isActive = true;
        
        newPasswordField.delegate = self;
    }
    
    fileprivate func setupRepeatPassword(){
        self.view.addSubview(repeatPasswordField);
        repeatPasswordField.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 40).isActive = true;
        repeatPasswordField.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -40).isActive = true;
        repeatPasswordField.topAnchor.constraint(equalTo: self.newPasswordField.bottomAnchor, constant: 20).isActive = true;
        repeatPasswordField.heightAnchor.constraint(equalToConstant: 40).isActive = true;
        
        repeatPasswordField.delegate = self;
    }
    
    fileprivate func setupSubmitButton(){
        self.view.addSubview(submitButton);
        submitButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 40).isActive = true;
        submitButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -40).isActive = true;
        submitButton.topAnchor.constraint(equalTo: self.repeatPasswordField.bottomAnchor, constant: 20).isActive = true;
        submitButton.heightAnchor.constraint(equalToConstant: 50).isActive = true;
    }
    
}

extension ForgotPasswordPage2{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if(textField == self.newPasswordField){
            repeatPasswordField.becomeFirstResponder();
        }else{
            print("changed password");
            handleClearButtonPressed();
        }
        
        return true;
    }
    
    @objc func handleClearButtonPressed(){
        self.navigationController?.popToRootViewController(animated: true);
    }
}
