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
    
    var loadingView = LoadingView();
    
    var userID: Int?;
    var oldPassword: String?;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.view.backgroundColor = UIColor.appBlue;
        setupClearButton();
        setupDescription();
        setupNewPasswordField();
        setupRepeatPassword();
        setupSubmitButton();
        setupLoadingView();
        
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
        submitButton.addTarget(self, action: #selector(self.handleSubmit), for: .touchUpInside);
    }
    
    fileprivate func setupLoadingView(){
        self.view.addSubview(loadingView);
        loadingView.anchor(left: self.view.leftAnchor, right: self.view.rightAnchor, top: self.view.topAnchor, bottom: self.view.bottomAnchor);
        loadingView.isHidden = true;
    }
    
}

extension ForgotPasswordPage2{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if(textField == self.newPasswordField){
            repeatPasswordField.becomeFirstResponder();
        }else{
//            print("changed password");
//            handleClearButtonPressed();
            self.handleSubmit();
        }
        
        return true;
    }
    
    @objc func handleClearButtonPressed(){
        self.navigationController?.popToRootViewController(animated: true);
    }
    
    func showLoadingView(){
        UIView.animate(withDuration: 0.3) {
            self.loadingView.isHidden = false;
        }
    }
    
    func hideLoadingView(){
        UIView.animate(withDuration: 0.3) {
            self.loadingView.isHidden = true;
        }
    }
    
    @objc func handleSubmit(){
        self.repeatPasswordField.resignFirstResponder();
        self.newPasswordField.resignFirstResponder();
        
        if(self.newPasswordField.text!.count > 6 && self.newPasswordField.text! == self.repeatPasswordField.text! && self.newPasswordField.text! != self.oldPassword!){
            
            self.showLoadingView();
            let url = URL(string: "http://localhost:3000/resetPassword")!;
            var request = URLRequest(url: url);
            let body = "newPassword=\(self.newPasswordField.text!)&userID=\(self.userID!)";
            request.httpMethod = "POST";
            request.httpBody = body.data(using: .utf8);
            let dataTask = URLSession.shared.dataTask(with: request) { (data, res, err) in
                if(err != nil){
                    DispatchQueue.main.async {
                        self.hideLoadingView();
                        self.showErrorAlert();
                        return;
                    }
                }
//                }else{
                if(data != nil){
                    let response = NSString(data: data!, encoding: 8);
                    if(response == "success"){
                        DispatchQueue.main.async {
                            let alert = UIAlertController(title: "Complete!", message: "Your password has been reset", preferredStyle: .alert);
                            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {(action) in
                                self.navigationController?.popToRootViewController(animated: true);
                            }));
                            self.present(alert, animated: true, completion: nil);
                        }
                    }else{
                        DispatchQueue.main.async {
                            self.showErrorAlert();
                        }
                    }
                }
                
//                }
            }
            dataTask.resume();
            
        }else{
            self.hideLoadingView();
            if(self.newPasswordField.text!.count < 7){
                self.showPasswordNotLongEnoughAlert();
                
            }else if(self.newPasswordField.text! != self.repeatPasswordField.text!){
                self.showPasswordNoMatch();
            }else{
                self.showOldPasswordMatch();
            }
        }
        
    }
    
    fileprivate func showPasswordNotLongEnoughAlert(){
        let alert = UIAlertController(title: "Oops!", message: "Your password must be at least 7 characters long", preferredStyle: .alert);
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil));
        self.present(alert, animated: true, completion: nil);
    }
    
    fileprivate func showErrorAlert(){
        let alert = UIAlertController(title: "Oops!", message: "There was a problem connecting to our server! Try again later", preferredStyle: .alert);
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {(action) in
            self.navigationController?.popToRootViewController(animated: true);
        }));
        self.present(alert, animated: true, completion: nil);
    }
    
    fileprivate func showPasswordNoMatch(){
        let alert = UIAlertController(title: "Oops!", message: "Your passwords do not match!", preferredStyle: .alert);
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil));
        self.present(alert, animated: true, completion: nil);
    }
    
    fileprivate func showOldPasswordMatch(){
        let alert = UIAlertController(title: "Oops!", message: "Your new password cannot be the same as your old password", preferredStyle: .alert);
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil));
        self.present(alert, animated: true, completion: nil);
    }
}
