//
//  SignUpFields.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/2/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

class SignUpFields: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{

    let signUpCellReuse = "reuse";
    let cellPlaceholders = ["Username", "FirstName", "LastName", "Email", "PhoneNumber", "Password"];
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout);
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.register(SignUpFieldCell.self, forCellWithReuseIdentifier: signUpCellReuse);
        self.backgroundColor = UIColor.white;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: signUpCellReuse, for: indexPath) as! SignUpFieldCell;
        cell.setCellPlaceholder(placeHolder: cellPlaceholders[indexPath.item]);
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
    
}
