//
//  EventsInfoBottomBarCostView.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/15/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

class EventsInfoBottomBarCostView: UIView{
    
    var costImageView: UIImageView = {
        let costImageView = UIImageView(image: #imageLiteral(resourceName: "cash"));
        costImageView.translatesAutoresizingMaskIntoConstraints = false;
        costImageView.contentMode = .scaleAspectFill;
        return costImageView;
    }()
    
    var costLabel: NormalUILabel = {
        let costLabel = NormalUILabel(textColor: .darkText, font: .montserratMedium(fontSize: 14), textAlign: .center);
        costLabel.text = "$60";
        return costLabel;
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = UIColor.white;
        self.translatesAutoresizingMaskIntoConstraints = false;
        setupCostImageView();
        setupCostLabel();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setupCostImageView(){
        self.addSubview(costImageView);
        costImageView.anchor(left: nil, right: nil, top: self.topAnchor, bottom: nil, constantLeft: 0, constantRight: 0, constantTop: 0, constantBottom: 0, width: 30, height: 30);
        costImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true;
        
    }
    
    fileprivate func setupCostLabel(){
        self.addSubview(costLabel);
        costLabel.anchor(left: self.leftAnchor, right: self.rightAnchor, top: self.costImageView.bottomAnchor, bottom: self.bottomAnchor, constantLeft: 0, constantRight: 0, constantTop: 0, constantBottom: 0, width: 0, height: 0);
    }
    
    func setText(numberOfPeople: String){
        self.costLabel.text = numberOfPeople;
    }
    
}
