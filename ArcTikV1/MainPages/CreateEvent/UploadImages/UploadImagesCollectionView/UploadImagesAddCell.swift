//
//  UploadImagesAddCell.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/22/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

protocol UploadImagesAddCellDelegate{
    
    func handleAddTapped();
    
}

class UploadImagesAddCell: UICollectionViewCell{
    
    var imageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "plus"));
        imageView.translatesAutoresizingMaskIntoConstraints = false;
        imageView.contentMode = .scaleAspectFill;
        imageView.clipsToBounds = true;
        imageView.isUserInteractionEnabled = true;
        return imageView;
    }()
    
    var delegate: UploadImagesAddCellDelegate?;
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = UIColor.white;
        setupImageView();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    fileprivate func setupImageView(){
        self.addSubview(imageView);
        imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true;
        imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true;
        imageView.widthAnchor.constraint(equalToConstant: 50).isActive = true;
        imageView.heightAnchor.constraint(equalToConstant: 50).isActive = true;
        
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.handleTap)));
    }
    
    @objc func handleTap(){
//        print("selected");
        delegate?.handleAddTapped()
    }
}
