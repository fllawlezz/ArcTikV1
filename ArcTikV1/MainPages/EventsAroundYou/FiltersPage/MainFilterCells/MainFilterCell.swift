//
//  MainFilterCell.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/15/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

class MainFilterCell: UICollectionViewCell{
    
    var titleLabel: NormalUILabel = {
        let titleLabel = NormalUILabel(textColor: .darkText, font: .montserratMedium(fontSize: 14), textAlign: .left);
        titleLabel.text = "Primary Filters";
        return titleLabel;
    }()
    
    var descriptionLabel: NormalUILabel = {
        let descriptionLabel = NormalUILabel(textColor: .darkText, font: .montserratRegular(fontSize: 12), textAlign: .left);
        descriptionLabel.text = "Description text goes here";
        return descriptionLabel;
    }()
    
    var imageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "emptyCheck"));
        imageView.translatesAutoresizingMaskIntoConstraints = false;
        imageView.contentMode = .scaleAspectFill;
        return imageView;
    }()
    
    var checkBoxButton: NormalUIButton = {
        let checkBoxButton = NormalUIButton(type: .system);
        checkBoxButton.translatesAutoresizingMaskIntoConstraints = false;
        checkBoxButton.setBackgroundImage(#imageLiteral(resourceName: "emptyCheck"), for: .normal);
        return checkBoxButton;
    }()
    
    var border = BorderView();
    var buttonChecked = false;
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = UIColor.white;
        setupTitleLabel();
        setupDescriptionLabel();
        setupCheckBoxButton();
        setupBorder();

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setupTitleLabel(){
        self.addSubview(titleLabel);
        titleLabel.anchor(left: self.leftAnchor, right: self.rightAnchor, top: self.topAnchor, bottom: nil, constantLeft: 25, constantRight: -25, constantTop: 10, constantBottom: 0, width: 0, height: 25);
    }
    
    fileprivate func setupDescriptionLabel(){
        self.addSubview(descriptionLabel);
        descriptionLabel.anchor(left: self.leftAnchor, right: self.rightAnchor, top: self.titleLabel.bottomAnchor, bottom: nil, constantLeft: 25, constantRight: -25, constantTop: 5, constantBottom: 0, width: 0, height: 25);
    }
    
    fileprivate func setupCheckBoxButton(){
        self.addSubview(checkBoxButton);
        checkBoxButton.anchor(left: nil, right: self.rightAnchor, top: nil, bottom: nil, constantLeft: 0, constantRight: -25, constantTop: 0, constantBottom: 0, width: 25, height: 25);
        checkBoxButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true;
        
        checkBoxButton.addTarget(self, action: #selector(self.handleCheckBoxPressed), for: .touchUpInside);
    }
    
    fileprivate func setupBorder(){
        self.addSubview(border);
        border.anchor(left: self.leftAnchor, right: self.rightAnchor, top: nil, bottom: self.bottomAnchor, constantLeft: 25, constantRight: 0, constantTop: 0, constantBottom: 0, width: 0, height: 0.4);
    }
    
    func setTitle(text: String){
        self.titleLabel.text = text;
    }
    
    func setDescription(text: String){
        self.descriptionLabel.text = text;
    }
}

extension MainFilterCell{
    @objc func handleCheckBoxPressed(){
        if(!buttonChecked){
            self.buttonChecked = true;
            self.checkBoxButton.setBackgroundImage(#imageLiteral(resourceName: "filledCheck"), for: .normal);
        }else{
            self.buttonChecked = false;
            self.checkBoxButton.setBackgroundImage(#imageLiteral(resourceName: "emptyCheck"), for: .normal);
        }
    }
}
