//
//  EventsInfoMainCell.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/6/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

protocol EventsInfoMainCellDelegate{
    func handleApplied();
}

class EventsInfoMainCell: UICollectionViewCell{
    
    var peopleImageView: UIImageView = {
        let peopleImageView = UIImageView(image: #imageLiteral(resourceName: "people"));
        peopleImageView.translatesAutoresizingMaskIntoConstraints = false;
        peopleImageView.contentMode = .scaleAspectFill;
        return peopleImageView;
    }()
    
    var peopleLabel: NormalUILabel = {
        let peopleLabel = NormalUILabel(textColor: .white, font: .montserratSemiBold(fontSize: 16), textAlign: .center);
        peopleLabel.text = "40/100";
        return peopleLabel;
    }()
    
    var priceImageView: UIImageView = {
        let priceImageView = UIImageView(image: #imageLiteral(resourceName: "cash"));
        priceImageView.translatesAutoresizingMaskIntoConstraints = false;
        priceImageView.contentMode = .scaleAspectFill;
        return priceImageView;
    }()
    
    var priceLabel: NormalUILabel = {
        let priceLabel = NormalUILabel(textColor: .white, font: .montserratSemiBold(fontSize: 16), textAlign: .center);
        priceLabel.text = "$60";
        return priceLabel;
    }()
    
    var requirementsBackground: UIView = {
        let requirementsBackground = UIView();
        requirementsBackground.translatesAutoresizingMaskIntoConstraints = false;
        requirementsBackground.backgroundColor = UIColor.white;
        return requirementsBackground;
    }()
    
    var bringBackground: UIView = {
        let bringBackground = UIView();
        bringBackground.translatesAutoresizingMaskIntoConstraints = false;
        bringBackground.backgroundColor = UIColor.white;
        return bringBackground;
    }()

    var descriptionBackgroundView: UIView = {
        let descriptionBackgroundView = UIView();
        descriptionBackgroundView.translatesAutoresizingMaskIntoConstraints = false;
        descriptionBackgroundView.backgroundColor = UIColor.white;
        return descriptionBackgroundView;
    }()
    
    var applyButton: NormalUIButton = {
        let applyButton = NormalUIButton(type: .system);
        applyButton.translatesAutoresizingMaskIntoConstraints = false;
        applyButton.setButtonProperties(backgroundColor: .appBlue, title: "Apply", font: .montserratSemiBold(fontSize: 16), fontColor: .white);
        applyButton.layer.cornerRadius = 3;
        applyButton.layer.borderColor = UIColor.white.cgColor;
        applyButton.layer.borderWidth = 2;
        return applyButton;
    }()
    
    var delegate: EventsInfoMainCellDelegate?;
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        setupPeople();
        setupPrice();
        setupRequirements();
        setupToBring()
        setupDescription();
        setupApplyButton();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setupPeople(){
        self.addSubview(peopleImageView);
        peopleImageView.anchor(left: self.leftAnchor, right: nil, top: self.topAnchor, bottom: nil, constantLeft: (self.frame.width/4)-10, constantRight: 0, constantTop: 15, constantBottom: 0, width: 40, height: 40);
        
        self.addSubview(peopleLabel);
        self.peopleLabel.centerXAnchor.constraint(equalTo: self.peopleImageView.centerXAnchor).isActive = true;
        self.peopleLabel.topAnchor.constraint(equalTo: self.peopleImageView.bottomAnchor).isActive = true;
        self.peopleLabel.widthAnchor.constraint(equalToConstant: 70).isActive = true;
        self.peopleLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true;
    }
    
    fileprivate func setupPrice(){
        self.addSubview(priceImageView);
        priceImageView.anchor(left: nil, right: self.rightAnchor, top: self.topAnchor, bottom: nil, constantLeft: 0, constantRight: -(self.frame.width/4)+10, constantTop: 15, constantBottom: 0, width: 40, height: 40);
        
        self.addSubview(priceLabel);
        priceLabel.centerXAnchor.constraint(equalTo: self.priceImageView.centerXAnchor).isActive = true;
        priceLabel.topAnchor.constraint(equalTo: self.priceImageView.bottomAnchor).isActive = true;
        priceLabel.widthAnchor.constraint(equalToConstant: 70).isActive = true;
        priceLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true;
    }
    
    fileprivate func setupRequirements(){
        self.addSubview(requirementsBackground);
        self.requirementsBackground.centerXAnchor.constraint(equalTo: self.peopleImageView.centerXAnchor).isActive = true;
        self.requirementsBackground.topAnchor.constraint(equalTo: self.peopleLabel.bottomAnchor).isActive = true;
        self.requirementsBackground.heightAnchor.constraint(equalToConstant: 200).isActive = true;
        self.requirementsBackground.widthAnchor.constraint(equalToConstant: 150).isActive = true;
    }
    
    fileprivate func setupToBring(){
        self.addSubview(bringBackground);
        self.bringBackground.centerXAnchor.constraint(equalTo: self.priceImageView.centerXAnchor).isActive = true;
        self.bringBackground.topAnchor.constraint(equalTo: self.priceLabel.bottomAnchor).isActive = true;
        self.bringBackground.heightAnchor.constraint(equalToConstant: 200).isActive = true;
        self.bringBackground.widthAnchor.constraint(equalToConstant: 150).isActive = true;
        
    }
    
    fileprivate func setupDescription(){
        self.addSubview(descriptionBackgroundView);
        descriptionBackgroundView.anchor(left: self.requirementsBackground.leftAnchor, right: self.bringBackground.rightAnchor, top: self.bringBackground.bottomAnchor, bottom: nil, constantLeft: 0, constantRight: 0, constantTop: 20, constantBottom: 0, width: 0, height: 150);
        
    }
    
    fileprivate func setupApplyButton(){
        self.addSubview(applyButton);
        applyButton.anchor(left: self.leftAnchor, right: self.rightAnchor, top: self.descriptionBackgroundView.bottomAnchor, bottom: nil, constantLeft: 50, constantRight: -50, constantTop: 30, constantBottom: 0, width: 0, height: 50)
        applyButton.addTarget(self, action: #selector(handleAppliedPressed), for: .touchUpInside);
    }
}

extension EventsInfoMainCell{
    @objc func handleAppliedPressed(){
        self.delegate?.handleApplied();
    }
}
