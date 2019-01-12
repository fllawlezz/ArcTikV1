//
//  LocationPageCell.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/10/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

class LocationPageCell: UICollectionViewCell, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate{
    
    var titleLabel: NormalUILabel = {
        let titleLabel = NormalUILabel(textColor: .darkText, font: .montserratSemiBold(fontSize: 14), textAlign: .left);
        titleLabel.text = "Text goes here";
        return titleLabel;
    }()
    
    var infoField: NormalUITextField = {
        let infoField = NormalUITextField();
        infoField.translatesAutoresizingMaskIntoConstraints = false;
        infoField.font = UIFont.systemFont(ofSize: 14);
        infoField.spellCheckingType = .no;
        infoField.autocorrectionType = .no;
        return infoField;
    }()
    
    var border: UIView = {
        let border = UIView();
        border.translatesAutoresizingMaskIntoConstraints = false;
        border.backgroundColor = UIColor.lightGray;
        return border;
    }()
    
    let countryList = ["United States","Canada","England","France"];
    
    let pickerView = UIPickerView();
    
    var indexPath: Int?{
        didSet{
            if(indexPath == 0){
                self.infoField.inputView = pickerView;
            }
            
            if(indexPath == 3){
                self.infoField.keyboardType = .numberPad;
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.backgroundColor = UIColor.white;
        addObserver();
        setupTitleLabel();
        setupInfoField();
        setupPickerView()
        setupBorder();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    deinit{
        NotificationCenter.default.removeObserver(self);
    }
    
    fileprivate func addObserver(){
        let name = Notification.Name(rawValue: setCountryNotification);
        NotificationCenter.default.addObserver(self, selector: #selector(setCountry(notification:)), name: name, object: nil);
        
        let resignInfoCellName = Notification.Name(rawValue: resignLocationPage);
        NotificationCenter.default.addObserver(self, selector: #selector(self.resignInfoField), name: resignInfoCellName, object: nil);
    }
    
    fileprivate func setupPickerView(){
        pickerView.delegate = self;
        pickerView.dataSource = self;
//        infoField.inputView = pickerView;
    }
    
    fileprivate func setupTitleLabel(){
        self.addSubview(titleLabel);
        titleLabel.anchor(left: self.leftAnchor, right: self.rightAnchor, top: self.topAnchor, bottom: nil, constantLeft: 25, constantRight: -25, constantTop: 10, constantBottom: 0, width: 0, height: 20);
    }
    
    fileprivate func setupInfoField(){
        self.addSubview(infoField);
        infoField.anchor(left: titleLabel.leftAnchor, right: self.rightAnchor, top: titleLabel.bottomAnchor, bottom: nil, constantLeft: 0, constantRight: -25, constantTop: 5, constantBottom: 0, width: 0, height: 30);
        infoField.delegate = self;
    }
    
    fileprivate func setupBorder(){
        self.addSubview(border);
        border.anchor(left: self.leftAnchor, right: self.rightAnchor, top: nil, bottom: self.bottomAnchor, constantLeft: 25, constantRight: 0, constantTop: 0, constantBottom: 0, width: 0, height: 0.4);
    }
    
    func setTitle(title: String, placeholder: String){
        self.titleLabel.text = title;
        self.infoField.placeholder = placeholder;
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let name = Notification.Name(rawValue: resignLocationPage);
        NotificationCenter.default.post(name: name, object: nil);
    }
}

extension LocationPageCell{
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countryList.count;
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(self.indexPath == 0){//is the country
            self.infoField.text = countryList[row];
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return countryList[row];
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if(self.indexPath == 0){
            self.infoField.text = "United States";
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.infoField.resignFirstResponder();
        return true;
    }
}

extension LocationPageCell{
    @objc func resignInfoField(){
        self.infoField.resignFirstResponder();
    }
    
    @objc func setCountry(notification: NSNotification){
        if let object = notification.userInfo{
            let country = object["userInfo"];
            print(country as! String);
        }
    }
}
