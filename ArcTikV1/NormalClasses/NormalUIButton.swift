//
//  NormalUIButton.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/2/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//


//testing for the git push

import UIKit

class NormalUIButton: UIButton{
    
    var selfBackgroundColor: UIColor!
    var titleString: String!
    var selfFont: UIFont!;
    var fontColor: UIColor!;
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        setup();
    }
    override var buttonType: UIButtonType{
        return .system;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    func setButtonProperties(backgroundColor: UIColor, title: String, font: UIFont, fontColor: UIColor){
        self.selfBackgroundColor = backgroundColor;
        self.titleString = title;
        self.selfFont = font;
        self.fontColor = fontColor;
        
        self.backgroundColor = selfBackgroundColor;
        self.setTitle(titleString, for: .normal);
        self.titleLabel?.font = selfFont;
        self.setTitleColor(fontColor, for: .normal);
    }
    
    fileprivate func setup(){
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.layer.cornerRadius = 4;
    }
    
}
