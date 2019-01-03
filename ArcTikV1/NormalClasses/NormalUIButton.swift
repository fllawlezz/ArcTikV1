//
//  NormalUIButton.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/2/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

class NormalUIButton: UIButton{
    
    var selfBackgroundColor: UIColor!
    var titleString: String!
    var selfFont: UIFont!;
    var fontColor: UIColor!;
    
    init(backgroundColor: UIColor, title: String, font: UIFont, fontColor: UIColor){
        super.init(frame: .zero);
        self.selfBackgroundColor = backgroundColor;
        self.titleString = title;
        self.selfFont = font;
        self.fontColor = fontColor;
        setup();
    }
    
    override var buttonType: UIButtonType{
        return .system;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setup(){
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.backgroundColor = selfBackgroundColor;
        self.setTitle(titleString, for: .normal);
        self.titleLabel?.font = selfFont;
        self.setTitleColor(fontColor, for: .normal);
        self.layer.cornerRadius = 4;
    }
    
}
