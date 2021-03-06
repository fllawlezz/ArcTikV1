//
//  EventsAroundYouImageCell.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/3/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

protocol EventsAroundYouImageCellDelegate{
    func handlePosterImageViewPressed();
}

class EventsAroundYouImageCell: UICollectionViewCell{
    
    var posterImageView: UIImageView = {
        let posterImage = UIImageView();
        posterImage.translatesAutoresizingMaskIntoConstraints = false;
//        posterImage.backgroundColor = UIColor.orange;
        posterImage.contentMode = .scaleAspectFill
        posterImage.layer.cornerRadius = 15;
        posterImage.clipsToBounds = true;
        posterImage.isUserInteractionEnabled = true;
        return posterImage;
    }()
    
    var posterNameLabel: NormalUILabel = {
        let posterName = NormalUILabel(textColor: .darkText, font: .montserratSemiBold(fontSize: 12), textAlign: .left);
        posterName.text = "Daniel Negreanu";
        posterName.isUserInteractionEnabled = false;
        return posterName;
    }()
    
    var categoryLabel: NormalUILabel = {
        let categoryLabel = NormalUILabel(textColor: .darkText, font: .montserratSemiBold(fontSize: 12), textAlign: .right);
        categoryLabel.text = "Gambling";
        categoryLabel.isUserInteractionEnabled = false;
        return categoryLabel;
    }()
    
    var eventImageView: UIImageView = {
        let eventImageView = UIImageView();
        eventImageView.translatesAutoresizingMaskIntoConstraints = false;
        eventImageView.backgroundColor = UIColor.orange;
        eventImageView.contentMode = .scaleAspectFill;
        eventImageView.clipsToBounds = true;
        eventImageView.isUserInteractionEnabled = false;
        return eventImageView;
    }()
    
    var titleLabel: NormalUILabel = {
        let titleLabel = NormalUILabel(textColor: .darkText, font: .montserratSemiBold(fontSize: 16), textAlign: .left);
        titleLabel.text = "Title goes here";
        titleLabel.isUserInteractionEnabled = false;
        titleLabel.numberOfLines = 2;
        return titleLabel;
    }()
    
    var descriptionTextView: UITextView = {
        let descriptionTextView = UITextView();
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false;
        descriptionTextView.text = "Hi everybody, as one of the best poker players on the planet, I am hosting a poker tournament within my home. The buy in is $60, and the prize pool is $5,000. We will only host if at least 90 people sign up!"
        descriptionTextView.font = UIFont.montserratRegular(fontSize: 12);
        descriptionTextView.isEditable = false;
        descriptionTextView.isScrollEnabled = false;
        descriptionTextView.textContainer.lineBreakMode = .byTruncatingTail
        descriptionTextView.isUserInteractionEnabled = false;
        return descriptionTextView;
    }()
    
    var border: UIView = {
        let border = UIView();
        border.translatesAutoresizingMaskIntoConstraints = false;
        border.backgroundColor = UIColor.lightGray;
        return border;
    }()
    
    lazy var eventsCellInfo: EventsAroundYouCellInfoView = {
        let eventsCellInfo = EventsAroundYouCellInfoView(frame: self.frame);
        return eventsCellInfo;
    }()
    
    var cellEvent: Event?{
        didSet{
            self.setTitle(title: cellEvent!.eventTitle!);
            self.setDescription(description: cellEvent!.eventDescription!);
            self.setEventImage();
            self.setPosterImage();
            self.setPosterName(name: cellEvent!.posterName!);
            self.setBottomBarData();
        }
    }
    
    var delegate: EventsAroundYouImageCellDelegate?;
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = UIColor.white;
        setupPosterImageView();
        setupPosterNameLabel();
//        setupCategoryLabel();
        setupTitleLabel();
        setupEventImageView();
        setupDescriptionTextView();
//        setupBorder();
        setupEventsCellInfo()
        setPosterImage()
        setEventImage();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setupPosterImageView(){
        self.addSubview(posterImageView);
        posterImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true;
        posterImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true;
        posterImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true;
        posterImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true;
        posterImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.handleProfileImagePressed)));
    }
    
    fileprivate func setupPosterNameLabel(){
        self.addSubview(posterNameLabel);
        posterNameLabel.leftAnchor.constraint(equalTo: self.posterImageView.rightAnchor, constant: 5).isActive = true;
        posterNameLabel.centerYAnchor.constraint(equalTo: self.posterImageView.centerYAnchor).isActive = true;
        posterNameLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true;
        posterNameLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true;
        //        posterNameLabel.backgroundColor = UIColor.red;
    }
    
    fileprivate func setupCategoryLabel(){
        self.addSubview(categoryLabel);
        categoryLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true;
        categoryLabel.centerYAnchor.constraint(equalTo: self.posterImageView.centerYAnchor).isActive = true;
        categoryLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true;
        categoryLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true;
        //        categoryLabel.backgroundColor = UIColor.blue;
    }
    
    fileprivate func setupTitleLabel(){
        self.addSubview(titleLabel);
        titleLabel.anchor(left: self.leftAnchor, right: self.rightAnchor, top: self.posterImageView.bottomAnchor, bottom: nil, constantLeft: 10, constantRight: -10, constantTop: 5, constantBottom: 0, width: 0, height: 40);
    }
    
    fileprivate func setupEventImageView(){
        self.addSubview(eventImageView);
        eventImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true;
        eventImageView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 5).isActive = true;
        eventImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -40).isActive = true;
        eventImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true;
    }
    
    fileprivate func setupDescriptionTextView(){
        self.addSubview(descriptionTextView);
        descriptionTextView.leftAnchor.constraint(equalTo: self.eventImageView.rightAnchor, constant: 5).isActive = true;
        descriptionTextView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true;
        descriptionTextView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 5).isActive = true;
        descriptionTextView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -40).isActive = true;
        //        descriptionTextView.backgroundColor = UIColor.yellow;
    }
    
    fileprivate func setupBorder(){
        self.addSubview(border);
        border.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true;
        border.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true;
        border.topAnchor.constraint(equalTo: self.descriptionTextView.bottomAnchor, constant: 10).isActive = true;
        border.heightAnchor.constraint(equalToConstant: 0.4).isActive = true;
    }
    
    fileprivate func setupEventsCellInfo(){
        self.addSubview(eventsCellInfo);
        eventsCellInfo.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true;
        eventsCellInfo.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true;
//        eventsCellInfo.topAnchor.constraint(equalTo: self.border.bottomAnchor).isActive = true;
        eventsCellInfo.heightAnchor.constraint(equalToConstant: 30).isActive = true;
        eventsCellInfo.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true;
    }
    
    func setPosterImage(){
//        let posterImage = UIImage(named: "dneg");
        if(cellEvent?.posterImage == nil){
            self.posterImageView.image = #imageLiteral(resourceName: "noImageIcon");
        }else{
            self.posterImageView.image = cellEvent!.posterImage!
        }
    }
    
    func setTitle(title:String){
        self.titleLabel.text = title;
    }
    
    func setDescription(description: String){
        self.descriptionTextView.text = description;
    }
    
    func setEventImage(){
        if(cellEvent == nil){
            let image = #imageLiteral(resourceName: "poker");
            self.eventImageView.image = image;
            return;
        }
        
        if(cellEvent!.eventImages!.count > 0){
            self.eventImageView.image = cellEvent!.eventImages![0];
        }
    }
    
    func setPosterName(name: String){
        self.posterNameLabel.text = name;
    }
    
    func setBottomBarData(){
        if(cellEvent != nil){
            self.eventsCellInfo.setPrice(price: cellEvent!.price!);
            self.eventsCellInfo.setDate(date: cellEvent!.startDate!);
            self.eventsCellInfo.setNumberOfPeople(currentPeople: cellEvent!.currentPeople!, people: cellEvent!.people!);
        }
        
    }
    
}

extension EventsAroundYouImageCell{
    @objc func handleProfileImagePressed(){
        self.delegate?.handlePosterImageViewPressed();
    }
}
