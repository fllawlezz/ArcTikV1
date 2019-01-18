//
//  RequirementsPageListCell.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/18/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

protocol RequirementsPageListCellDelegate{
    func deleteCellAt(indexPath: IndexPath);
}

class RequirementsPageListCell: UITableViewCell{
    
    var titleLabel = UILabel();
    var border = BorderView();
    
    var indexPath: IndexPath?;
    var delegate: RequirementsPageListCellDelegate?;
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        self.backgroundColor = UIColor.white;
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false;
        titleLabel.numberOfLines = 0;
        titleLabel.font = UIFont.montserratMedium(fontSize: 14);
        
        setupTitleLabel();
        setupBorder();
        
        self.isUserInteractionEnabled = true;
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(holdGesture));
        self.addGestureRecognizer(gesture);
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setupTitleLabel(){
        self.addSubview(titleLabel);
        titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 25).isActive = true;
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true;
        titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20).isActive = true;
        titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -25).isActive = true;
    }
    
    fileprivate func setupBorder(){
        self.addSubview(border);
        border.anchor(left: self.leftAnchor, right: self.rightAnchor, top: nil, bottom: self.bottomAnchor, constantLeft: 0, constantRight: 0, constantTop: 0, constantBottom: 0, width: 0, height: 0.4);
    }
//
    func setRequirementText(requirement: String){
        self.titleLabel.text = requirement;
    }
    
    @objc func holdGesture(g: UIGestureRecognizer){
        if let indexPath = self.indexPath{
            if(g.state == .began){
                delegate?.deleteCellAt(indexPath: indexPath);
            }
        }

    }
    
}
