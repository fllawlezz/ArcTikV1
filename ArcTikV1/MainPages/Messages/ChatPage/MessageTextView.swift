//
//  MessageTextView.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/8/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

protocol MessageTextViewDelegate{
    func scrollDown();
}

class MessageTextView: UITextView{
    
    var messageTextViewDelegate: MessageTextViewDelegate?;
    
    fileprivate let placeHolderLabel: UILabel = {
        let label = UILabel();
        label.text = "Enter Message";
        label.font = UIFont.systemFont(ofSize: 14);
        label.translatesAutoresizingMaskIntoConstraints = false;
        label.textColor = UIColor.lightGray;
        return label;
    }()
    
    func showPlaceHolderLabel(){
        placeHolderLabel.isHidden = false;
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self);
    }
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer);
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.textContainerInset = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15);
        self.scrollIndicatorInsets = UIEdgeInsets(top: 10, left: 15, bottom: 0, right: 15);
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleTextChange), name: .UITextViewTextDidChange, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleTextBeginEditing), name: .UITextViewTextDidBeginEditing, object: nil);
        
        setupTextView();
        
        self.addSubview(placeHolderLabel);
        self.placeHolderLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true;
        self.placeHolderLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true;
        self.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true;
        self.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true;
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setupTextView(){
        self.font = .systemFont(ofSize: 14);
        self.textColor = UIColor.gray;
        self.isEditable = true;
        self.backgroundColor = UIColor.white;
        self.layer.borderWidth = 1;
        self.layer.borderColor = UIColor.lightGray.cgColor;
        self.layer.cornerRadius = 20;
    }
    
    @objc func handleTextChange(){
        self.placeHolderLabel.isHidden = !self.text.isEmpty
        //        print("changed");
    }
    
    @objc func handleTextBeginEditing(){
        self.messageTextViewDelegate?.scrollDown();
    }
}
