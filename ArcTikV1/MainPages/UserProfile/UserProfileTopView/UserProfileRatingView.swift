//
//  UserProfileRatingView.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/5/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

class UserProfileRatingView: UIView{
    
    var starImageView1: UIImageView = {
        let starImageView1 = UIImageView();
        starImageView1.translatesAutoresizingMaskIntoConstraints = false;
        starImageView1.image = UIImage(named: "star");
        starImageView1.contentMode = .scaleAspectFill;
        return starImageView1;
    }()
    
    var starImageView2: UIImageView = {
        let starImageView2 = UIImageView();
        starImageView2.translatesAutoresizingMaskIntoConstraints = false;
        starImageView2.image = UIImage(named: "star");
        starImageView2.contentMode = .scaleAspectFill;
        return starImageView2;
    }()
    
    var starImageView3: UIImageView = {
        let starImageView3 = UIImageView();
        starImageView3.translatesAutoresizingMaskIntoConstraints = false;
        starImageView3.image = UIImage(named: "star");
        starImageView3.contentMode = .scaleAspectFill;
        return starImageView3;
    }()
    
    var starImageView4: UIImageView = {
        let starImageView4 = UIImageView();
        starImageView4.translatesAutoresizingMaskIntoConstraints = false;
        starImageView4.image = UIImage(named: "star");
        starImageView4.contentMode = .scaleAspectFill;
        return starImageView4;
    }()
    
    var starImageView5: UIImageView = {
        let starImageView5 = UIImageView();
        starImageView5.translatesAutoresizingMaskIntoConstraints = false;
        starImageView5.image = UIImage(named: "star");
        starImageView5.contentMode = .scaleAspectFill;
        return starImageView5;
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.backgroundColor = UIColor.appBlue;
        setupStarImageView1();
        setupStarImageView2();
        setupStarImageView3();
        setupStarImageView4();
        setupStarImageView5();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setupStarImageView1(){
        self.addSubview(starImageView1);
        starImageView1.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true;
        starImageView1.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true;
        starImageView1.heightAnchor.constraint(equalToConstant: 40).isActive = true;
        starImageView1.widthAnchor.constraint(equalToConstant: 40).isActive = true;
    }
    
    fileprivate func setupStarImageView2(){
        self.addSubview(starImageView2);
        starImageView2.leftAnchor.constraint(equalTo: self.starImageView1.rightAnchor, constant: 5).isActive = true;
        starImageView2.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true;
        starImageView2.heightAnchor.constraint(equalToConstant: 40).isActive = true;
        starImageView2.widthAnchor.constraint(equalToConstant: 40).isActive = true;
    }
    
    fileprivate func setupStarImageView3(){
        self.addSubview(starImageView3);
        starImageView3.leftAnchor.constraint(equalTo: self.starImageView2.rightAnchor, constant: 5).isActive = true;
        starImageView3.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true;
        starImageView3.heightAnchor.constraint(equalToConstant: 40).isActive = true;
        starImageView3.widthAnchor.constraint(equalToConstant: 40).isActive = true;
    }
    
    fileprivate func setupStarImageView4(){
        self.addSubview(starImageView4);
        starImageView4.leftAnchor.constraint(equalTo: self.starImageView3.rightAnchor, constant: 5).isActive = true;
        starImageView4.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true;
        starImageView4.heightAnchor.constraint(equalToConstant: 40).isActive = true;
        starImageView4.widthAnchor.constraint(equalToConstant: 40).isActive = true;
    }
    
    fileprivate func setupStarImageView5(){
        self.addSubview(starImageView5);
        starImageView5.leftAnchor.constraint(equalTo: self.starImageView4.rightAnchor, constant: 5).isActive = true;
        starImageView5.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true;
        starImageView5.heightAnchor.constraint(equalToConstant: 40).isActive = true;
        starImageView5.widthAnchor.constraint(equalToConstant: 40).isActive = true;
    }
}
