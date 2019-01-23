//
//  UploadImageCell.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/22/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

protocol UploadImageCellProtocol{
    func removeImageAt(indexPath: IndexPath);
}

class UploadImageCell: UICollectionViewCell{
    
    var imageView: UIImageView = {
        let imageView = UIImageView();
        imageView.translatesAutoresizingMaskIntoConstraints = false;
        imageView.contentMode = .scaleAspectFill;
        imageView.clipsToBounds = true;
        imageView.isUserInteractionEnabled = true;
        return imageView;
    }()
    
    var indexPath: IndexPath?
    var delegate: UploadImageCellProtocol?;
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = UIColor.blue;
        setupImageView();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setupImageView(){
        self.addSubview(imageView);
        imageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true;
        imageView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true;
        imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true;
        imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true;
        
        imageView.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(handleImageLongPressed)));
    }
    
    func setImage(image: UIImage){
        self.imageView.image = image;
    }
    
}

extension UploadImageCell{
    
    @objc func handleImageLongPressed(){
        if let indexPath = self.indexPath{
            delegate?.removeImageAt(indexPath: indexPath);
        }
        
    }
    
}
