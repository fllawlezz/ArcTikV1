//
//  MoreInfoPage.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/8/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

let accountInfoEditButtonPressed = "AccountInfoEditButtonPressed";
let accountInfoDoneButtonPressed = "AccountInfoDoneButtonPressed";

class MoreInfoPage: UIViewController{
    
    var moreInfoList: MoreInfoCollectionView = {
        let layout = UICollectionViewFlowLayout();
        let moreInfoList = MoreInfoCollectionView(frame: .zero, collectionViewLayout: layout);
        return moreInfoList;
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.view.backgroundColor = UIColor.white;
        setupNavBar();
        setupInfoList();
    }
    
    fileprivate func setupNavBar(){
        self.navigationItem.title = "Account Info";
        
        let editButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(self.handleEditButtonPressed));
        self.navigationItem.rightBarButtonItem = editButton;
        
        let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil);
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton;
        
    }
    
    fileprivate func setupInfoList(){
        self.view.addSubview(moreInfoList);
        moreInfoList.anchor(left: self.view.leftAnchor, right: self.view.rightAnchor, top: self.view.topAnchor, bottom: self.view.bottomAnchor, constantLeft: 0, constantRight: 0, constantTop: 0, constantBottom: 0, width: 0, height: 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false;
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true;
    }
}

extension MoreInfoPage{
    @objc func handleEditButtonPressed(){
        let alert = UIAlertController(title: "Edit Account Details?", message: "Are you sure you want to edit your account details?", preferredStyle: .alert);
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { (action) in
            let name = Notification.Name(rawValue: accountInfoEditButtonPressed);
            NotificationCenter.default.post(name: name, object: nil);
            
            let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.handleDoneButtonPressed));
            self.navigationItem.setRightBarButton(doneButton, animated: true);
            
        }))
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: nil));
        self.present(alert, animated: true, completion: nil);
        
    }
    
    @objc func handleDoneButtonPressed(){
        let donePressedName = Notification.Name(rawValue: accountInfoDoneButtonPressed);
        NotificationCenter.default.post(name: donePressedName, object: nil);
        
        let resignRespondersName = Notification.Name(rawValue: accountInfoFieldsResign);
        NotificationCenter.default.post(name: resignRespondersName, object: nil);
        
        let editButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(self.handleEditButtonPressed));
        self.navigationItem.rightBarButtonItem = editButton;
    }
}
