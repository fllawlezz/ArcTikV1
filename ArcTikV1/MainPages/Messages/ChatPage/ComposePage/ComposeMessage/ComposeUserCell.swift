//
//  ComposeUserCell.swift
//  ArcTikV1
//
//  Created by Brandon In on 2/2/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

class ComposeUserCell: UITableViewCell{
    
    var userImage: UIImageView = {
        let userImage = UIImageView();
        userImage.image = #imageLiteral(resourceName: "noImageIcon");
        userImage.translatesAutoresizingMaskIntoConstraints = false;
        userImage.clipsToBounds = true;
        userImage.layer.cornerRadius = 15;
        return userImage;
    }()
    
    var userNameLabel: NormalUILabel = {
        let userNameLabel = NormalUILabel(textColor: .darkText, font: .montserratMedium(fontSize: 16), textAlign: .left);
        userNameLabel.text = "userName goes here";
        userNameLabel.numberOfLines = 0;
        return userNameLabel;
    }()
    
    var checkMarkImage: UIImageView = {
        let checkMarkImage = UIImageView();
        checkMarkImage.image = #imageLiteral(resourceName: "greenCheck");
        checkMarkImage.translatesAutoresizingMaskIntoConstraints = false;
        checkMarkImage.clipsToBounds = true;
        checkMarkImage.layer.cornerRadius = 12.5;
        return checkMarkImage;
    }()
    
    var friend: Friend?;
    var selectedCell: Bool = false;
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        
        self.backgroundColor = UIColor.white;
        setupUserImage();
        setupUserNameLabel();
        setupCheckMarkImage();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setupUserImage(){
        self.addSubview(userImage);
        userImage.anchor(left: self.leftAnchor, right: nil, top: nil, bottom: nil, constantLeft: 20, constantRight: 0, constantTop: 0, constantBottom: 0, width: 35, height: 35);
        userImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true;
    }
    
    fileprivate func setupUserNameLabel(){
        self.addSubview(userNameLabel);
        userNameLabel.anchor(left: self.userImage.rightAnchor, right: self.rightAnchor, top: nil, bottom: nil, constantLeft: 20, constantRight: -50, constantTop: 10, constantBottom: -10, width: 0, height: 25);
        userNameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true;
    }
    
    fileprivate func setupCheckMarkImage(){
        self.addSubview(checkMarkImage);
        checkMarkImage.anchor(left: nil, right: self.rightAnchor, top: nil, bottom: nil, constantLeft: 0, constantRight: -15, constantTop: 0, constantBottom: 0, width: 25, height: 25);
        checkMarkImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true;
        if(selectedCell){
            checkMarkImage.isHidden = false;
        }else{
            checkMarkImage.isHidden = true;
        }
    }
    
    func setUserImage(userImage: UIImage){
        self.userImage.image = userImage;
    }
    
    func setUserName(userName: String){
        self.userNameLabel.text = userName;
    }
    
    func cellPressed()->Bool{
        if(selectedCell){
            self.selectedCell = false;
            self.checkMarkImage.isHidden = true;
        }else{
            self.selectedCell = true;
            self.checkMarkImage.isHidden = false;
        }
        return self.selectedCell;
    }
}
