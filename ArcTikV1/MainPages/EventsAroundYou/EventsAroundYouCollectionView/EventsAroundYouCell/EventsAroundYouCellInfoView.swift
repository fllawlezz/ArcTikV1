//
//  EventsAroundYouCellInfo.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/3/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

class EventsAroundYouCellInfoView: UIView {
   
    var timeStampLabel: NormalUILabel = {
        let timeStampLabel = NormalUILabel(textColor: .darkText, font: .montserratRegular(fontSize: 10), textAlign: .center);
        timeStampLabel.text = "30 minutes ago"
        return timeStampLabel;
    }()
    
    var numberOfPeopleLabel: NormalUILabel = {
        let numberOfPeopleLabel = NormalUILabel(textColor: .darkText, font: .montserratRegular(fontSize: 10), textAlign: .center);
        numberOfPeopleLabel.text = "People: 40/100"
        return numberOfPeopleLabel;
    }()
    
    var priceLabel: NormalUILabel = {
        let priceLabel = NormalUILabel(textColor: .darkText, font: .montserratRegular(fontSize: 10), textAlign: .center);
        priceLabel.text = "$60"
        return priceLabel;
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = UIColor.white;
        self.translatesAutoresizingMaskIntoConstraints = false;
        setupTimeStampLabel()
        setupPeopleLabel();
        setupPriceLabel();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setupTimeStampLabel(){
        self.addSubview(timeStampLabel);
        timeStampLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true;
        timeStampLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true;
        timeStampLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true;
        timeStampLabel.widthAnchor.constraint(equalToConstant: self.frame.width/3).isActive = true;
        
    }
    
    fileprivate func setupPeopleLabel(){
        self.addSubview(numberOfPeopleLabel);
        numberOfPeopleLabel.leftAnchor.constraint(equalTo: self.timeStampLabel.rightAnchor).isActive = true;
        numberOfPeopleLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true;
        numberOfPeopleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true;
        numberOfPeopleLabel.widthAnchor.constraint(equalToConstant: self.frame.width/3).isActive = true;
    }
    
    fileprivate func setupPriceLabel(){
        self.addSubview(priceLabel);
        priceLabel.leftAnchor.constraint(equalTo: self.numberOfPeopleLabel.rightAnchor).isActive = true;
        priceLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true;
        priceLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true;
        priceLabel.widthAnchor.constraint(equalToConstant: self.frame.width/3).isActive = true;
//        priceLabel.backgroundColor = UIColor.red;
    }
    
}
