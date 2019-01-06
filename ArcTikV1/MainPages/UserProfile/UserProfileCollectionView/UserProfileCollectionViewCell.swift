//
//  UserProfileCollectionViewCell.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/6/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit


class UserProfileCollectionViewCell: UICollectionViewCell{
    
    var titleLabel: NormalUILabel = {
        let titleLabel = NormalUILabel(textColor: .darkText, font: .montserratSemiBold(fontSize: 14), textAlign: .left);
        titleLabel.text = "Error";
        return titleLabel;
    }()
    
    var descriptionLabel: NormalUILabel = {
        let descriptionLabel = NormalUILabel(textColor: .lightGray, font: .montserratSemiBold(fontSize: 12), textAlign: .left);
        descriptionLabel.text = "OOPs something went wrong";
        return descriptionLabel;
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = UIColor.white;
        setupTitleLabel();
        setupDescriptionLabel();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setupTitleLabel(){
        self.addSubview(titleLabel);
        titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true;
        titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true;
        titleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true;
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 15).isActive = true;
//        titleLabel.backgroundColor = .red;
    }
    
    fileprivate func setupDescriptionLabel(){
        self.addSubview(descriptionLabel);
        descriptionLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true;
        descriptionLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true;
        descriptionLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true;
        descriptionLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor).isActive = true;
    }
    
    func setTitle(title: String){
        self.titleLabel.text = title;
    }
    
    func setDescription(description: String){
        self.descriptionLabel.text = description;
    }
}
