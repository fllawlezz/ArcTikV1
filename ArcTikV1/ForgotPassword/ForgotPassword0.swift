//
//  ForgotPasswordEnterEmail.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/17/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

class ForgotPasswordPage0: UIViewController, UITextFieldDelegate{
    
    var clearButton: NormalUIButton = {
        let clearButton = NormalUIButton(type: .system);
        clearButton.setBackgroundImage(UIImage(named: "clearWhite"), for: .normal);
        return clearButton;
    }();
    
    var descriptionLabel: NormalUILabel = {
        let descriptionLabel = NormalUILabel(textColor: .white, font: .montserratSemiBold(fontSize: 16), textAlign: .center);
        descriptionLabel.text = "Enter your Email/Username";
        descriptionLabel.numberOfLines = 1;
        return descriptionLabel;
    }();
    
    var emailUserNameField: NormalUITextField = {
        let emailUserNameField = NormalUITextField();
        emailUserNameField.translatesAutoresizingMaskIntoConstraints = false;
        emailUserNameField.font = UIFont.systemFont(ofSize: 14);
        emailUserNameField.textColor = UIColor.darkText;
        emailUserNameField.placeholder = "Email/UserName";
        emailUserNameField.autocorrectionType = .no;
        emailUserNameField.spellCheckingType = .no;
        emailUserNameField.backgroundColor = UIColor.white;
        emailUserNameField.layer.cornerRadius = 5;
        return emailUserNameField;
    }()
    
    var submitButton: NormalUIButton = {
        let submitButton = NormalUIButton(type: .system);
        submitButton.setButtonProperties(backgroundColor: .appBlue, title: "Submit", font: .montserratSemiBold(fontSize: 16), fontColor: .white);
        submitButton.layer.cornerRadius = 5;
        submitButton.layer.borderColor = UIColor.white.cgColor;
        submitButton.layer.borderWidth = 2;
        return submitButton;
    }()
    
    var loadingView = LoadingView();
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.view.backgroundColor = UIColor.appBlue;
        setupClearButton();
        setupDescription();
        setupEmailUserNameField();
        setupSubmitButton();
        setupLoadingView();
        emailUserNameField.becomeFirstResponder();
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
        descriptionLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true;
        descriptionLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true;
        descriptionLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true;
        descriptionLabel.widthAnchor.constraint(equalToConstant: 225).isActive = true;
    }
    
    fileprivate func setupEmailUserNameField(){
        self.view.addSubview(emailUserNameField);
        emailUserNameField.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 40).isActive = true;
        emailUserNameField.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -40).isActive = true;
        emailUserNameField.topAnchor.constraint(equalTo: self.descriptionLabel.bottomAnchor, constant: 20).isActive = true;
        emailUserNameField.heightAnchor.constraint(equalToConstant: 40).isActive = true;
        emailUserNameField.delegate = self;
    }
    
    fileprivate func setupSubmitButton(){
        self.view.addSubview(submitButton);
        submitButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 40).isActive = true;
        submitButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -40).isActive = true;
        submitButton.topAnchor.constraint(equalTo: self.emailUserNameField.bottomAnchor, constant: 20).isActive = true;
        submitButton.heightAnchor.constraint(equalToConstant: 50).isActive = true;
        
        submitButton.addTarget(self, action: #selector(self.handleSubmit), for: .touchUpInside);
    }
    
    fileprivate func setupLoadingView(){
        self.view.addSubview(loadingView);
        loadingView.anchor(left: self.view.leftAnchor, right: self.view.rightAnchor, top: self.view.topAnchor, bottom: self.view.bottomAnchor)
        loadingView.isHidden = true;
    }
}
extension ForgotPasswordPage0{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if(textField.text!.count > 0){
            self.handleSubmit();
        }
        return true;
    }
    
    @objc func handleClearPressed(){
        self.navigationController?.popViewController(animated: true);
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
       
        
        let url = URL(string: "http://localhost:3000/forgotPasswordSendCode")!;
        var request = URLRequest(url: url);
        let body = "userNameEmail=\(self.emailUserNameField.text!)";
        request.httpMethod = "POST";
        request.httpBody = body.data(using: .utf8);
        let task = URLSession.shared.dataTask(with: request) { (data, res, err) in
            if(err != nil){
                print("error");
                DispatchQueue.main.async {
                    self.hideLoadingView();
                    self.showErrorAlert();
                }
                return;
            }
            if(data != nil){
                let response = NSString(data: data!, encoding: 8)!;
                
//                print(response);
                
                if(response as String == "notFound"){
                    DispatchQueue.main.async {
                        //show alert that the username/email not found
                        self.showNotFoundAlert();
                    }
                }else{
                    do{
                        let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! NSDictionary
                        let userID = json["userID"] as! Int;
                        let code = json["code"] as! String;
                        let oldPassword = json["oldPassword"] as! String;
                        DispatchQueue.main.async {
                            //response = code
                            let forgotPasswordPage1 = ForgotPasswordPage1();
                            forgotPasswordPage1.userID = userID;
                            forgotPasswordPage1.code = code;
                            forgotPasswordPage1.oldPassword = oldPassword;
                            self.navigationController?.pushViewController(forgotPasswordPage1, animated: true);
                        }
                    }catch{
                        DispatchQueue.main.async {
                            self.hideLoadingView();
                        }
                        print("error parsing json");
                    }
                    
                    
                   
                }
            }
            
        }
        task.resume();
        
    }
    
    fileprivate func showNotFoundAlert(){
        let alert = UIAlertController(title: "No Match", message: "You username/email did not match any in our records", preferredStyle: .alert);
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil));
        self.present(alert, animated: true, completion: nil);
    }
    
    fileprivate func showErrorAlert(){
        let alert = UIAlertController(title: "Oops!", message: "There was a problem connecting to our servers! Please try again later", preferredStyle: .alert);
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {(action) in
            self.navigationController?.popToRootViewController(animated: true);
        }));
        self.present(alert, animated: true, completion: nil);
    }
}
