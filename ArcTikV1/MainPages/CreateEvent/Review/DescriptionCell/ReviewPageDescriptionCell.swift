//
//  ReviewPageDescriptionCell.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/11/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

protocol ReviewPageDescriptionCellDelegate{
    func seeMoreDescription();
}

class ReviewPageDescriptionCell: UICollectionViewCell{
    
    var descriptionTextView: UITextView = {
        let descriptionTextView = UITextView();
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false;
        descriptionTextView.font = UIFont.systemFont(ofSize: 14);
        descriptionTextView.isSelectable = false;
        descriptionTextView.isEditable = false;
        descriptionTextView.isScrollEnabled = false;
        descriptionTextView.backgroundColor = UIColor.white;
        descriptionTextView.layer.cornerRadius = 4;
//        descriptionTextView.layer.borderColor = UIColor.darkText.cgColor;
//        descriptionTextView.layer.borderWidth = 1;
        return descriptionTextView;
    }()
    
    var seeMoreButton: NormalUIButton = {
        let seeMoreButton = NormalUIButton(type: .system);
        seeMoreButton.setButtonProperties(backgroundColor: .white, title: "See More", font: .montserratRegular(fontSize: 12), fontColor: .lightAppBlue);
        return seeMoreButton;
    }()
    
    var textViewBottomAnchor: NSLayoutConstraint?;
    var isExpanded:Bool?{
        didSet{
            if(isExpanded!){
                seeMoreButton.isHidden = true;
                textViewBottomAnchor?.constant = -10;
            }
        }
    }
    
    var delegate: ReviewPageDescriptionCellDelegate?;
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = UIColor.white;
        setupDescriptionTextView();
        setupSeeMoreButton();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setupDescriptionTextView(){
        self.addSubview(descriptionTextView);
        descriptionTextView.anchor(left: self.leftAnchor, right: self.rightAnchor, top: self.topAnchor, bottom: nil, constantLeft: 25, constantRight: -25, constantTop: 10, constantBottom: 0, width: 0, height: 0);
        textViewBottomAnchor = descriptionTextView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20);
        textViewBottomAnchor?.isActive = true;
    }
    
    fileprivate func setupSeeMoreButton(){
        self.addSubview(seeMoreButton);
        seeMoreButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true;
        seeMoreButton.widthAnchor.constraint(equalToConstant: 70).isActive = true;
        seeMoreButton.heightAnchor.constraint(equalToConstant: 20).isActive = true;
        seeMoreButton.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true;
        
        if(currentEventInProgress!.eventDescription!.count < 40){
            seeMoreButton.isHidden = true;
        }else{
            seeMoreButton.isHidden = false;
        }
        
        seeMoreButton.addTarget(self, action: #selector(self.handleSeeMoreButtonPressed), for: .touchUpInside);
    }
    
    func setDescription(description: String){
        self.descriptionTextView.text = description;
    }
    
    @objc func handleSeeMoreButtonPressed(){
        delegate?.seeMoreDescription();
    }
}
