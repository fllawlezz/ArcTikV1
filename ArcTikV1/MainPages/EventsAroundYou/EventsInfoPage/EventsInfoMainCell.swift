//
//  EventsInfoMainCell.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/6/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

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
//        peopleLabel.backgroundColor = UIColor.red;
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


    
    override init(frame: CGRect) {
        super.init(frame: frame);
//        self.backgroundColor = UIColor.red;
        setupPeople();
        setupPrice();
        setupRequirements();
        setupToBring()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setupPeople(){
        self.addSubview(peopleImageView);
        peopleImageView.anchor(left: self.leftAnchor, right: nil, top: self.topAnchor, bottom: nil, constantLeft: self.frame.width/4, constantRight: 0, constantTop: 15, constantBottom: 0, width: 40, height: 40);
        
        self.addSubview(peopleLabel);
        self.peopleLabel.centerXAnchor.constraint(equalTo: self.peopleImageView.centerXAnchor).isActive = true;
        self.peopleLabel.topAnchor.constraint(equalTo: self.peopleImageView.bottomAnchor).isActive = true;
        self.peopleLabel.widthAnchor.constraint(equalToConstant: 70).isActive = true;
        self.peopleLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true;
    }
    
    fileprivate func setupPrice(){
        self.addSubview(priceImageView);
        priceImageView.anchor(left: nil, right: self.rightAnchor, top: self.topAnchor, bottom: nil, constantLeft: 0, constantRight: -(self.frame.width/4), constantTop: 15, constantBottom: 0, width: 40, height: 40);
        
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
        self.requirementsBackground.widthAnchor.constraint(equalToConstant: 100).isActive = true;
//        requirementsBackground.anchor(left: self.leftAnchor, right: self.centerXAnchor, top: self.priceLabel.bottomAnchor, bottom: self.centerYAnchor, constantLeft: 25, constantRight: 0, constantTop: 10, constantBottom: 0, width: 0, height: 0);
    }
    
    fileprivate func setupToBring(){
        self.addSubview(bringBackground);
        self.bringBackground.centerXAnchor.constraint(equalTo: self.priceImageView.centerXAnchor).isActive = true;
        self.bringBackground.topAnchor.constraint(equalTo: self.priceLabel.bottomAnchor).isActive = true;
        self.bringBackground.heightAnchor.constraint(equalToConstant: 200).isActive = true;
        self.bringBackground.widthAnchor.constraint(equalToConstant: 100).isActive = true;
        
    }
}
