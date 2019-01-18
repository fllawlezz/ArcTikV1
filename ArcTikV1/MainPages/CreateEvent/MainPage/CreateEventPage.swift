//
//  CreateEventPage.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/9/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

var currentEvent: MyEvent?;

let reloadCreateEventPage = "ReloadCreateEventPage";

class CreateEventPage: UICollectionViewController, UICollectionViewDelegateFlowLayout, CreateEventMainCellDelegate {
    
    let createEventCellReuse = "CreateEventCellReuse";
    let createEventHeaderReuse = "CreateEventHeaderReuse";
    
    let titleList = ["Event Title","Description","Location","Requirements","Privacy","Date","Pricing","Review"];
    
//    var currentStep = currentEvent!.stepNumber;
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        addObservers();
        collectionView?.backgroundColor = UIColor.white;
        // Register cell classes
        self.collectionView!.register(CreateEventMainCell.self, forCellWithReuseIdentifier: createEventCellReuse)
        self.collectionView?.register(CreateEventMainHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: createEventHeaderReuse);
        setupNavBar();
        // Do any additional setup after loading the view.
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self);
    }
    
    fileprivate func addObservers(){
        let name = Notification.Name(rawValue: reloadCreateEventPage);
        NotificationCenter.default.addObserver(self, selector: #selector(self.reloadCollectionView), name: name, object: nil);
    }
    
    fileprivate func setupNavBar(){
        
        let clearButton = UIBarButtonItem(image: UIImage(named: "clearWhiteNav"), style: .plain, target: self, action: #selector(self.handleClearPressed));
        self.navigationItem.leftBarButtonItem = clearButton;
    }
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 8;
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: createEventCellReuse, for: indexPath) as! CreateEventMainCell
        cell.setTitle(title: titleList[indexPath.item])
        cell.delegate = self;
        
        if(indexPath.item == currentEvent!.stepNumber){
            cell.revealContinueButton();
        }else{
            cell.continueButton.isHidden = true;
        }
        
        if(indexPath.item < currentEvent!.stepNumber){
            cell.revealGreenCheck();
        }else{
            cell.checkMarkImage.isHidden = true;
        }
        // Configure the cell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if(indexPath.item == currentEvent!.stepNumber){
            return CGSize(width: self.view.frame.width, height: 110);
        }
        return CGSize(width: self.view.frame.width, height: 50);
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 70);
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: createEventHeaderReuse, for: indexPath) as! CreateEventMainHeader
        return header;
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }

}

extension CreateEventPage{
    @objc func reloadCollectionView(){
        self.collectionView?.reloadData();
    }
    
    @objc func handleClearPressed(){
        self.dismiss(animated: true, completion: nil);
//        self.navigationController?.dismiss(animated: true, completion: nil);
    }
    
    func continuePressed() {
        let descriptionPage = TitlePage();
        
        let navigationController = UINavigationController(rootViewController: descriptionPage);
        navigationController.navigationBar.isTranslucent = false;
        navigationController.navigationBar.barStyle = .blackTranslucent;
        navigationController.navigationBar.tintColor = UIColor.white;
        navigationController.navigationBar.barTintColor = UIColor.appBlue;
        self.present(navigationController, animated: true, completion: nil);
        
        
    }
    
}
