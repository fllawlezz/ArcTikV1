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
    
    var requirementsImageView: UIImageView = {
       let requirementsImageView = UIImageView(image: #imageLiteral(resourceName: "checkMark"))
        requirementsImageView.translatesAutoresizingMaskIntoConstraints = false;
        requirementsImageView.contentMode = .scaleAspectFill;
        requirementsImageView.clipsToBounds = true;
        return requirementsImageView;
    }()
    
    var requirementsLabel: NormalUILabel = {
        let requirementsLabel = NormalUILabel(textColor: .darkText, font: .montserratSemiBold(fontSize: 14), textAlign: .center);
        requirementsLabel.text = "Requirements";
        return requirementsLabel;
    }()
    
    var requirementsTextView: UITextView = {
        let requirementsTextView = UITextView();
        requirementsTextView.translatesAutoresizingMaskIntoConstraints = false;
        requirementsTextView.font = UIFont.montserratRegular(fontSize: 12);
//        requirementsTextView.isScrollEnabled = false;
        requirementsTextView.isEditable = false;
        requirementsTextView.isSelectable = false;
//        requirementsTextView.backgroundColor = UIColor.red;
        return requirementsTextView;
    }()
    
    var bringBackground: UIView = {
        let bringBackground = UIView();
        bringBackground.translatesAutoresizingMaskIntoConstraints = false;
        bringBackground.backgroundColor = UIColor.white;
        return bringBackground;
    }()
    
    var bringImageView: UIImageView = {
        let bringImageView = UIImageView(image: #imageLiteral(resourceName: "box"));
        bringImageView.translatesAutoresizingMaskIntoConstraints = false;
        bringImageView.clipsToBounds = true;
        return bringImageView;
    }()
    
    var bringLabel: NormalUILabel = {
        let bringLabel = NormalUILabel(textColor: .darkText, font: .montserratSemiBold(fontSize: 14), textAlign: .center);
        bringLabel.text = "To Bring";
        return bringLabel;
    }()
    
    var bringTextView: UITextView = {
        let bringTextView = UITextView();
        bringTextView.translatesAutoresizingMaskIntoConstraints = false;
        bringTextView.font = UIFont.montserratRegular(fontSize: 12);
        //        requirementsTextView.isScrollEnabled = false;
        bringTextView.isEditable = false;
        bringTextView.isSelectable = false;
        //        requirementsTextView.backgroundColor = UIColor.red;
        return bringTextView;
    }()

    var descriptionBackgroundView: UIView = {
        let descriptionBackgroundView = UIView();
        descriptionBackgroundView.translatesAutoresizingMaskIntoConstraints = false;
        descriptionBackgroundView.backgroundColor = UIColor.white;
        return descriptionBackgroundView;
    }()
    
    var descriptionLabel: NormalUILabel = {
        let descriptionLabel = NormalUILabel(textColor: .darkText, font: .montserratSemiBold(fontSize: 14), textAlign: .center);
        descriptionLabel.text = "Description";
        return descriptionLabel;
    }()
    
    var descriptionImageView: UIImageView = {
        let descriptionImageView = UIImageView(image: #imageLiteral(resourceName: "documents"));
        descriptionImageView.translatesAutoresizingMaskIntoConstraints = false;
        return descriptionImageView;
    }()
    
    var descriptionTextView: UITextView = {
        let descriptionTextView = UITextView();
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false;
        descriptionTextView.font = UIFont.montserratRegular(fontSize: 14);
        //        requirementsTextView.isScrollEnabled = false;
        descriptionTextView.isEditable = false;
        descriptionTextView.isSelectable = false;
        //        requirementsTextView.backgroundColor = UIColor.red;
        return descriptionTextView;
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
    
    let exampleText = "- Not Jason Koon \n - Able to play poker \n- Knows the game well\n- Not Phil Hellmuth \n- Yes Phil Hellmuth \n- Yes Tom Dwan \n- Not Andrew Robl \n - Not Elton Tsang \n - Not the president";
    
    let exampleToBring = "- $60";
    let exampleDescription = "Hi everybody, as one of the best poker players on the planet, I am hosting a poker tournament within my home. The buy in is $60, and the prize pool is $5,000. We will only host if at least 90 people sign up!"
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        setupPeople();
        setupPrice();
        setupRequirements();
        setupToBring()
        setupDescription();
        setupApplyButton();
        setRequirementsText(text: exampleText);
        setToBring(text: exampleToBring);
        setDescriptionText(text: exampleDescription);
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
        self.requirementsBackground.topAnchor.constraint(equalTo: self.peopleLabel.bottomAnchor, constant: 10).isActive = true;
        self.requirementsBackground.heightAnchor.constraint(equalToConstant: 200).isActive = true;
        self.requirementsBackground.widthAnchor.constraint(equalToConstant: 150).isActive = true;
        
        self.requirementsBackground.addSubview(requirementsLabel);
        requirementsLabel.anchor(left: self.requirementsBackground.leftAnchor, right: requirementsBackground.rightAnchor, top: requirementsBackground.topAnchor, bottom: nil, constantLeft: 20, constantRight: 0, constantTop: 0, constantBottom: 0, width: 0, height: 30);
        
//        requirementsLabel.backgroundColor = UIColor.blue;
        
        self.requirementsBackground.addSubview(requirementsImageView);
        requirementsImageView.anchor(left: self.requirementsBackground.leftAnchor, right: nil, top: self.requirementsBackground.topAnchor, bottom: nil, constantLeft: 10, constantRight: 0, constantTop: 5, constantBottom: 0, width: 20, height: 20);
        
        self.requirementsBackground.addSubview(requirementsTextView);
        requirementsTextView.anchor(left: self.requirementsBackground.leftAnchor, right: requirementsBackground.rightAnchor, top: requirementsLabel.bottomAnchor, bottom: requirementsBackground.bottomAnchor, constantLeft: 10, constantRight: -10, constantTop: 5, constantBottom: -10, width: 0, height: 0 );
    }
    
    fileprivate func setupToBring(){
        self.addSubview(bringBackground);
        self.bringBackground.centerXAnchor.constraint(equalTo: self.priceImageView.centerXAnchor).isActive = true;
        self.bringBackground.topAnchor.constraint(equalTo: self.priceLabel.bottomAnchor, constant: 10).isActive = true;
        self.bringBackground.heightAnchor.constraint(equalToConstant: 200).isActive = true;
        self.bringBackground.widthAnchor.constraint(equalToConstant: 150).isActive = true;
        
        self.bringBackground.addSubview(bringLabel);
        bringLabel.anchor(left: self.bringBackground.leftAnchor, right: bringBackground.rightAnchor, top: bringBackground.topAnchor, bottom: nil, constantLeft: 20, constantRight: 0, constantTop: 0, constantBottom: 0, width: 0, height: 30);
        
        self.bringBackground.addSubview(bringImageView);
        bringImageView.anchor(left: bringBackground.leftAnchor, right: nil, top: bringBackground.topAnchor, bottom: nil, constantLeft: 30, constantRight: 0, constantTop: 5, constantBottom: 0, width: 20, height: 20);
        
        self.bringBackground.addSubview(bringTextView);
        bringTextView.anchor(left: bringBackground.leftAnchor, right: bringBackground.rightAnchor, top: bringLabel.bottomAnchor, bottom: bringBackground.bottomAnchor, constantLeft: 10, constantRight: -10, constantTop: 5, constantBottom: -10, width: 0, height: 0);
        
    }
    
    fileprivate func setupDescription(){
        self.addSubview(descriptionBackgroundView);
        descriptionBackgroundView.anchor(left: self.requirementsBackground.leftAnchor, right: self.bringBackground.rightAnchor, top: self.bringBackground.bottomAnchor, bottom: nil, constantLeft: 0, constantRight: 0, constantTop: 20, constantBottom: 0, width: 0, height: 150);
        
        self.descriptionBackgroundView.addSubview(descriptionLabel);
        descriptionLabel.anchor(left: descriptionBackgroundView.leftAnchor, right: descriptionBackgroundView.rightAnchor, top: descriptionBackgroundView.topAnchor, bottom: nil, constantLeft: 0, constantRight: 0, constantTop: 0, constantBottom: 0, width: 0, height: 30)
        
        self.descriptionBackgroundView.addSubview(descriptionImageView);
        descriptionImageView.anchor(left: descriptionBackgroundView.leftAnchor, right: nil, top: descriptionBackgroundView.topAnchor, bottom: nil, constantLeft: 100, constantRight: 0, constantTop: 5, constantBottom: 0, width: 20, height: 20);
        
        self.descriptionBackgroundView.addSubview(descriptionTextView);
        descriptionTextView.anchor(left: descriptionBackgroundView.leftAnchor, right: descriptionBackgroundView.rightAnchor, top: descriptionLabel.bottomAnchor, bottom: descriptionBackgroundView.bottomAnchor, constantLeft: 10, constantRight: -10, constantTop: 0, constantBottom: -10, width: 0, height: 0);
        
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

extension EventsInfoMainCell{
    func setRequirementsText(text: String){
        self.requirementsTextView.text = text;
    }
    
    func setToBring(text: String){
        self.bringTextView.text = text;
    }
    
    func setDescriptionText(text: String){
        self.descriptionTextView.text = text;
    }
}
