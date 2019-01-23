//
//  UploadImagesList.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/22/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

class UploadImagesList:UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource{
    
    var images = [UIImage]();
    
    let cellReuse = "UploadImagesListReuse";
    let tapReuse = "UPloadImagesListTapCell";
    
    var uploadImagesPage: UploadImagesPage?;
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout);
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.delegate = self;
        self.dataSource = self;
        self.alwaysBounceHorizontal = true;
//        self.contentInset = UIEdgeInsets(top: 0, left: 40, bottom: 0, right: -40);
        self.showsHorizontalScrollIndicator = true;
        self.backgroundColor = UIColor.white;
        self.register(UploadImageCell.self, forCellWithReuseIdentifier: cellReuse);
        self.register(UploadImagesAddCell.self, forCellWithReuseIdentifier: tapReuse);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(indexPath.item == images.count){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: tapReuse, for: indexPath) as! UploadImagesAddCell
            cell.delegate = self.uploadImagesPage;
            return cell;
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuse, for: indexPath) as! UploadImageCell
        cell.setImage(image: images[indexPath.item]);
        cell.delegate = self.uploadImagesPage;
        cell.indexPath = indexPath;
        return cell;
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(images.count >= 5){
            return images.count;
        }
        return images.count+1;
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 150, height: 170);
//    }
    
    
    
    
}
