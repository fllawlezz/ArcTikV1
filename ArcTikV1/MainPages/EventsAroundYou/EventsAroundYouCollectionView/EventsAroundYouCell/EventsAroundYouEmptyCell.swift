//
//  EventsAroundYouEmptyCell.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/31/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

class EventsAroundYouEmptyCell: UICollectionViewCell{
    
    var messageTextView: UITextView = {
        let messageTextView = UITextView();
        messageTextView.translatesAutoresizingMaskIntoConstraints = false;
        messageTextView.font = UIFont.montserratMedium(fontSize: 14);
        messageTextView.isUserInteractionEnabled = false;
        messageTextView.backgroundColor = UIColor.veryLightGray;
        messageTextView.isScrollEnabled = false;
        messageTextView.text = "There aren't any events going on in your area.. You can be the first!! Creating your event is just a couple steps away. Click the plus button in the upper right to get started!";
        return messageTextView;
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = UIColor.veryLightGray;
        setupTextView();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setupTextView(){
        self.addSubview(messageTextView);
//        messageTextView.anchor(left: self.leftAnchor, right: self.rightAnchor, top: self.topAnchor, bottom: self.bottomAnchor);
        messageTextView.anchor(left: self.leftAnchor, right: self.rightAnchor, top: self.topAnchor, bottom: self.bottomAnchor, constantLeft: 25, constantRight: -25, constantTop: 0, constantBottom: 0, width: 0, height: 0);
    }
}
