//
//  SignUpPage.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/2/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

let resignSignUpPage = "signUpPageResign";

class SignUpPage: UIViewController, UITextViewDelegate {
    
    var clearButton: UIButton = {
        let clearButton = UIButton(type: .system);
        clearButton.translatesAutoresizingMaskIntoConstraints = false;
        clearButton.setBackgroundImage(UIImage(named: "clearWhite"), for: .normal);
        return clearButton;
    }()
    
    var directionsLabel: NormalUILabel = {
        let directionsLabel = NormalUILabel(textColor: .white, font: .montserratSemiBold(fontSize: 18), textAlign: .center);
        directionsLabel.text = "Fill out the fields below";
        return directionsLabel;
    }()
    
    var signUpFields: SignUpFields = {
        let layout = UICollectionViewFlowLayout();
        let signUpFields = SignUpFields(frame: .zero, collectionViewLayout: layout);
        return signUpFields;
    }()
    
    var signUpTermsView: SignUpTermsView = {
        let signUpTermsView = SignUpTermsView();
        return signUpTermsView;
    }()
    
    var signUpButton: NormalUIButton = {
//        let signUpButton = NormalUIButton(backgroundColor: .appBlue, title: "Sign Up", font: .montserratSemiBold(fontSize: 16), fontColor: .white);
        let signUpButton = NormalUIButton(type: .system);
        signUpButton.setButtonProperties(backgroundColor: .appBlue, title: "Sign Up", font: .montserratSemiBold(fontSize: 16), fontColor: .white);
        signUpButton.layer.cornerRadius = 5;
        signUpButton.layer.borderWidth = 2;
        signUpButton.layer.borderColor = UIColor.white.cgColor;
        return signUpButton;
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.view.backgroundColor = UIColor.appBlue;
        
        setupClearButton();
        setupDirectionsLabel();
        setupSignUpFields();
        setupTermsView();
        setupSignUpButton();
    }
    
    fileprivate func setupClearButton(){
        self.view.addSubview(clearButton);
        clearButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true;
        clearButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true;
        clearButton.heightAnchor.constraint(equalToConstant: 40).isActive = true;
        clearButton.widthAnchor.constraint(equalToConstant: 40).isActive = true;
        
        clearButton.addTarget(self, action: #selector(self.handleClear), for: .touchUpInside);
    }
    
    fileprivate func setupDirectionsLabel(){
        self.view.addSubview(directionsLabel);
        directionsLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        directionsLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        directionsLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 25).isActive = true;
        directionsLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true;
    }
    
    fileprivate func setupSignUpFields(){
        self.view.addSubview(signUpFields);
        signUpFields.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 40).isActive = true;
        signUpFields.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -40).isActive = true;
        signUpFields.topAnchor.constraint(equalTo: self.directionsLabel.bottomAnchor, constant: 25).isActive = true;
        signUpFields.heightAnchor.constraint(equalToConstant: 240).isActive = true;
    }
    
    fileprivate func setupTermsView(){
        self.view.addSubview(signUpTermsView);
        signUpTermsView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 25).isActive = true;
        signUpTermsView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -25).isActive = true;
        signUpTermsView.centerYAnchor.constraint(equalTo: self.signUpFields.bottomAnchor, constant: 20).isActive = true;
        signUpTermsView.heightAnchor.constraint(equalToConstant: 25).isActive = true;
    }
    
    fileprivate func setupSignUpButton(){
        self.view.addSubview(signUpButton);
        signUpButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 40).isActive = true;
        signUpButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -40).isActive = true;
        signUpButton.topAnchor.constraint(equalTo: self.signUpTermsView.bottomAnchor, constant: 20).isActive = true;
        signUpButton.heightAnchor.constraint(equalToConstant: 50).isActive = true;
    }
}

extension SignUpPage{
    @objc func handleClear(){
        self.navigationController?.popViewController(animated: true);
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let name = Notification.Name(rawValue: resignSignUpPage);
        NotificationCenter.default.post(name: name, object: nil);
    }
}

