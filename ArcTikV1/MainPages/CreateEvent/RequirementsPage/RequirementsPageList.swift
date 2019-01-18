//
//  RequirementsPageList.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/17/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

let requirementsPageMaximumReach = "RequirementPageMaximumReached";


class RequirementsPageList: UICollectionViewController,UICollectionViewDelegateFlowLayout,RequirementsPageListCellDelegate {
    
    var nextButton: NormalUIButton = {
        let nextButton = NormalUIButton(type: .system);
        nextButton.setButtonProperties(backgroundColor: .appBlue, title: "Next", font: .montserratSemiBold(fontSize: 14), fontColor: .white);
        return nextButton;
    }()
    
    let reuseCell = "RequirementsPageListCell";
    let headerCell = "RequirementsPageHeaderReuse";
//    var numberOfItems = 0;
    var requirementsList = [String]();
    
    override func viewDidLoad() {
        super.viewDidLoad();
        collectionView?.backgroundColor = UIColor.white;
        collectionView?.register(RequirementsPageListCell.self, forCellWithReuseIdentifier: reuseCell);
        collectionView?.register(RequirementsPageTitleHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerCell);
        collectionView?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
        setupNavBar();
        setupNextButton();
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseCell, for: indexPath) as! RequirementsPageListCell;
        cell.setRequirementText(requirement: requirementsList[indexPath.item]);
        cell.indexPath = indexPath;
        cell.delegate = self;
        return cell;
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    fileprivate func setupNavBar(){
        let clearButton = UIBarButtonItem(image: UIImage(named: "clearWhiteNav"), style: .plain, target: self, action: #selector(self.handleClearPressed));
        self.navigationItem.leftBarButtonItem = clearButton;
        
        let plusButton = UIBarButtonItem(image: UIImage(named: "whitePlus"), style: .plain, target: self, action: #selector(self.handleAddButtonPressed));
        self.navigationItem.rightBarButtonItem = plusButton;
    }
    
    fileprivate func setupNextButton(){
        self.view.addSubview(nextButton);
        nextButton.anchor(left: nil, right: self.view.rightAnchor, top: nil, bottom: self.view.safeAreaLayoutGuide.bottomAnchor, constantLeft: 0, constantRight: -25, constantTop: 0, constantBottom: -25, width: 100, height: 40);
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return requirementsList.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 50);
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 70);
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerCell, for: indexPath) as! RequirementsPageTitleHeader;
        header.setTitleLabel(title: "List your requirements (Up to 10)");
        return header;
    }
    
}

extension RequirementsPageList{
    @objc func handleAddButtonPressed() {
        //handle add button pressed
        if(requirementsList.count < 10){
            let alert = UIAlertController(title: "Enter a requirement", message: "Enter a requirement for any applicants", preferredStyle: .alert);
            alert.addTextField { (textField) in
                textField.placeholder = "Requirement";
            }
            alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { (action) in
                //check for the length and append to the requirements list
                let textField = alert.textFields?[0]
                if(textField!.text!.count > 0){
//                    self.requirementsList.insert(textField!.text!, at: 0);
                    self.requirementsList.append(textField!.text!);
//                    self.collectionView?.reloadItems(at: [IndexPath(item: self.requirementsList.count-1, section: 0)])
                    self.collectionView?.insertItems(at: [IndexPath(item: self.requirementsList.count-1, section: 0)]);
                    
//                    self.collectionView?.reloadData();
                }
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil));
            self.present(alert, animated: true, completion: nil);
        }else{
            let name = Notification.Name(rawValue: requirementsPageMaximumReach);
            NotificationCenter.default.post(name: name, object: nil);
        }
    }
    
    func deleteCellAt(indexPath: IndexPath) {
        let alert = UIAlertController(title: "Delete Requirement?", message: "Are you sure you want to delete this requirement?", preferredStyle: .alert);
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { (action) in
            self.requirementsList.remove(at: indexPath.item);
            self.collectionView?.deleteItems(at: [indexPath]);
        }))
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: nil));
        self.present(alert, animated: true, completion: nil);
        
    }
    
    
    @objc func handleClearPressed(){
        let alert = UIAlertController(title: "Exit", message: "Do you want to save your listing?", preferredStyle: .alert);
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action) in
            //save
            self.dismiss(animated: true, completion: nil);
            //            self.navigationController?.popToRootViewController(animated: true);
        }))
        alert.addAction(UIAlertAction(title: "Discard", style: .destructive, handler: { (action) in
            //not save
            self.dismiss(animated: true, completion: nil);
            //            self.navigationController?.popToRootViewController(animated: true);
        }))
        self.present(alert, animated: true, completion: nil);
    }
    
}

protocol RequirementsPageListCellDelegate{
    func deleteCellAt(indexPath: IndexPath);
}

class RequirementsPageListCell: AddressResultCell{
    
    var border = BorderView();
    
    var indexPath: IndexPath?;
    var delegate: RequirementsPageListCellDelegate?;
    override init(frame: CGRect) {
        super.init(frame: frame);
        setupBorder();
        
        self.isUserInteractionEnabled = true;
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(holdGesture));
        self.addGestureRecognizer(gesture);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setupBorder(){
        self.addSubview(border);
        border.anchor(left: self.leftAnchor, right: self.rightAnchor, top: nil, bottom: self.bottomAnchor, constantLeft: 0, constantRight: 0, constantTop: 0, constantBottom: 0, width: 0, height: 0.4);
    }
    
    func setRequirementText(requirement: String){
        super.addressLabel.text = requirement;
    }
    
    @objc func holdGesture(){
        if let indexPath = self.indexPath{
            delegate?.deleteCellAt(indexPath: indexPath);
        }
        
    }
    
}

class RequirementsPageTitleHeader: CreatedEventsMainTitleHeader{
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        super.titleLabel.font = UIFont.montserratSemiBold(fontSize: 18);
        self.backgroundColor = UIColor.white;
        addObservers();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self);
    }
    
    fileprivate func addObservers(){
        let name = Notification.Name(rawValue: requirementsPageMaximumReach);
        NotificationCenter.default.addObserver(self, selector: #selector(titleLabelToRed), name: name, object: nil);
    }
    
    func setTitleLabel(title: String){
        super.setTitle(title: title);
    }
    
    @objc func titleLabelToRed(){
        super.titleLabel.textColor = UIColor.red;
    }
    
}
