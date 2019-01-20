//
//  ReviewPageListCell.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/19/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

class ReviewPageListCell: UICollectionViewCell{
    
    var descriptionLabel: NormalUILabel = {
        let descriptionLabel = NormalUILabel(textColor: .darkText, font: .montserratMedium(fontSize: 14), textAlign: .left);
        descriptionLabel.text = "Text goes here";
        return descriptionLabel;
    }()
    
    var rightArrowImage: UIImageView = {
        let rightArrowImage = UIImageView(image: #imageLiteral(resourceName: "rightArrow"));
        rightArrowImage.translatesAutoresizingMaskIntoConstraints = false;
        rightArrowImage.contentMode = .scaleAspectFill;
        return rightArrowImage;
    }()
    
    var border = BorderView();
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = UIColor.white;
        setupDescriptionLabel();
        setupRightArrowImage();
        setupBorder();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setupDescriptionLabel(){
        self.addSubview(descriptionLabel);
        descriptionLabel.anchor(left: self.leftAnchor, right: self.rightAnchor, top: self.topAnchor, bottom: self.bottomAnchor, constantLeft: 25, constantRight: -25, constantTop: 0, constantBottom: 0, width: 0, height: 0);
    }
    
    fileprivate func setupRightArrowImage(){
        self.addSubview(rightArrowImage);
        rightArrowImage.anchor(left: nil, right: self.rightAnchor, top: nil, bottom: nil, constantLeft: 0, constantRight: -10, constantTop: 0, constantBottom: 0, width: 20, height: 20);
        rightArrowImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true;
        rightArrowImage.alpha = 0.7;
    }
    
    fileprivate func setupBorder(){
        self.addSubview(border);
        border.anchor(left: self.leftAnchor, right: self.rightAnchor, top: nil, bottom: self.bottomAnchor, constantLeft: 25, constantRight: 0, constantTop: 0, constantBottom: 0, width: 0, height: 0.4);
    }
    
    func setDescriptionText(description: String){
        self.descriptionLabel.text = description;
    }
}
