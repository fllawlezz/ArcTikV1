//
//  FiltersCategoryCell.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/6/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

class FiltersCategoryCell: UICollectionViewCell, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource{
    
    var categoryField: NormalUITextField = {
        let categoryField = NormalUITextField();
        categoryField.translatesAutoresizingMaskIntoConstraints = false;
        categoryField.font = UIFont.montserratSemiBold(fontSize: 14);
        categoryField.textAlignment = .center;
        categoryField.placeholder = "Category";
        categoryField.backgroundColor = UIColor.white;
        return categoryField;
    }()
    
    let categoryPicker = UIPickerView();
    
    let categories = ["Sports", "Gambling", "Other"];
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = UIColor.white;
        addObservers();
        setupCategoryPicker();
        setupCategoryField();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func addObservers(){
        let name = Notification.Name(rawValue: resignFiltersCategoryField);
        NotificationCenter.default.addObserver(self, selector: #selector(handleDismissCategoryField), name: name, object: nil);
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self);
    }
    
    fileprivate func setupCategoryPicker(){
        self.categoryPicker.dataSource = self;
        self.categoryPicker.delegate = self;
    }
    
    fileprivate func setupCategoryField(){
        self.addSubview(categoryField);
        categoryField.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true;
        categoryField.widthAnchor.constraint(equalToConstant: 200).isActive = true;
        categoryField.topAnchor.constraint(equalTo: self.topAnchor).isActive = true;
        categoryField.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true;
        
        categoryField.inputView = categoryPicker;
    }
    
}

extension FiltersCategoryCell{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count;
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row];
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.categoryField.text = categories[row];
    }
    
    @objc func handleDismissCategoryField(){
        self.categoryField.resignFirstResponder();
    }
}
