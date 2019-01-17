//
//  LoadingView.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/17/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

class LoadingView: UIView{
    
    var backgroundView: UIView = {
        let backgroundView = UIView();
        backgroundView.translatesAutoresizingMaskIntoConstraints = false;
        backgroundView.backgroundColor = UIColor.darkText;
        backgroundView.alpha = 0.5;
        return backgroundView;
    }()
    
    var loadingIndicator: UIActivityIndicatorView = {
        let loadingIndicator = UIActivityIndicatorView();
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false;
        loadingIndicator.activityIndicatorViewStyle = .whiteLarge;
        return loadingIndicator;
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.addSubview(backgroundView);
        backgroundView.anchor(left: self.leftAnchor, right: self.rightAnchor, top: self.topAnchor, bottom: self.bottomAnchor);
        setupLoadingIndicator();
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setupLoadingIndicator(){
        self.addSubview(loadingIndicator);
        loadingIndicator.anchorCenter(centerXanchor: self.centerXAnchor, centerYAnchor: self.centerYAnchor, topAnchor: nil, bottomAnchor: nil);
        loadingIndicator.widthAnchor.constraint(equalToConstant: 30).isActive = true;
        loadingIndicator.heightAnchor.constraint(equalToConstant: 30).isActive = true;
        
        loadingIndicator.startAnimating();
    }
}
