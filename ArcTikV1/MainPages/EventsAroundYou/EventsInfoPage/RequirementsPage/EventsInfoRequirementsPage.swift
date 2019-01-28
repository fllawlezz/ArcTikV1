//
//  EventsInfoRequirementsPage.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/15/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

class EventsInfoRequirementsPage: UICollectionViewController, UICollectionViewDelegateFlowLayout{
    
//    let requirementsList = [
//        "Not Jason Koon",
//        "Able to play poker",
//        "Knows the game well",
//        "Not Phil Hellmuth",
//        "Yes Phil Hellmuth",
//        "Yes Tom Dwan",
//        "Not Andrew Robl",
//        "Not Elton Tsang",
//        "Not the president"
//    ]
    
    var requirementsList = [String]();
    
    var cellReuse = "EventsInfoRequirementsCellReuse"
    var headerReuse = "EventsInfoRequirementsHeaderReuse";
    
    override func viewDidLoad() {
        super.viewDidLoad();
        setupNavBar();
        collectionView?.register(EventsInfoRequirementsCell.self, forCellWithReuseIdentifier: cellReuse);
        collectionView?.register(EventsInfoRequirementsPageHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerReuse)
        collectionView?.backgroundColor = UIColor.white;
    }
    
    fileprivate func setupNavBar(){
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "clearWhiteNav"), style: .plain, target: self, action: #selector(self.handleClearPressed));
        self.navigationItem.leftBarButtonItem = backButton;
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuse, for: indexPath) as! EventsInfoRequirementsCell
        cell.setTitle(text: requirementsList[indexPath.item]);
        return cell;
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return requirementsList.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 50);
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerReuse, for: indexPath) as! EventsInfoRequirementsPageHeader
        header.setTitle(text: "Requirements");
        return header;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 50);
    }
}

extension EventsInfoRequirementsPage{
    @objc func handleClearPressed(){
        self.dismiss(animated: true, completion: nil);
    }
}

class EventsInfoRequirementsCell:UICollectionViewCell{
    
    var titleLabel: NormalUILabel = {
        let titleLabel = NormalUILabel(textColor: .darkText, font: .montserratRegular(fontSize: 14), textAlign: .left);
        titleLabel.text = "Text goes here";
        return titleLabel;
    }()
    
    let border = BorderView();
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = UIColor.white;
        setupTitleLabel();
        setupBorder();
    }
    
    fileprivate func setupTitleLabel(){
        self.addSubview(titleLabel);
        titleLabel.anchor(left: self.leftAnchor, right: self.rightAnchor, top: self.topAnchor, bottom: self.bottomAnchor, constantLeft: 25, constantRight: 0, constantTop: 0, constantBottom: 0, width: 0, height: 0);
    }
    
    fileprivate func setupBorder(){
        self.addSubview(border);
        border.anchor(left: self.leftAnchor, right: self.rightAnchor, top: nil, bottom: self.bottomAnchor, constantLeft: 25, constantRight: 0, constantTop: 0, constantBottom: 0, width: 0, height: 0.4);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    func setTitle(text: String){
        self.titleLabel.text = text;
    }
}

class EventsInfoRequirementsPageHeader: UICollectionReusableView{
    
    var titleLabel: NormalUILabel = {
        let titleLabel = NormalUILabel(textColor: .darkText, font: .montserratSemiBold(fontSize: 20), textAlign: .left);
        titleLabel.text = "Text goes here";
        return titleLabel;
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = UIColor.white;
        setupTitleLabel();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setupTitleLabel(){
        self.addSubview(titleLabel);
        titleLabel.anchor(left: self.leftAnchor, right: self.rightAnchor, top: self.topAnchor, bottom: self.bottomAnchor, constantLeft: 25, constantRight: 0, constantTop: 0, constantBottom: 0, width: 0, height: 0);
    }
    
    func setTitle(text: String){
        self.titleLabel.text = text;
    }
}
