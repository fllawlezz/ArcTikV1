//
//  EventsInfoDescriptionCell.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/13/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

protocol EventsInfoDescriptionCellProtocol{
    func seeMoreDescription(indexPath: IndexPath);
    func seeMoreRequirements(indexPath: IndexPath);
}

class EventsInfoDescriptionCell: UICollectionViewCell{
    
    var descriptionTextView: UITextView = {
        let descriptionTextView = UITextView();
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false;
        descriptionTextView.font = UIFont.montserratRegular(fontSize: 14);
        descriptionTextView.isEditable = false;
        descriptionTextView.isSelectable = false;
        descriptionTextView.isScrollEnabled = false;
        descriptionTextView.textContainer.lineBreakMode = .byTruncatingTail;
//        descriptionTextView.backgroundColor = UIColor.blue;
        return descriptionTextView;
    }()
    
    var readMoreButton: NormalUIButton = {
        let readMoreButton = NormalUIButton(type: .system);
        readMoreButton.setButtonProperties(backgroundColor: .white, title: "read more", font: .montserratRegular(fontSize: 12), fontColor: .appBlue);
        return readMoreButton;
    }()
    
    var border = BorderView();
    
    var indexPath: IndexPath?;
    var delegate: EventsInfoDescriptionCellProtocol?;
    var textViewBottomAnchor: NSLayoutConstraint?;
    var isExpanded:Bool?{
        didSet{
            if(isExpanded!){
                self.readMoreButton.isHidden = true;
                textViewBottomAnchor?.constant = -10
            }else{
                self.readMoreButton.isHidden = false;
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = UIColor.white;
//        print(self.frame.height);
        setupTextView();
        setupBorder();
        setupReadMoreButton();
//        if(self.frame.height > 140){
//            self.readMoreButton.isHidden = true;
//        }

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setupTextView(){
        self.addSubview(descriptionTextView);
        descriptionTextView.anchor(left: self.leftAnchor, right: self.rightAnchor, top: self.topAnchor, bottom: nil, constantLeft: 25, constantRight: -25, constantTop: 10, constantBottom: 0, width: 0, height: 0)
        textViewBottomAnchor = descriptionTextView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -30);
        textViewBottomAnchor!.isActive = true;
    }
    
    fileprivate func setupBorder(){
        self.addSubview(border);
        border.anchor(left: self.leftAnchor, right: self.rightAnchor, top: nil, bottom: self.bottomAnchor, constantLeft: 25, constantRight: 0, constantTop: 0, constantBottom: 0, width: 0, height: 0.4);
    }
    
    fileprivate func setupReadMoreButton(){
        self.addSubview(readMoreButton);
        readMoreButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true;
        readMoreButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true;
        readMoreButton.widthAnchor.constraint(equalToConstant: 100).isActive = true;
        readMoreButton.heightAnchor.constraint(equalToConstant: 20).isActive = true;
        
        readMoreButton.addTarget(self, action: #selector(self.handleSeeMore), for: .touchUpInside);
//        if(isExpanded){
////            print("is true expanded");
//            self.readMoreButton.isHidden = true;
//        }else{
////            print("expanded is false");
//            self.readMoreButton.isHidden = false;
//        }
    }
    
    func setupText(description: String){
        self.descriptionTextView.text = description;
    }
    
    func hideReadMoreButton(){
        self.readMoreButton.isHidden = true;
    }
}

extension EventsInfoDescriptionCell{
    @objc func handleSeeMore(){
        if let indexPath = self.indexPath{
            if(indexPath.section == 1){
                delegate?.seeMoreDescription(indexPath: indexPath);
            }else{
                delegate?.seeMoreRequirements(indexPath: indexPath);
            }
        }
        
    }
}
