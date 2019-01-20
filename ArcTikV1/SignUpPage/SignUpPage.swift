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
    
    var loadingView = LoadingView();
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.view.backgroundColor = UIColor.appBlue;
        
        setupClearButton();
        setupDirectionsLabel();
        setupSignUpFields();
        setupTermsView();
        setupSignUpButton();
        setupLoadingView();
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
        
        signUpButton.addTarget(self, action: #selector(self.handleSignUpAttempt), for: .touchUpInside);
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
    
    func hideLaodingView(){
        UIView.animate(withDuration: 0.3) {
            self.loadingView.isHidden = true;
        }
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
    
    @objc func handleSignUpAttempt(){
//        print("attempt");
        self.signUpFields.resignAllFields();
        let cellData = signUpFields.getAllData();
        if(cellData.count < 6){
            let alert = UIAlertController(title: "Ugh-Oh", message: "Please fill out all fields", preferredStyle: .alert);
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil));
            self.present(alert, animated: true, completion: nil);
            return;
        }else{
            self.showLoadingView();
            
//            let url = URL(string: "http://localhost:3000/user_SignUp")!;
            let url = URL(string:"http://ec2-54-191-14-29.us-west-2.compute.amazonaws.com:3000/user_SignUp")!;
            var request = URLRequest(url: url);
            let postBody = "userName=\(cellData[0])&firstName=\(cellData[1])&lastName=\(cellData[2])&email=\(cellData[3])&phoneNumber=\(cellData[4])&password=\(cellData[5])";
            request.httpMethod = "POST";
            request.httpBody = postBody.data(using: .utf8);
            let task = URLSession.shared.dataTask(with: request) { (data, re, err) in
                if(err != nil){
                    print("err");
                    DispatchQueue.main.async {
                        self.showErrorAlert();
                    }
                    return;
                }
                if(data != nil){
                    let response = NSString(data: data!, encoding: 8)!;
                    if(response == "emailExists"){
//                        print("email exists");
                        DispatchQueue.main.async {
                            self.showEmailExistsAlert();
                        }
                    }else if(response == "success"){
//                        print("successful");
                    }
                }
            }
            task.resume();
        }
    }
    
    fileprivate func showEmailExistsAlert(){
        self.hideLaodingView();
        let alert = UIAlertController(title: "Email/Username/Phone # Found", message: "Some of your data was already registered! Please login!", preferredStyle: .alert);
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil));
        self.present(alert, animated: true, completion: nil);
    }
    
    fileprivate func showErrorAlert(){
        self.hideLaodingView();
        let alert = UIAlertController(title: "Error", message: "There was an error connecting to our servers. Please try again later!", preferredStyle: .alert);
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil));
        self.present(alert, animated: true, completion: nil);
    }
}

