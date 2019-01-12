//
//  FriendsListPageCollectionViewController.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/9/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

class FriendsListPage: UICollectionViewController, UICollectionViewDelegateFlowLayout, FriendCellDelegate, FriendRequestCellDelegate {
    
    let friendRequestCellReuse = "FriendsListPage";
    let friendCellReuse = "FriendsListCell";
    let friendsListHeader = "FriendsListHeader";
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        collectionView?.backgroundColor = UIColor.veryLightGray;
        // Register cell classes
        self.collectionView!.register(FriendRequestCell.self, forCellWithReuseIdentifier: friendRequestCellReuse);
        collectionView?.register(FriendCell.self, forCellWithReuseIdentifier: friendCellReuse);
        collectionView?.register(AppliedHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: friendsListHeader);
        
        // Do any additional setup after loading the view.
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2;
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(indexPath.section == 0){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: friendRequestCellReuse, for: indexPath) as! FriendRequestCell
            // Configure the cell
            cell.setImage(image: #imageLiteral(resourceName: "dneg"))
            cell.delegate = self;
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: friendCellReuse, for: indexPath) as! FriendCell;
            cell.delegate = self;
            return cell;
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width-20, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 50);
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: friendsListHeader, for: indexPath) as! AppliedHeader;
        if(indexPath.section == 0){
            cell.setTitleLabel(title: "Requests");
        }else{
            cell.setTitleLabel(title: "Friends");
        }
        return cell;
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false;
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true;
    }

}

extension FriendsListPage{
    func handleShowActionSheet() {
        let friendsActionSheet = FriendsAlertView();
        friendsActionSheet.modalTransitionStyle = .crossDissolve;
        friendsActionSheet.modalPresentationStyle = .overFullScreen;
        self.present(friendsActionSheet, animated: true, completion: nil);
    }
    
    func showFriendOptions(){
        let alert = UIAlertController(title: "Options", message: "What do you want to do?", preferredStyle: .actionSheet);
        alert.addAction(UIAlertAction(title: "Message", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Un-Friend", style: .destructive, handler: nil))
        alert.addAction(UIAlertAction(title: "Block", style: .destructive, handler: nil))
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil);
    }
    
    func handleFriendRequestImagePressed(){
        self.showFriendOptions();
    }
}
