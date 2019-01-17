//
//  SettingsPage.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/9/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

class SettingsPage: UICollectionViewController, UICollectionViewDelegateFlowLayout{
    
    let settingsReuse = "SettingsCellReuse"
    
    let cellTitles = [
        "Push Notifications",
        "SMS Notifications",
        "Terms and Agreements",
        "Privacy Policy",
        "Logout"
      ]
    
    let cellDescriptions = [
        "On to recieve push notifications",
        "On to recieve SMS notifications",
        "Read our Terms and Agreements",
        "Read our Privacy Policy",
        "Logout from app"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.view.backgroundColor = UIColor.appBlue;
        
        collectionView?.backgroundColor = UIColor.white;
        
        self.collectionView?.register(SettingsPageCell.self, forCellWithReuseIdentifier: settingsReuse);
        setupNavBar();
    }
    
    fileprivate func setupNavBar(){
        self.navigationItem.title = "Settings";
        
        let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil);
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton;
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: settingsReuse, for: indexPath) as! SettingsPageCell;
        cell.setTitleAndDescription(title: cellTitles[indexPath.item], description: cellDescriptions[indexPath.item])
        if(indexPath.item > 1){
            cell.hideSwitch();
        }
        return cell;
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 70);
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(indexPath.item == 4){
            showLogoutAlert();
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false;
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true;
    }
}

extension SettingsPage{
    func showLogoutAlert(){
        let alert = UIAlertController(title: "Logout", message: "Do you really want to logout?", preferredStyle: .alert);
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { (action) in
            //logout, get rid of userDefaults
            clearUser();
            user = nil;
            let loginViewController = LoginPage();
            let startingNavigationController = UINavigationController(rootViewController: loginViewController);
            startingNavigationController.isNavigationBarHidden = true;
            self.present(startingNavigationController, animated: true, completion: nil);
        }))
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: nil));
        self.present(alert, animated: true, completion: nil);
    }
}
