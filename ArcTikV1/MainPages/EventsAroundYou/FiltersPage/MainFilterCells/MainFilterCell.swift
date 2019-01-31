//
//  MainFilterCell.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/15/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

let distanceFiltersCellUncheck = "MainFiltersCellUncheck";
let priceFiltersCellUnCheck = "MainFiltersPriceCellUnCheck";
let clearAllFiltersCellUnCheck = "MainFiltersClearAll";

class MainFilterCell: UICollectionViewCell{
    
    var titleLabel: NormalUILabel = {
        let titleLabel = NormalUILabel(textColor: .darkText, font: .montserratMedium(fontSize: 14), textAlign: .left);
        titleLabel.text = "Primary Filters";
        return titleLabel;
    }()
    
    var descriptionLabel: NormalUILabel = {
        let descriptionLabel = NormalUILabel(textColor: .darkText, font: .montserratRegular(fontSize: 12), textAlign: .left);
        descriptionLabel.text = "Description text goes here";
        return descriptionLabel;
    }()
    
    var imageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "emptyCheck"));
        imageView.translatesAutoresizingMaskIntoConstraints = false;
        imageView.contentMode = .scaleAspectFill;
        return imageView;
    }()
    
    var checkBoxButton: NormalUIButton = {
        let checkBoxButton = NormalUIButton(type: .system);
        checkBoxButton.translatesAutoresizingMaskIntoConstraints = false;
        checkBoxButton.setBackgroundImage(#imageLiteral(resourceName: "emptyCheck"), for: .normal);
        return checkBoxButton;
    }()
    
    var border = BorderView();
    var buttonChecked = false;
    var bottomPrice: Double?;
    var topPrice: Double?;
    var distance: Int?;
    var section: Int?;
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = UIColor.white;
        setupTitleLabel();
        setupDescriptionLabel();
        setupCheckBoxButton();
        setupBorder();
        addObservers();

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    deinit{
        NotificationCenter.default.removeObserver(self);
    }
    
    fileprivate func addObservers(){
        let name = Notification.Name(rawValue: distanceFiltersCellUncheck);
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleDistanceBoxUnCheck), name: name, object: nil);
        
        let priceName = Notification.Name(rawValue: priceFiltersCellUnCheck);
        NotificationCenter.default.addObserver(self, selector: #selector(self.handlePriceBoxUnCheck), name: priceName, object: nil);
        
        let clearAllName = Notification.Name(rawValue: clearAllFiltersCellUnCheck);
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleClearAll), name: clearAllName, object: nil);
    }
    
    fileprivate func setupTitleLabel(){
        self.addSubview(titleLabel);
        titleLabel.anchor(left: self.leftAnchor, right: self.rightAnchor, top: self.topAnchor, bottom: nil, constantLeft: 25, constantRight: -25, constantTop: 10, constantBottom: 0, width: 0, height: 25);
    }
    
    fileprivate func setupDescriptionLabel(){
        self.addSubview(descriptionLabel);
        descriptionLabel.anchor(left: self.leftAnchor, right: self.rightAnchor, top: self.titleLabel.bottomAnchor, bottom: nil, constantLeft: 25, constantRight: -25, constantTop: 5, constantBottom: 0, width: 0, height: 25);
    }
    
    fileprivate func setupCheckBoxButton(){
        self.addSubview(checkBoxButton);
        checkBoxButton.anchor(left: nil, right: self.rightAnchor, top: nil, bottom: nil, constantLeft: 0, constantRight: -25, constantTop: 0, constantBottom: 0, width: 25, height: 25);
        checkBoxButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true;
        
        checkBoxButton.addTarget(self, action: #selector(self.handleCheckBoxPressed), for: .touchUpInside);
    }
    
    fileprivate func setupBorder(){
        self.addSubview(border);
        border.anchor(left: self.leftAnchor, right: self.rightAnchor, top: nil, bottom: self.bottomAnchor, constantLeft: 25, constantRight: 0, constantTop: 0, constantBottom: 0, width: 0, height: 0.4);
    }
    
    func setTitle(text: String){
        self.titleLabel.text = text;
    }
    
    func setDescription(text: String){
        self.descriptionLabel.text = text;
    }
}

extension MainFilterCell{
    @objc func handleCheckBoxPressed(){
        if(!buttonChecked){
            if(section == 0){
                let name = Notification.Name(rawValue: distanceFiltersCellUncheck);
                NotificationCenter.default.post(name: name, object: nil);
                
                if let distance = self.distance{
                    let userInfo = ["distance":distance];
                    
                    let setDistanceName = Notification.Name(rawValue: setDistanceFiltersPage);
                    NotificationCenter.default.post(name: setDistanceName, object: nil, userInfo: userInfo);
                }
                
            }else{
                let name = Notification.Name(rawValue: priceFiltersCellUnCheck);
                NotificationCenter.default.post(name: name, object: nil);
                
                if let bottomPrice = self.bottomPrice{
                    let userInfo = ["bottomPrice":bottomPrice, "topPrice":self.topPrice!];
                    
                    let setPriceName = Notification.Name(rawValue: setPriceFiltersPage);
                    NotificationCenter.default.post(name: setPriceName, object: nil, userInfo: userInfo);
                }
            }
            
            //unchecks all first
            
            self.buttonChecked = true;
            self.checkBoxButton.setBackgroundImage(#imageLiteral(resourceName: "filledCheck"), for: .normal);
        }else{
            if(section == 0){
                    
                let resetDistanceName = Notification.Name(rawValue: resetDistanceFiltersPage);
                NotificationCenter.default.post(name: resetDistanceName, object: nil);
                
            }else{
                let resetPricename = Notification.Name(rawValue: resetPriceFiltersPage);
                NotificationCenter.default.post(name: resetPricename, object: nil);

            }
            
            self.buttonChecked = false;
            self.checkBoxButton.setBackgroundImage(#imageLiteral(resourceName: "emptyCheck"), for: .normal);
        }
    }
    
    @objc func handleDistanceBoxUnCheck(){
        if(self.section == 0){
            self.buttonChecked = false;
            self.checkBoxButton.setBackgroundImage(#imageLiteral(resourceName: "emptyCheck"), for: .normal);
        }
    }
    
    @objc func handlePriceBoxUnCheck(){
        if(self.section == 1){
            self.buttonChecked = false;
            self.checkBoxButton.setBackgroundImage(#imageLiteral(resourceName: "emptyCheck"), for: .normal);
        }
    }
    
    @objc func handleClearAll(){
        self.buttonChecked = false;
        self.checkBoxButton.setBackgroundImage(#imageLiteral(resourceName: "emptyCheck"), for: .normal);
    }
}
