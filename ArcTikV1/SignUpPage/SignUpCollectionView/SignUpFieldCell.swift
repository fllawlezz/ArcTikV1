//
//  SignUpFieldCell.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/2/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

class SignUpFieldCell: UICollectionViewCell{
    
    var cellTextField: NormalUITextField = {
        let cellTextField = NormalUITextField();
        cellTextField.translatesAutoresizingMaskIntoConstraints = false;
        cellTextField.placeholder = "YAAAAYYYAYAYA";
        cellTextField.font = UIFont.montserratSemiBold(fontSize: 14);
        cellTextField.textColor = UIColor.black;
        return cellTextField;
    }();
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = UIColor.white;
        setupCellTextField();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setupCellTextField(){
        self.addSubview(cellTextField);
        cellTextField.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true;
        cellTextField.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true;
        cellTextField.topAnchor.constraint(equalTo: self.topAnchor).isActive = true;
        cellTextField.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true;
    }
    
}

extension SignUpFieldCell{
    func setCellPlaceholder(placeHolder: String){
        self.cellTextField.placeholder = placeHolder;
    }
}
