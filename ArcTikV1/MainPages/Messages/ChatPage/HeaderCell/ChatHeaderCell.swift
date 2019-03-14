//
//  ChatHeaderCell.swift
//  ArcTikV1
//
//  Created by Brandon In on 2/7/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

class ChatHeaderCell: UITableViewHeaderFooterView{
    
    var dateTitle: NormalUILabel = {
        let dateTitle = NormalUILabel(textColor: .darkText, font: .montserratMedium(fontSize: 12), textAlign: .center);
        dateTitle.text = "1/1/2018";
        dateTitle.textColor = UIColor.white;
        return dateTitle;
    }()
    
    var backgroundBubbleView = UIView();
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier);
        setupBackground();
        setupDateTitle();
        setupBackgroundBubbleView();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setupDateTitle(){
        self.addSubview(dateTitle);
//        dateTitle.anchor(left: self.leftAnchor, right: self.rightAnchor, top: self.topAnchor, bottom: self.bottomAnchor);
        dateTitle.anchorCenter(centerXanchor: self.centerXAnchor, centerYAnchor: self.centerYAnchor, topAnchor: nil, bottomAnchor: nil, width: 100, height: 25, centerXAnchorConstant: 0, centerYAnchorConstant: 0, topAnchorConstant: 0, bottomAnchorConstant: 0);
    }
    
    fileprivate func setupBackgroundBubbleView(){
        backgroundBubbleView.backgroundColor = UIColor.appBlue;
        backgroundBubbleView.layer.cornerRadius = 12.5;
        self.addSubview(backgroundBubbleView);
        backgroundBubbleView.anchor(left: self.dateTitle.leftAnchor, right: self.dateTitle.rightAnchor, top: self.dateTitle.topAnchor, bottom: self.dateTitle.bottomAnchor, constantLeft: -0, constantRight: 0, constantTop: -0, constantBottom: 0, width: 0, height: 0);
        self.bringSubview(toFront: dateTitle);
    }
    
    fileprivate func setupBackground(){
        let backgroundView = UIView();
        backgroundView.backgroundColor = UIColor.clear;
        self.backgroundView = backgroundView;
    }
    
    func setDateTitle(title: String){
        self.dateTitle.text = title;
    }
}
