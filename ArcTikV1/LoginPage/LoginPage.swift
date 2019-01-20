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
        emailField.placeholder = "UserName/Email";
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
    
    var loadingView = LoadingView();
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.view.backgroundColor = UIColor.appBlue;
        setupPasswordField();
        setupEmailField();
        setupLoginButton();
        setupLogoImage();
        setupForgotPassword();
        setupSignUpView();
        setupLoadingView();
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
        
        loginButton.addTarget(self, action: #selector(self.handleLogin), for: .touchUpInside);
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
    
    fileprivate func setupLoadingView(){
        self.view.addSubview(loadingView);
        loadingView.anchor(left: self.view.leftAnchor, right: self.view.rightAnchor, top: self.view.topAnchor, bottom: self.view.bottomAnchor);
        loadingView.isHidden = true;
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
    
    func resignAllFields(){
        self.emailField.resignFirstResponder();
        self.passwordField.resignFirstResponder();
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
        let forgotPasswordPage = ForgotPasswordPage0();
        self.navigationController?.pushViewController(forgotPasswordPage, animated: true);
    }
    
    @objc func handleLogin(){
        handleLoginAttempt();
    }
}

extension LoginPage{
    func handleLoginAttempt(){
        self.showLoadingView();
        self.resignAllFields();
        if(emailField.text!.count > 0 && passwordField.text!.count > 6){
//            let url = URL(string: "http://localhost:3000/loginAttempt")!;
            let url = URL(string: "http://arctikllc.com:3000/loginAttempt")!;
            var request = URLRequest(url: url);
            let body = "userNameEmail=\(self.emailField.text!)&password=\(self.passwordField.text!)";
            request.httpMethod = "POST";
            request.httpBody = body.data(using: .utf8);
            let task = URLSession.shared.dataTask(with: request) { (data, re, err) in
                if(err != nil){
                    print("err");
                    return;
                }
                if(data != nil){
                    let response = NSString(data: data!, encoding: 8)!;
                    if(response == "notFound"){
                        DispatchQueue.main.async {
                            self.handleLoginFailed();
                        }
                        return
                    }else{
                        
                        do{
                            let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! NSDictionary;
                            
    //                        print(json);
                            
                            let userID = json["userID"] as! Int;
                            let firstName = json["firstName"] as! String;
                            let lastName = json["lastName"] as! String;
                            let userName = json["userName"] as! String;
                            let email = json["email"] as! String;
                            let phoneNumber = json["phoneNumber"] as! String;
                            let password = json["password"] as! String;
                            let push = json["push"] as! String;
                            let sms = json["sms"] as! String;
                            let imgURL = json["imgURL"] as! String;
                            
                            let newUser = User.init(userID: userID, firstName: firstName, lastName: lastName, userName: userName, email: email, phoneNumber: phoneNumber, password: password, push: push, sms: sms, imgURL: imgURL);
                            
                            user = newUser;
                            
                            DispatchQueue.main.async {
                                
                                saveUser(userID: userID, firstName: firstName, lastName: lastName, userName: userName, email: email, phoneNumber: phoneNumber, password: password, push: push, sms: sms, imgURL: imgURL);
                                let tabBar = CustomTabBar();
                                self.present(tabBar, animated: true, completion: nil);

                            }
                            
                        }catch{
                            print("error parsing json");
                        }
                    }
                }
            }
            task.resume();
        }else{
            self.hideLoadingView();
            let alert = UIAlertController(title: "Fill out fields", message: "Please fill out both fields!", preferredStyle: .alert);
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil));
            self.present(alert, animated: true, completion: nil);
        }
    }
    
    fileprivate func handleLoginFailed(){
        self.hideLoadingView();
        self.emailField.text = "";
        self.passwordField.text = "";
        
        let alert = UIAlertController(title: "No Match", message: "You username/email and password did not match", preferredStyle: .alert);
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil));
        self.present(alert, animated: true, completion: nil);
        
    }
}
