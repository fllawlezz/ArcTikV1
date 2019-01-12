//
//  SignUpFieldCell.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/2/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

let nextSignUpField = "nextSignUpField";

protocol SignUpFieldCellDelegate{
    func nextSignUpField(index: Int);
}

class SignUpFieldCell: UICollectionViewCell, UITextFieldDelegate{
    
    var cellTextField: NormalUITextField = {
        let cellTextField = NormalUITextField();
        cellTextField.translatesAutoresizingMaskIntoConstraints = false;
        cellTextField.placeholder = "YAAAAYYYAYAYA";
        cellTextField.font = UIFont.montserratSemiBold(fontSize: 14);
        cellTextField.textColor = UIColor.black;
        return cellTextField;
    }();
    
    fileprivate var cellBorder: UIView = {
        let border = UIView();
        border.translatesAutoresizingMaskIntoConstraints = false;
        border.backgroundColor = UIColor.lightGray;
        return border;
    }()
    
    var delegate: SignUpFieldCellDelegate?;
    
    fileprivate var indexNumber = 0;
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = UIColor.white;
        addObservers();
        setupCellTextField();
        setupBorder();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    deinit{
        NotificationCenter.default.removeObserver(self);
    }
    
    func addObservers(){
        let name = Notification.Name(rawValue: resignSignUpPage);
        NotificationCenter.default.addObserver(self, selector: #selector(self.resignTextField), name: name, object: nil);
    }
    
    fileprivate func setupCellTextField(){
        self.addSubview(cellTextField);
        cellTextField.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true;
        cellTextField.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true;
        cellTextField.topAnchor.constraint(equalTo: self.topAnchor).isActive = true;
        cellTextField.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true;
        
        cellTextField.returnKeyType = .next;
        cellTextField.delegate = self;
    }
    
    fileprivate func setupBorder(){
        self.addSubview(cellBorder);
        cellBorder.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true;
        cellBorder.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true;
        cellBorder.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true;
        cellBorder.heightAnchor.constraint(equalToConstant: 0.4).isActive = true;
    }
    
}

extension SignUpFieldCell{
    func setCellPlaceholder(placeHolder: String){
        self.cellTextField.placeholder = placeHolder;
    }
    
    func handleHideBorder(){
        self.cellBorder.isHidden = true;
    }
    
    @objc func resignTextField(){
        self.cellTextField.resignFirstResponder();
    }
    
    func setIndex(indexNumber: Int){
        self.indexNumber = indexNumber;
    }
    
    func setDoneReturnKey(){
        self.cellTextField.returnKeyType = .done;
    }
    
    func setSecureEntry(){
        self.cellTextField.isSecureTextEntry = true;
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        let name = Notification.Name(rawValue: nextSignUpField);
//        NotificationCenter.default.post(name: name, object: nil);
        
        delegate?.nextSignUpField(index: self.indexNumber);
        
        return true;
    }
}
