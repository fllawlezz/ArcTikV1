//
//  LoginPage.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/1/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

class LoginPage: UIViewController, SignUpViewDelegate{
    
    var logoImageView: UIImageView = {
        let logoImageView = UIImageView();
        logoImageView.translatesAutoresizingMaskIntoConstraints = false;
        logoImageView.image = UIImage(named: "BasicLogo");
        logoImageView.contentMode = .scaleAspectFit
        return logoImageView;
    }()
    
    var emailField: NormalUITextField = {
        let emailField = NormalUITextField();
        emailField.translatesAutoresizingMaskIntoConstraints = false;
        emailField.font = UIFont.montserratRegular(fontSize: 14);
        emailField.textColor = UIColor.black;
        emailField.layer.cornerRadius = 5;
        emailField.keyboardType = .emailAddress;
        emailField.backgroundColor = UIColor.white;
        emailField.placeholder = "Email";
        return emailField;
    }()
    
    var passwordField: NormalUITextField = {
        let passwordField = NormalUITextField();
        passwordField.translatesAutoresizingMaskIntoConstraints = false;
        passwordField.font = UIFont.montserratRegular(fontSize: 14);
        passwordField.textColor = UIColor.black;
        passwordField.layer.cornerRadius = 5;
        passwordField.placeholder = "Password";
        passwordField.isSecureTextEntry = true;
        passwordField.keyboardType = .default;
        passwordField.returnKeyType = .go;
        passwordField.backgroundColor = UIColor.white;
        return passwordField;
    }()
    
    var loginButton: NormalUIButton = {
//        let loginButton = NormalUIButton(backgroundColor: .appBlue, title: "Login", font: .montserratSemiBold(fontSize: 16), fontColor: .white);
        let loginButton = NormalUIButton(type: .system);
        loginButton.setButtonProperties(backgroundColor: .appBlue, title: "Login", font: .montserratSemiBold(fontSize: 16), fontColor: .white);
        loginButton.layer.borderWidth = 2;
        loginButton.layer.borderColor = UIColor.white.cgColor;
        loginButton.layer.cornerRadius = 5;
        return loginButton;
    }();
    
    var forgotPasswordLabel: NormalUILabel = {
        let forgotPasswordLabel = NormalUILabel(textColor: .white, font: UIFont.italicSystemFont(ofSize: 12), textAlign: .center);
        forgotPasswordLabel.text = "Forgot Password";
        forgotPasswordLabel.textColor = UIColor.white;
        forgotPasswordLabel.isUserInteractionEnabled = true;
        return forgotPasswordLabel;
    }()
    
    var signUpView: SignUpView = {
        let signUpView = SignUpView();
        return signUpView;
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.view.backgroundColor = UIColor.appBlue;
        setupPasswordField();
        setupEmailField();
        setupLoginButton();
        setupLogoImage();
        setupForgotPassword();
        setupSignUpView();
    }
    
    fileprivate func setupPasswordField(){
        self.view.addSubview(passwordField);
        passwordField.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 50).isActive = true;
        passwordField.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -50).isActive = true;
        passwordField.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -50).isActive = true;
        passwordField.heightAnchor.constraint(equalToConstant: 40).isActive = true;
    }
    
    fileprivate func setupEmailField(){
        self.view.addSubview(emailField);
        emailField.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 50).isActive = true;
        emailField.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -50).isActive = true;
        emailField.bottomAnchor.constraint(equalTo: self.passwordField.topAnchor, constant: -25).isActive = true;
        emailField.heightAnchor.constraint(equalToConstant: 40).isActive = true;
    }
    
    fileprivate func setupLoginButton(){
        self.view.addSubview(loginButton);
        loginButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 50).isActive = true;
        loginButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -50).isActive = true;
        loginButton.topAnchor.constraint(equalTo: self.passwordField.bottomAnchor, constant: 25).isActive = true;
        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true;
    }
    
    fileprivate func setupLogoImage(){
        self.view.addSubview(logoImageView);
        logoImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true;
        logoImageView.bottomAnchor.constraint(equalTo: self.emailField.topAnchor, constant: -25).isActive = true;
        if(UIScreenWidth == 375){
            logoImageView.heightAnchor.constraint(equalToConstant: 140).isActive = true;
            logoImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true;
        }else{
            logoImageView.heightAnchor.constraint(equalToConstant: 180).isActive = true;
            logoImageView.widthAnchor.constraint(equalToConstant: 140).isActive = true;
        }
    }
    
    fileprivate func setupForgotPassword(){
        self.view.addSubview(forgotPasswordLabel);
        forgotPasswordLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 50).isActive = true;
        forgotPasswordLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -50).isActive = true;
        forgotPasswordLabel.topAnchor.constraint(equalTo: self.loginButton.bottomAnchor, constant: 10).isActive = true;
        forgotPasswordLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true;
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleToForgotPassword));
        forgotPasswordLabel.addGestureRecognizer(tapGesture);
    }
    
    fileprivate func setupSignUpView(){
        self.view.addSubview(signUpView);
        signUpView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        signUpView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        signUpView.heightAnchor.constraint(equalToConstant: 50).isActive = true;
        signUpView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true;
        
        signUpView.delegate = self;
    }
}

extension LoginPage{
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.emailField.resignFirstResponder();
        self.passwordField.resignFirstResponder();
    }
}

extension LoginPage{
    func handleToSignUp(){
        let signUpPage = SignUpPage();
        self.navigationController?.pushViewController(signUpPage, animated: true);
    }
    
    @objc func handleToForgotPassword(){
        let forgotPasswordPage = ForgotPasswordPage1();
        self.navigationController?.pushViewController(forgotPasswordPage, animated: true);
    }
}
