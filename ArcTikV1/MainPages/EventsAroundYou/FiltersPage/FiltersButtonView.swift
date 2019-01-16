//
//  FiltersButtonView.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/15/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

class FiltersButtonView: UIView{
    
    var searchButton: NormalUIButton = {
        let searchButton = NormalUIButton(type: .system);
        searchButton.setButtonProperties(backgroundColor: .appBlue, title: "Search", font: .montserratSemiBold(fontSize: 14), fontColor: .white);
        return searchButton;
    }()
    
    var border = BorderView();
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.backgroundColor = UIColor.white;
        self.layer.shadowColor = UIColor.darkText.cgColor;
        self.layer.shadowOffset = CGSize(width: 2, height: -0.5);
        self.layer.shadowRadius = 1;
        self.layer.shadowOpacity = 0.2;
        setupSearchButton();
//        setupBorder();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setupSearchButton(){
        self.addSubview(searchButton);
        searchButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true;
        searchButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true;
        searchButton.widthAnchor.constraint(equalToConstant: 225).isActive = true;
        searchButton.heightAnchor.constraint(equalToConstant: 50).isActive = true;
    }
    
    fileprivate func setupBorder(){
        self.addSubview(border);
        border.anchor(left: self.leftAnchor, right: self.rightAnchor, top: self.topAnchor, bottom: nil, constantLeft: 0, constantRight: 0, constantTop: 0, constantBottom: 0, width: 0, height: 0.4);
    }
    
}
