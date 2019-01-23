//
//  ReviewImagesCollectionView.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/22/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

class ReviewImagesCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource{
    
    let imagesCellReuse = "ReviewImagesCellReuse";
    
    var images = [UIImage]();
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout);
        self.delegate = self;
        self.dataSource = self;
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.backgroundColor = UIColor.white;
        self.showsHorizontalScrollIndicator = true;
        self.alwaysBounceHorizontal = true;
        self.register(ReviewImagesCollectionViewCell.self, forCellWithReuseIdentifier: imagesCellReuse);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: imagesCellReuse, for: indexPath) as! ReviewImagesCollectionViewCell
        cell.setImage(image: images[indexPath.item]);
        return cell;
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count;
    }
}

class ReviewImagesCollectionViewCell: UICollectionViewCell{
    
    var imageView: UIImageView = {
        let imageView = UIImageView();
        imageView.translatesAutoresizingMaskIntoConstraints = false;
        imageView.contentMode = .scaleAspectFill;
        imageView.clipsToBounds = true;
        return imageView;
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = UIColor.white;
        setupImageView();
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setupImageView(){
        self.addSubview(imageView);
        imageView.anchor(left: nil, right: nil, top: self.topAnchor, bottom: self.bottomAnchor, constantLeft: 0, constantRight: 0, constantTop: 10, constantBottom: -10, width: 150, height: 0);
        imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true;
    }
    
    func setImage(image: UIImage){
        self.imageView.image = image;
    }
}
