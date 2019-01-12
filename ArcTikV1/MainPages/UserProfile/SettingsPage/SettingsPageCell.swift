//
//  SettingsPageCollectionView.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/9/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

class SettingsPageCell: UICollectionViewCell{
    
    var titleLabel:NormalUILabel = {
        let titleLabel = NormalUILabel(textColor: .darkText, font: .montserratSemiBold(fontSize: 14), textAlign: .left);
        titleLabel.text = "Notifications"
        return titleLabel;
    }()
    
    var descriptionLabel:NormalUILabel = {
        let descriptionLabel = NormalUILabel(textColor: .gray, font: .montserratSemiBold(fontSize: 12), textAlign: .left);
        descriptionLabel.text = "error";
        return descriptionLabel;
    }()
    
    var onOffSwitch: UISwitch = {
        let onOffSwitch = UISwitch();
        onOffSwitch.translatesAutoresizingMaskIntoConstraints = false;
        onOffSwitch.isOn = false;
        return onOffSwitch;
    }()
    
    var border: UIView = {
        let border = UIView();
        border.translatesAutoresizingMaskIntoConstraints = false;
        border.backgroundColor = UIColor.lightGray;
        return border;
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = UIColor.white;
        setupTitleLabel();
        setupDescriptionLabel();
        setupSwitch();
        setupBorder();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setupTitleLabel(){
        self.addSubview(titleLabel);
        titleLabel.anchor(left: self.leftAnchor, right: self.rightAnchor, top: self.topAnchor, bottom: nil, constantLeft: 10, constantRight: -60, constantTop: 5, constantBottom: 0, width: 0, height: 30);
    }
    
    fileprivate func setupDescriptionLabel(){
        self.addSubview(descriptionLabel);
        descriptionLabel.anchor(left: self.titleLabel.leftAnchor, right: self.titleLabel.rightAnchor, top: self.titleLabel.bottomAnchor, bottom: nil, constantLeft: 0, constantRight: 0, constantTop: 0, constantBottom: -10, width: 0, height: 30)
    }
    
    fileprivate func setupSwitch(){
        self.addSubview(onOffSwitch);
        onOffSwitch.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true;
        onOffSwitch.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true;
        onOffSwitch.widthAnchor.constraint(equalToConstant: 50).isActive = true;
        onOffSwitch.heightAnchor.constraint(equalToConstant: 40).isActive = true;
    }
    
    fileprivate func setupBorder(){
        self.addSubview(border);
        border.anchor(left: self.leftAnchor, right: self.rightAnchor, top: nil, bottom: self.bottomAnchor, constantLeft: 0, constantRight: 0, constantTop: 0, constantBottom: 0, width: 0, height: 0.4);
    }
    
    func setTitleAndDescription(title: String, description: String){
        self.titleLabel.text = title;
        self.descriptionLabel.text = description;
    }
    
    func hideSwitch(){
        self.onOffSwitch.isHidden = true;
    }
}
