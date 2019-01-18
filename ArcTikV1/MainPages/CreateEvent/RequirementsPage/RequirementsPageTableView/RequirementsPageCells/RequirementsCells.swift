//
//  RequirementsPageList.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/17/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

let requirementsPageMaximumReach = "RequirementPageMaximumReached";

class RequirementsPageTitleHeader: UITableViewHeaderFooterView{
    
    var titleLabel: NormalUILabel = {
        let titleLabel = NormalUILabel(textColor: .darkText, font: .montserratMedium(fontSize: 18), textAlign: .left);
        titleLabel.text = "Text goes here";
        return titleLabel;
    }()
    
    var border = BorderView();
    
    var backgroundViewWhite = UIView();
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier);
//        self.backgroundColor = UIColor.white;
        backgroundView?.backgroundColor = UIColor.white;
        self.backgroundView = backgroundViewWhite;
        titleLabel.numberOfLines = 2;
        self.setupTitleLabel();
        self.setupBorder();
        addObservers();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self);
    }
    
    fileprivate func addObservers(){
        let name = Notification.Name(rawValue: requirementsPageMaximumReach);
        NotificationCenter.default.addObserver(self, selector: #selector(titleLabelToRed), name: name, object: nil);
    }
    
    fileprivate func setupTitleLabel(){
        self.addSubview(titleLabel);
        titleLabel.anchor(left: self.leftAnchor, right: self.rightAnchor, top: nil, bottom: nil, constantLeft: 25, constantRight: -25, constantTop: 0, constantBottom: 0, width: 0, height: 60);
        titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true;
    }
    
    fileprivate func setupBorder(){
        self.addSubview(border);
        border.anchor(left: self.leftAnchor, right: self.rightAnchor, top: nil, bottom: self.bottomAnchor, constantLeft: 0, constantRight: 0, constantTop: 0, constantBottom: 0, width: 0, height: 0.4);
    }
    
    func setTitleLabel(title: String){
        self.titleLabel.text = title;
    }
    
    @objc func titleLabelToRed(){
        self.titleLabel.textColor = UIColor.red;
    }
}

class RequirementsEmptyCell: UITableViewCell{
    
    var titleLabel: NormalUILabel = {
        let titleLabel = NormalUILabel(textColor: .darkText, font: .montserratMedium(fontSize: 14), textAlign: .center);
        titleLabel.text = "Text goes here";
        return titleLabel;
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        self.backgroundColor = UIColor.white;
        titleLabel.numberOfLines = 0;
        setupTitleLabel();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setupTitleLabel(){
        self.addSubview(titleLabel);
        titleLabel.anchor(left: self.leftAnchor, right: self.rightAnchor, top: self.topAnchor, bottom: self.bottomAnchor, constantLeft: 25, constantRight: -25, constantTop: 20, constantBottom: -20, width: 0, height: 0);
    }
    
    func setTitleLabel(title: String){
        self.titleLabel.text = title;
    }
}
