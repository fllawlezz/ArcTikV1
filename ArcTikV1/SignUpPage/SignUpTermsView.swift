//
//  SignUpTerms.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/2/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

class SignUpTermsView: UITextView, UITextViewDelegate{
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer);
        setup();
        setupSignUpTextView();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setup(){
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.textAlignment = .center;
        self.isEditable = false;
        self.isScrollEnabled = false;
        self.textColor = UIColor.white;
        self.backgroundColor = UIColor.clear;
        self.font = UIFont.systemFont(ofSize: 14);
        self.text = "Hello World this is your manager speaking"
    }
    
    fileprivate func setupSignUpTextView(){
        self.delegate = self;
        
        let originalText = "By signing, you agree to our Terms and Privacy Policy";
        let attributedText = NSMutableAttributedString(string: originalText);
        let centerAlignment = NSMutableParagraphStyle();
        centerAlignment.alignment = .center;
        let linkRange = attributedText.mutableString.range(of: "Terms");
        let privacyLinkRange = attributedText.mutableString.range(of: "Privacy Policy");
        attributedText.addAttribute(.link, value: "https://google.com", range: linkRange);
        attributedText.addAttribute(.link, value: "https://yahoo.com", range: privacyLinkRange);
        attributedText.addAttribute(.paragraphStyle, value: centerAlignment, range: NSMakeRange(0, attributedText.length));
        attributedText.addAttribute(.foregroundColor, value: UIColor.white, range: NSMakeRange(0, attributedText.length));
        attributedText.addAttribute(.font, value: UIFont.montserratRegular(fontSize: 12), range: NSMakeRange(0, attributedText.length));
        
        self.attributedText = attributedText;
        self.linkTextAttributes = [NSAttributedStringKey.underlineStyle.rawValue : NSUnderlineStyle.styleSingle.rawValue];
        
    }
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        //        self.delegate?.handleSignUp();
        UIApplication.shared.open(URL, options: [:], completionHandler: nil);
        return false;
    }
}
