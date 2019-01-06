//
//  PriceCollectionViewCell.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/6/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

let pressedPriceCell = "PressedPriceCell";
let resetPriceCell = "ResetPriceCell";

class PriceCollectionViewCell: UICollectionViewCell{
    
    var titleLabel: NormalUILabel = {
        let titleLabel = NormalUILabel(textColor: .darkText, font: .montserratSemiBold(fontSize: 14), textAlign: .center);
        titleLabel.text = "$";
        titleLabel.layer.borderColor = UIColor.black.cgColor;
        titleLabel.layer.borderWidth = 2;
        titleLabel.isUserInteractionEnabled = true;
        return titleLabel;
    }()
    
    var price: Int?;
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = UIColor.white;
        addObservers();
        setupTitleLabel();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func addObservers(){
//        let pressName = Notification.Name(rawValue: pressedPriceCell);
        let resetName = Notification.Name(rawValue: resetPriceCell);
        
//        NotificationCenter.default.addObserver(self, selector: #selector(self.handlePricePressed), name: pressName, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleResetCell), name: resetName, object: nil);
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self);
    }
    
    fileprivate func setupTitleLabel(){
        self.addSubview(titleLabel);
        titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true;
        titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true;
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true;
        titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true;
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handlePricePressed));
        titleLabel.addGestureRecognizer(tapGesture);
    }
    
    func setTitle(title: String, price: Int){
        self.titleLabel.text = title;
        self.price = price;
    }
}

extension PriceCollectionViewCell{
    @objc func handlePricePressed(){
        let name = Notification.Name(rawValue: resetPriceCell);
        NotificationCenter.default.post(name: name, object: nil);
        
        self.backgroundColor = UIColor.appBlue;
        self.titleLabel.textColor = UIColor.white;
        
    }
    
    @objc func handleResetCell(){
        self.backgroundColor = UIColor.white;
        self.titleLabel.textColor = UIColor.darkText;
    }
}
