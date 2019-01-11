//
//  PrivacyPage.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/10/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

class PrivacyPage: UICollectionViewController, UICollectionViewDelegateFlowLayout, UIPickerViewDelegate, UIPickerViewDataSource{
    
    var nextButton: NormalUIButton = {
        let nextButton = NormalUIButton(type: .system);
        nextButton.setButtonProperties(backgroundColor: .appBlue, title: "Next", font: .montserratSemiBold(fontSize: 14), fontColor: .white)
        return nextButton;
    }()
    
    var pickerView = UIPickerView();
    var numberPickerView = UIPickerView();
    
    var pickerViewTitles = ["Public","Private"]
    var pickerViewNumbers = ["2","3","4","5","6","7","8","9","10","12","14","16","18","20","25","30","40","50","60","70","80","90","91+"];
    
    let privacyPageCellReuse = "PrivacyPageCellReuse";
    let privacyHeaderReuse = "PrivacyHeaderReuse";
    
    let headerTitles = ["Who can come to this event?","How many people can come to this event?"];
    let cellTitles = ["Public/Private","Number of People"]
    let cellPlaceholders = ["eg: Private","eg: 22"]
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        collectionView?.backgroundColor = UIColor.white;
        collectionView?.register(LocationPageCell.self, forCellWithReuseIdentifier: privacyPageCellReuse);
        collectionView?.register(CreateEventMainHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: privacyHeaderReuse);
        setupNavBar();
        setupPicker();
        setupNextButton();
    }
    
    fileprivate func setupNavBar(){
        let clearButton = UIBarButtonItem(image: UIImage(named: "clearWhiteNav"), style: .plain, target: self, action: #selector(self.handleClearPressed));
        self.navigationItem.leftBarButtonItem = clearButton;
    }
    
    fileprivate func setupNextButton(){
        
        self.view.addSubview(nextButton);
        nextButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -10).isActive = true;
        
        nextButton.widthAnchor.constraint(equalToConstant: 100).isActive = true;
        nextButton.heightAnchor.constraint(equalToConstant: 40).isActive = true;
        
        if(UIScreenHeight! == 812.0){
            nextButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -(self.view.frame.height/2)+30).isActive = true;
        }else if(UIScreenHeight! == 736){
            nextButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -(self.view.frame.height/3)-70).isActive = true;
        }else if(UIScreenHeight! > 812.0){
            nextButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -(self.view.frame.height/2)).isActive = true;
        }else{
            nextButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -(self.view.frame.height/3)-40).isActive = true;
        }
        
        nextButton.addTarget(self, action: #selector(self.handleNextButtonPressed), for: .touchUpInside);
    }
    
    fileprivate func setupPicker(){
        pickerView.delegate = self;
        pickerView.dataSource = self;
        
        numberPickerView.delegate = self;
        numberPickerView.dataSource = self;
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: privacyPageCellReuse, for: indexPath) as! LocationPageCell
        cell.setTitle(title: cellTitles[indexPath.section], placeholder: cellPlaceholders[indexPath.section])
        if(indexPath.section == 0){
            cell.infoField.text = "Public";
            cell.infoField.inputView = self.pickerView;
        }else{
//            cell.infoField.keyboardType = .numberPad;
            cell.infoField.inputView = self.numberPickerView;
            cell.infoField.text = "2";
        }
        return cell;
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2;
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 70);
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 70);
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: privacyHeaderReuse, for: indexPath) as! CreateEventMainHeader
        header.setTitle(title: headerTitles[indexPath.section])
        return header;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
}

extension PrivacyPage{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(pickerView == self.pickerView){
            return 2;
        }else{
            return pickerViewNumbers.count;
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(pickerView == self.pickerView){
            return pickerViewTitles[row];
        }else{
            return pickerViewNumbers[row];
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(pickerView == self.pickerView){
            let cell = collectionView?.cellForItem(at: IndexPath(item: 0, section: 0)) as! LocationPageCell;
            cell.infoField.text = pickerViewTitles[row];
        }else{
            let cell = collectionView?.cellForItem(at: IndexPath(item: 0, section: 1)) as! LocationPageCell;
            cell.infoField.text = pickerViewNumbers[row];
        }
    }
    
    
}

extension PrivacyPage{
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
    
    @objc func handleNextButtonPressed(){
        
    }
}

