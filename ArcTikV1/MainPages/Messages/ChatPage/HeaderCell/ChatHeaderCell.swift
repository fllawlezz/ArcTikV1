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
        return dateTitle;
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier);
        setupBackground();
        setupDateTitle();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setupDateTitle(){
        self.addSubview(dateTitle);
        dateTitle.anchor(left: self.leftAnchor, right: self.rightAnchor, top: self.topAnchor, bottom: self.bottomAnchor);
    }
    
    fileprivate func setupBackground(){
        let backgroundView = UIView();
        backgroundView.backgroundColor = UIColor.white;
        self.backgroundView = backgroundView;
    }
    
    func setDateTitle(title: String){
        self.dateTitle.text = title;
    }
}
