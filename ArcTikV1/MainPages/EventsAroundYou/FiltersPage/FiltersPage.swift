//
//  FiltersPage.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/6/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

class FiltersPage: UIViewController{
    
    var filtersList: FiltersViewCollectionView = {
        let layout = UICollectionViewFlowLayout();
        let filtersList = FiltersViewCollectionView(frame: .zero, collectionViewLayout: layout);
        return filtersList;
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.view.backgroundColor = UIColor.veryLightGray;
        setupNavBar();
        setupFiltersList();
    }
    
    fileprivate func setupNavBar(){
//        let clearButton = UIBarButtonItem(image: UIImage(named: "clearWhite"), style: .plain, target: self, action: #selector(self.handleClearPressed));
        self.navigationItem.title = "Filters";
        
        let cancelButton = UIBarButtonItem(title: "cancel", style: .plain, target: self, action: #selector(self.handleClearPressed));
        self.navigationItem.leftBarButtonItem = cancelButton;
        
        let searchButton = UIBarButtonItem(title: "Search", style: .plain, target: nil, action: nil);
        self.navigationItem.rightBarButtonItem = searchButton;
        
    }
    
    fileprivate func setupFiltersList(){
        self.view.addSubview(filtersList);
        filtersList.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        filtersList.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        filtersList.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true;
        filtersList.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true;
    }
    
}

extension FiltersPage{
    @objc func handleClearPressed(){
        self.dismiss(animated: true, completion: nil);
    }
}
