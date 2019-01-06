//
//  AnchoringExtension.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/6/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

extension UIView{
    
    func anchor(left: NSLayoutXAxisAnchor?, right: NSLayoutXAxisAnchor?, top: NSLayoutYAxisAnchor?, bottom: NSLayoutYAxisAnchor?, constantLeft: CGFloat = 0.0, constantRight: CGFloat = 0.0, constantTop: CGFloat = 0.0, constantBottom: CGFloat = 0.0, width: CGFloat = 0.0, height: CGFloat = 0.0){
        self.translatesAutoresizingMaskIntoConstraints = false;
        
        if let left = left{
            self.leftAnchor.constraint(equalTo: left, constant: constantLeft).isActive = true;
        }
        
        if let right = right{
            self.rightAnchor.constraint(equalTo: right, constant: constantRight).isActive = true;
        }
        
        if let top = top{
            self.topAnchor.constraint(equalTo: top, constant: constantTop).isActive = true;
        }
        
        if let bottom = bottom{
            self.bottomAnchor.constraint(equalTo: bottom, constant: constantBottom).isActive = true;
        }
        
        if(width != 0.0){
            self.widthAnchor.constraint(equalToConstant: width).isActive = true;
        }
        
        if(height != 0.0){
            self.heightAnchor.constraint(equalToConstant: height).isActive = true;
        }
    }

    func fillSuperView(){
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.anchor(left: superview?.leftAnchor, right: superview?.rightAnchor, top: superview?.topAnchor, bottom: superview?.bottomAnchor);
    }
    
}
