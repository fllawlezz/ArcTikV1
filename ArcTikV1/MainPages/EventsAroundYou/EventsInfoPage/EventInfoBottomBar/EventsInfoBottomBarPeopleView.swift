//
//  EventsInfoBottomBarPeopleView.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/15/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

class EventsInfoBottomBarPeopleView: UIView{
    
    var peopleImageView: UIImageView = {
        let peopleImageView = UIImageView(image: #imageLiteral(resourceName: "people"));
        peopleImageView.translatesAutoresizingMaskIntoConstraints = false;
        peopleImageView.contentMode = .scaleAspectFill;
        return peopleImageView;
    }()
    
    var peopleLabel: NormalUILabel = {
        let peopleLabel = NormalUILabel(textColor: .darkText, font: .montserratMedium(fontSize: 14), textAlign: .center);
        peopleLabel.text = "40/100";
        return peopleLabel;
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = UIColor.white;
        self.translatesAutoresizingMaskIntoConstraints = false;
        setupPeopleImageView();
        setupPeopleLabel();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setupPeopleImageView(){
        self.addSubview(peopleImageView);
        peopleImageView.anchor(left: nil, right: nil, top: self.topAnchor, bottom: nil, constantLeft: 0, constantRight: 0, constantTop: 0, constantBottom: 0, width: 30, height: 30);
        peopleImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true;
        
    }
    
    fileprivate func setupPeopleLabel(){
        self.addSubview(peopleLabel);
        peopleLabel.anchor(left: self.leftAnchor, right: self.rightAnchor, top: self.peopleImageView.bottomAnchor, bottom: self.bottomAnchor, constantLeft: 0, constantRight: 0, constantTop: 0, constantBottom: 0, width: 0, height: 0);
    }
    
    func setText(numberOfPeople: String){
        self.peopleLabel.text = numberOfPeople;
    }
}
