//
//  SignUpPage.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/2/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

class SignUpPage: UIViewController {
    
    var clearButton: UIButton = {
        let clearButton = UIButton(type: .system);
        clearButton.translatesAutoresizingMaskIntoConstraints = false;
        clearButton.setBackgroundImage(UIImage(named: "clearWhite"), for: .normal);
        return clearButton;
    }()
    
    var signUpFields: SignUpFields = {
        let layout = UICollectionViewFlowLayout();
        let signUpFields = SignUpFields(frame: .zero, collectionViewLayout: layout);
        return signUpFields;
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.view.backgroundColor = UIColor.appBlue;
        
        setupClearButton();
    }
    
    fileprivate func setupClearButton(){
        self.view.addSubview(clearButton);
        clearButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true;
        clearButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true;
        clearButton.heightAnchor.constraint(equalToConstant: 40).isActive = true;
        clearButton.widthAnchor.constraint(equalToConstant: 40).isActive = true;
        
        clearButton.addTarget(self, action: #selector(self.handleClear), for: .touchUpInside);
    }
    
}

extension SignUpPage{
    @objc func handleClear(){
        self.navigationController?.popViewController(animated: true);
    }
}
