//
//  User.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/16/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

struct User{
    
    var userID: Int;
    var firstName: String;
    var lastName: String;
    var userName: String;
    var email: String;
    var phoneNumber: String;
    var password: String;
    var push: String;
    var sms: String;
    var imgURL: String;
    var userLatitude: String?;
    var userLongitude: String?;
    
    init(userID: Int, firstName: String, lastName: String, userName: String, email: String, phoneNumber: String, password: String, push: String, sms: String, imgURL: String) {
        self.userID = userID;
        self.firstName = firstName;
        self.lastName = lastName;
        self.userName = userName;
        self.email = email;
        self.phoneNumber = phoneNumber;
        self.password = password;
        self.push = push;
        self.sms = sms;
        self.imgURL = imgURL;
    }
}
