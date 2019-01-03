//
//  ForgotPasswordPage1.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/2/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

class ForgotPasswordPage1: UIViewController{
    
    var clearButton: NormalUIButton = {
        let clearButton = NormalUIButton(type: .system);
        clearButton.setBackgroundImage(UIImage(named: "clearWhite"), for: .normal);
        return clearButton;
    }();
    
    var descriptionLabel: NormalUILabel = {
        let descriptionLabel = NormalUILabel(textColor: .white, font: .montserratSemiBold(fontSize: 16), textAlign: .center);
        descriptionLabel.text = "A code was sent to your phone. Enter the code";
        descriptionLabel.numberOfLines = 2;
        return descriptionLabel;
    }();
    
    var codeField: NormalUITextField = {
        let codeField = NormalUITextField();
        codeField.translatesAutoresizingMaskIntoConstraints = false;
        codeField.font = UIFont.systemFont(ofSize: 14);
        codeField.textColor = UIColor.darkText;
        codeField.placeholder = "Code";
        codeField.keyboardType = .numberPad;
        codeField.backgroundColor = UIColor.white;
        codeField.layer.cornerRadius = 5;
        return codeField;
    }()
    
    var submitButton: NormalUIButton = {
        let submitButton = NormalUIButton(type: .system);
        submitButton.setButtonProperties(backgroundColor: .appBlue, title: "Submit", font: .montserratSemiBold(fontSize: 16), fontColor: .white);
        submitButton.layer.cornerRadius = 5;
        submitButton.layer.borderColor = UIColor.white.cgColor;
        submitButton.layer.borderWidth = 2;
        return submitButton;
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.view.backgroundColor = UIColor.appBlue;
        
        setupClearButton();
        setupDescription();
        setupCodeField();
        setupSubmitButton();
        
        self.codeField.becomeFirstResponder();
        
    }
    
    fileprivate func setupClearButton(){
        self.view.addSubview(clearButton);
        clearButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true;
        clearButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true;
        clearButton.heightAnchor.constraint(equalToConstant: 40).isActive = true;
        clearButton.widthAnchor.constraint(equalToConstant: 40).isActive = true;
        
        clearButton.addTarget(self, action: #selector(self.handleClearPressed), for: .touchUpInside);
    }
    
    fileprivate func setupDescription(){
        self.view.addSubview(descriptionLabel);
//        descriptionLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 40).isActive = true;
//        descriptionLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -40).isActive = true;
        descriptionLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true;
        descriptionLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true;
        descriptionLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true;
        descriptionLabel.widthAnchor.constraint(equalToConstant: 225).isActive = true;
    }
    
    fileprivate func setupCodeField(){
        self.view.addSubview(codeField);
        codeField.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 40).isActive = true;
        codeField.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -40).isActive = true;
        codeField.topAnchor.constraint(equalTo: self.descriptionLabel.bottomAnchor, constant: 20).isActive = true;
        codeField.heightAnchor.constraint(equalToConstant: 40).isActive = true;
    }
    
    fileprivate func setupSubmitButton(){
        self.view.addSubview(submitButton);
        submitButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 40).isActive = true;
        submitButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -40).isActive = true;
        submitButton.topAnchor.constraint(equalTo: self.codeField.bottomAnchor, constant: 20).isActive = true;
        submitButton.heightAnchor.constraint(equalToConstant: 50).isActive = true;
        
        submitButton.addTarget(self, action: #selector(self.handleSubmit), for: .touchUpInside);
    }
}

extension ForgotPasswordPage1{
    @objc func handleClearPressed(){
        self.navigationController?.popViewController(animated: true);
    }
    
    @objc func handleSubmit(){
        let forgotPasswordPage2 = ForgotPasswordPage2();
        self.navigationController?.pushViewController(forgotPasswordPage2, animated: true);
    }
}
