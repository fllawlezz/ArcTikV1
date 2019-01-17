//
//  GlobalFunctions.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/16/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

func saveUser(userID:Int, firstName: String, lastName: String, userName: String, email: String, phoneNumber: String, password: String, push: String, sms: String, imgURL: String){
    
    standard?.set(userID, forKey: "userID");
    standard?.set(firstName, forKey: "firstName");
    standard?.set(lastName, forKey: "lastName");
    standard?.set(userName, forKey: "userName");
    standard?.set(email, forKey: "email");
    standard?.set(phoneNumber, forKey: "phoneNumber");
    standard?.set(password, forKey: "password");
    standard?.set(push, forKey: "push");
    standard?.set(sms, forKey: "sms");
    standard?.set(imgURL, forKey: "imgURL");
    
}

func clearUser(){
    standard?.removeObject(forKey: "userID");
    standard?.removeObject(forKey: "firstName");
    standard?.removeObject(forKey: "lastName");
    standard?.removeObject(forKey: "userName");
    standard?.removeObject(forKey: "email");
    standard?.removeObject(forKey: "phoneNumber");
    standard?.removeObject(forKey: "password");
    standard?.removeObject(forKey: "push");
    standard?.removeObject(forKey: "sms");
    standard?.removeObject(forKey: "imgURL");
}

func populateUser(){
    
    let userID = standard?.object(forKey: "userID") as! Int;
    let firstName = standard?.object(forKey: "firstName") as! String
    let lastName = standard?.object(forKey: "lastName") as! String
    let userName = standard?.object(forKey: "userName") as! String
    let email = standard?.object(forKey: "email") as! String
    let phoneNumber = standard?.object(forKey: "phoneNumber") as! String
    let password = standard?.object(forKey: "password") as! String
    let push = standard?.object(forKey: "push") as! String
    let sms = standard?.object(forKey: "sms") as! String
    let imgURL = standard?.object(forKey: "imgURL") as! String
    
    user = User.init(userID: userID, firstName: firstName, lastName: lastName, userName: userName, email: email, phoneNumber: phoneNumber, password: password, push: push, sms: sms, imgURL: imgURL);
}
