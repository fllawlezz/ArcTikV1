//
//  EventsInfoHeader.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/6/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

protocol EventsInfoHeaderDelegate{
    func handleBack();
}

class EventsInfoHeader: UICollectionReusableView{
    
    var eventsImageView: UIImageView = {
        let eventsImageView = UIImageView(image: #imageLiteral(resourceName: "poker"))
        eventsImageView.translatesAutoresizingMaskIntoConstraints = false;
        eventsImageView.contentMode = .scaleAspectFill;
        return eventsImageView;
    }()
    
    var darkView:UIView = {
        let darkView = UIView();
        darkView.translatesAutoresizingMaskIntoConstraints = false;
        darkView.backgroundColor = UIColor.black;
        darkView.alpha = 0.4;
        return darkView;
    }()
    
    var clearButton:NormalUIButton = {
        let clearButton = NormalUIButton(type: .system);
        clearButton.setBackgroundImage(UIImage(named: "clearWhite"), for: .normal);
        clearButton.translatesAutoresizingMaskIntoConstraints = false;
        clearButton.isUserInteractionEnabled =  true;
        return clearButton;
    }()
    
    var delegate: EventsInfoHeaderDelegate?;
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = UIColor.white;
        setupEventsImageView();
        setupDarkView();
        setupClearButton();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setupEventsImageView(){
        self.addSubview(eventsImageView);
        self.eventsImageView.fillSuperView();
//        self.backgroundColor = UIColor.blue;
    }
    
    fileprivate func setupDarkView(){
        self.addSubview(darkView);
        darkView.fillSuperView();
    }
    
    fileprivate func setupClearButton(){
        self.addSubview(clearButton);
        clearButton.anchor(left: self.leftAnchor, right: nil, top: self.topAnchor, bottom: nil, constantLeft: 10, constantRight: 0, constantTop: 10, constantBottom: 0, width: 40, height: 40);
    }
    
}

extension EventsInfoHeader{
    @objc func handleBack(){
        self.delegate?.handleBack();
    }
}
