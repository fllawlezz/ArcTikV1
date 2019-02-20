//
//  SendMessageView.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/8/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

protocol SendMessageViewDelegate{
    func scrollToBottom();
    func sendMessage(message: String);
}

let resignSendMessageView = "ResignSendMessageView";

class SendMessageView: UIView, UITextViewDelegate, MessageTextViewDelegate{
    
    let messageField: MessageTextView = {
        let messageField = MessageTextView();
        messageField.isScrollEnabled = false;
        messageField.font = UIFont.systemFont(ofSize: 16)
        return messageField;
    }()
    
    let sendButton: UIButton = {
        let sendButton = NormalUIButton(type: .system);
        sendButton.setBackgroundImage(#imageLiteral(resourceName: "sendBlack"), for: .normal);
        return sendButton;
    }()
    
    let imageSelectButton: UIButton = {
        let imageSelectButton = NormalUIButton(type: .system);
        imageSelectButton.setBackgroundImage(#imageLiteral(resourceName: "image"), for: .normal);
        return imageSelectButton;
    }()
    
    let lineSeparatorView: UIView = {
        let lineSeparatorView = UIView();
        lineSeparatorView.translatesAutoresizingMaskIntoConstraints = false;
        lineSeparatorView.backgroundColor = UIColor.gray;
        return lineSeparatorView;
    }()
    
    var imageSelectorLeftConstraint: NSLayoutConstraint?;
    var textViewLeftConstraint: NSLayoutConstraint?;
    
    var sendMessageViewDelegate:SendMessageViewDelegate?;
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = UIColor.white;
        self.autoresizingMask = .flexibleHeight;
        setupImageSelectButton();
        setupSendMessageView();
        setupSendButton();
        setupSeperatorLine();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self);
    }
    
    func addObservers(){
        let name = Notification.Name(rawValue: resignSendMessageView);
        NotificationCenter.default.addObserver(self, selector: #selector(self.resignMesssageView), name: name, object: nil);
    }
    override var intrinsicContentSize: CGSize{
        return .zero;
    }
    
    fileprivate func setupImageSelectButton(){
        self.addSubview(imageSelectButton);
        imageSelectorLeftConstraint = imageSelectButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10);
        imageSelectorLeftConstraint?.isActive = true;
        imageSelectButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 15).isActive = true;
        imageSelectButton.heightAnchor.constraint(equalToConstant: 30).isActive = true;
        imageSelectButton.widthAnchor.constraint(equalToConstant: 30).isActive = true;
    }
    
    fileprivate func setupSendMessageView(){
        
        self.addSubview(messageField);
        
        if #available(iOS 11.0, *) {
            textViewLeftConstraint = messageField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 55);
            messageField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -60).isActive = true;
            messageField.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true;
            messageField.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -5).isActive = true
        } else {
            //             Fallback on earlier versions
            textViewLeftConstraint = messageField.leftAnchor.constraint(equalTo: self.imageSelectButton.rightAnchor, constant: 10)
            messageField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -60).isActive = true;
            messageField.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true;
            messageField.bottomAnchor.constraint(equalTo :layoutMarginsGuide.bottomAnchor, constant: -5).isActive = true;
        };
        textViewLeftConstraint?.isActive = true;
        messageField.delegate = self;
        messageField.messageTextViewDelegate = self;
    }
    
    fileprivate func setupSendButton(){
        //        sendButton.backgroundColor = UIColor.blue;
        self.addSubview(sendButton);
        sendButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true;
        sendButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true;
        sendButton.widthAnchor.constraint(equalToConstant: 40).isActive = true;
        sendButton.heightAnchor.constraint(equalToConstant: 40).isActive = true;
        sendButton.addTarget(self, action: #selector(self.sendMessage), for: .touchUpInside);
        
    }
    
    fileprivate func setupSeperatorLine(){
        self.addSubview(lineSeparatorView);
        lineSeparatorView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true;
        lineSeparatorView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true;
        lineSeparatorView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true;
        lineSeparatorView.heightAnchor.constraint(equalToConstant: 0.3).isActive = true;
    }
    
    func textViewDidChange(_ textView: UITextView) {
        //        self.invalidateIntrinsicContentSize()
    }
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        //animate the imageSelector to the left
        UIView.animate(withDuration: 0.3) {
            self.imageSelectorLeftConstraint?.constant = -100;
            self.textViewLeftConstraint?.constant = 10;
            self.layoutIfNeeded();
        }
        
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        UIView.animate(withDuration: 0.3) {
            self.imageSelectorLeftConstraint?.constant = 10;
            self.textViewLeftConstraint?.constant = 55;
            self.layoutIfNeeded();
        }
    }
}

extension SendMessageView{
    @objc func sendMessage(){
        if(messageField.text.count > 0){
            self.sendMessageViewDelegate?.sendMessage(message: self.messageField.text);
            self.messageField.text = "";
        }
    }
    
    func scrollDown() {
        self.sendMessageViewDelegate?.scrollToBottom();
    }
    
    @objc func resignMesssageView(){
        self.messageField.resignFirstResponder();
    }
}
