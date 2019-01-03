//
//  SignUpFields.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/2/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//
import Foundation;
import UIKit

class SignUpFields: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, SignUpFieldCellDelegate{

    let signUpCellReuse = "reuse";
    let cellPlaceholders = ["Username", "FirstName", "LastName", "Email", "PhoneNumber", "Password"];
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout);
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.register(SignUpFieldCell.self, forCellWithReuseIdentifier: signUpCellReuse);
        self.backgroundColor = UIColor.white;
        self.dataSource = self;
        self.delegate = self;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: signUpCellReuse, for: indexPath) as! SignUpFieldCell;
        cell.delegate = self;
        cell.setIndex(indexNumber: indexPath.item);
        cell.setCellPlaceholder(placeHolder: cellPlaceholders[indexPath.item]);
        
        if(indexPath.item == 5){
            cell.handleHideBorder();
            cell.setDoneReturnKey();
            cell.setSecureEntry();
        }
        
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6;
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width, height: 40);
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
    
}

extension SignUpFields{
    func nextSignUpField(index: Int) {
        if(index != 5){
            let cell = self.cellForItem(at: IndexPath(item: index+1, section: 0)) as! SignUpFieldCell;
            cell.cellTextField.becomeFirstResponder();
        }else{
            let name = Notification.Name(rawValue: resignSignUpPage);
            NotificationCenter.default.post(name: name, object: nil);
        }
    }
    
}
