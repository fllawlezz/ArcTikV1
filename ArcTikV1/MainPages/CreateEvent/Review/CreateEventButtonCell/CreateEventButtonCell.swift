//
//  File.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/11/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

class CreateEventButtonCell: UICollectionViewCell{
    
    var createEventButton: NormalUIButton = {
        let createEventButton = NormalUIButton(type: .system);
        createEventButton.setButtonProperties(backgroundColor: .appBlue, title: "Create Event", font: .montserratSemiBold(fontSize: 14), fontColor: .white);
        return createEventButton;
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = UIColor.white;
        setupCreateEventButton();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setupCreateEventButton(){
        self.addSubview(createEventButton);
        self.createEventButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 50).isActive = true;
        self.createEventButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -50).isActive = true;
//        createEventButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true;
        createEventButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true;
//        createEventButton.widthAnchor.constraint(equalToConstant: 200).isActive = true;
        createEventButton.heightAnchor.constraint(equalToConstant: 50).isActive = true;
    }
    
}
