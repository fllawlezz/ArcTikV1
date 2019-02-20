//
//  MessagesEmptyCell.swift
//  ArcTikV1
//
//  Created by Brandon In on 2/14/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

class MessagesEmptyCell: UICollectionViewCell{
    
    lazy var emptyCellLabel: NormalUILabel = {
        let emptyCellLabel = NormalUILabel(textColor: .darkText, font: .montserratMedium(fontSize: 14), textAlign: .center);
        emptyCellLabel.text = "You have no messages right now... send a message to one of your friends! Press the button in the top right";
        emptyCellLabel.numberOfLines = 2;
        emptyCellLabel.isUserInteractionEnabled = false;
        return emptyCellLabel;
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        self.backgroundColor = UIColor.white;
        
        self.addSubview(emptyCellLabel);
//        emptyCellLabel.anchor(left: self.leftAnchor, right: self.rightAnchor, top: self.topAnchor, bottom: self.bottomAnchor);
        emptyCellLabel.anchor(left: self.leftAnchor, right: self.rightAnchor, top: self.topAnchor, bottom: self.bottomAnchor, constantLeft: 25, constantRight: -25, constantTop: 0, constantBottom: 0, width: 0, height: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
}
