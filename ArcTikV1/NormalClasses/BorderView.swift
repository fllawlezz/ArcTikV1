//
//  border.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/13/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

class BorderView: UIView{
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.backgroundColor = UIColor.lightGray;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
}
