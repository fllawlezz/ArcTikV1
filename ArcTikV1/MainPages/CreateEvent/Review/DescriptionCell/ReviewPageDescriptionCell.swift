//
//  ReviewPageDescriptionCell.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/11/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

class ReviewPageDescriptionCell: UICollectionViewCell{
    
    var descriptionTextView: UITextView = {
        let descriptionTextView = UITextView();
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false;
        descriptionTextView.font = UIFont.systemFont(ofSize: 14);
        descriptionTextView.isSelectable = false;
        descriptionTextView.isEditable = false;
        descriptionTextView.backgroundColor = UIColor.white;
        descriptionTextView.layer.cornerRadius = 4;
        descriptionTextView.layer.borderColor = UIColor.darkText.cgColor;
        descriptionTextView.layer.borderWidth = 1;
        return descriptionTextView;
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        setupDescriptionTextView();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setupDescriptionTextView(){
        self.addSubview(descriptionTextView);
        descriptionTextView.anchor(left: self.leftAnchor, right: self.rightAnchor, top: self.topAnchor, bottom: self.bottomAnchor, constantLeft: 25, constantRight: -25, constantTop: 10, constantBottom: -10, width: 0, height: 0);
    }
    
    func setDescription(description: String){
        self.descriptionTextView.text = description;
    }
}
