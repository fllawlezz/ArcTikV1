//
//  DistanceCollectionViewCell.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/6/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

let resetDistanceCell = "ResetDistanceCell";

class DistanceCollectionViewCell: UICollectionViewCell{
    
    var distanceLabel: NormalUILabel = {
        let distanceLabel = NormalUILabel(textColor: .darkText, font: .montserratSemiBold(fontSize: 14), textAlign: .center);
        distanceLabel.text = "1 mi";
        distanceLabel.isUserInteractionEnabled = true;
        return distanceLabel;
    }()
    
    var distance: Int?;
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = UIColor.white;
        self.layer.borderColor = UIColor.black.cgColor;
        self.layer.borderWidth = 1;
        addObservers();
        setupDistanceLabel();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func addObservers(){
        let resetName = Notification.Name(rawValue: resetDistanceCell);
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleResetDistanceCell), name: resetName, object: nil);
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self);
    }
    
    fileprivate func setupDistanceLabel(){
        self.addSubview(distanceLabel);
        distanceLabel.anchor(left: self.leftAnchor, right: self.rightAnchor, top: self.topAnchor, bottom: self.bottomAnchor);
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleCellPressed));
        distanceLabel.addGestureRecognizer(tapGesture);
    }
    
    func setDistance(distance: Int){
        self.distance = distance;
        self.distanceLabel.text = "\(distance) mi";
    }
}

extension DistanceCollectionViewCell{
    @objc func handleCellPressed(){
        let name = Notification.Name(resetDistanceCell);
        NotificationCenter.default.post(name: name, object: nil);
        
        self.backgroundColor = UIColor.appBlue;
        self.distanceLabel.textColor = UIColor.white;
    }
    
    @objc func handleResetDistanceCell(){
        self.backgroundColor = UIColor.white;
        self.distanceLabel.textColor = UIColor.darkText;
    }
}
