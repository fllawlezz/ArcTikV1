//
//  AppliedHeader.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/3/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

class AppliedHeader: UICollectionReusableView{
    
    var titleLabel: NormalUILabel = {
        let titleLabel = NormalUILabel(textColor: .darkText, font: .montserratSemiBold(fontSize: 18), textAlign: .left);
        titleLabel.text = "Accepted";
        return titleLabel;
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = UIColor.veryLightGray;
        setupTitleLabel();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setupTitleLabel(){
        self.addSubview(titleLabel);
        titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true;
        titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true;
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true;
        titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true;
    }
    
    func setTitleLabel(title: String){
        self.titleLabel.text = title;
    }
    
}
