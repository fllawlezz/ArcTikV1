//
//  MainFiltersPage.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/15/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

class MainFiltersPage: UICollectionViewController, UICollectionViewDelegateFlowLayout{
    
    var searchButtonView: FiltersButtonView = {
        let searchButtonView = FiltersButtonView();
        return searchButtonView;
    }()
    
    var backgroundView: UIView = {
        let backgroundView = UIView();
        backgroundView.translatesAutoresizingMaskIntoConstraints = false;
        backgroundView.backgroundColor = UIColor.white;
        return backgroundView;
    }()
    
    let cellReuse = "MainFiltersPageReuse";
    let headerReuse = "MainFiltersHeaderReuse";
    
    let headerTitles = ["Distance","Price"];
    let cellTitlesSection0 = ["5 miles","10 miles","20 miles","50 miles"];
    let cellDescriptionSection0 = ["All events 5 miles around you","All events 10 miles around you","All events 20 miles around you","All events 50 miles around you"];
    let cellTitlesSection1 = ["$","$$","$$$","$$$$","$$$$$"]
    let cellDescriptionSection1 = ["Free to $10","$10 to $30","$30 to $75","$75 to $200","$200 and up"];
    
    override func viewDidLoad() {
        super.viewDidLoad();
        setupNavBar();
        collectionView?.showsVerticalScrollIndicator = false;
        collectionView?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 80, right: 0);
        self.collectionView?.backgroundColor = UIColor.white;
        collectionView?.register(MainFilterCell.self, forCellWithReuseIdentifier: cellReuse);
        collectionView?.register(MainFilterHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerReuse);
        setupSearchButtonView();
        if(UIScreenHeight! >= 812.0){
            setupBackground();
        }
    }
    
    fileprivate func setupNavBar(){
        let clearButton = UIBarButtonItem(image: #imageLiteral(resourceName: "clearWhiteNav"), style: .plain, target: self, action: #selector(handleClearPressed));
        self.navigationItem.leftBarButtonItem = clearButton;
        
        let searchButton = UIBarButtonItem(title: "Clear All", style: .plain, target: nil, action: nil);
        self.navigationItem.rightBarButtonItem = searchButton;
        
        self.navigationItem.title = "Filters";
    }
    
    fileprivate func setupSearchButtonView(){
        self.view.addSubview(searchButtonView);
        searchButtonView.anchor(left: self.view.leftAnchor, right: self.view.rightAnchor, top: nil, bottom: self.view.safeAreaLayoutGuide.bottomAnchor, constantLeft: 0, constantRight: 0, constantTop: 0, constantBottom: 0, width: 0, height: 80);
    }
    
    fileprivate func setupBackground(){
        self.view.addSubview(backgroundView);
        backgroundView.anchor(left: self.view.leftAnchor, right: self.view.rightAnchor, top: nil, bottom: self.view.bottomAnchor, constantLeft: 0, constantRight: 0, constantTop: 0, constantBottom: 0, width: 0, height: 50);
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuse, for: indexPath) as! MainFilterCell;
        if(indexPath.section == 0){
            cell.setTitle(text: cellTitlesSection0[indexPath.item]);
            cell.setDescription(text: cellDescriptionSection0[indexPath.item]);
        }else{
            cell.setTitle(text: cellTitlesSection1[indexPath.item])
            cell.setDescription(text: cellDescriptionSection1[indexPath.item]);
        }
        return cell;
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2;
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(section == 0){
            return 4;
        }else{
            return 5;
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 70);
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerReuse, for: indexPath) as! MainFilterHeader;
        if(indexPath.section == 0){
            header.setTitleLabel(text: "Distance");
        }else{
            header.setTitleLabel(text: "Price");
        }
        return header;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 70);
    }
}

extension MainFiltersPage{
    
    @objc func handleClearPressed(){
        self.dismiss(animated: true, completion: nil);
    }
}
