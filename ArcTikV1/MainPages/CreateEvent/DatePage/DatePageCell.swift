//
//  DatePageCell.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/11/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

class DatePageCell: UICollectionViewCell,UITextFieldDelegate{
    
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
    
    let datePicker = UIDatePicker();
    
    var isTime = false;
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.backgroundColor = UIColor.white;
        addObserver();
        setupDatePicker();
        setupTitleLabel();
        setupInfoField();
        setupBorder();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    deinit{
        NotificationCenter.default.removeObserver(self);
    }
    
    fileprivate func addObserver(){
        let name = Notification.Name(resignDatePageNotification);
        NotificationCenter.default.addObserver(self, selector: #selector(self.resignInfoField), name: name, object: nil);
        
    }
    
    fileprivate func setupDatePicker(){
        datePicker.datePickerMode = .date;
        self.datePicker.addTarget(self, action: #selector(self.dateChanged), for: .valueChanged);
    }
    
    fileprivate func setupTitleLabel(){
        self.addSubview(titleLabel);
        titleLabel.anchor(left: self.leftAnchor, right: self.rightAnchor, top: self.topAnchor, bottom: nil, constantLeft: 25, constantRight: -25, constantTop: 10, constantBottom: 0, width: 0, height: 20);
    }
    
    fileprivate func setupInfoField(){
        self.addSubview(infoField);
        infoField.anchor(left: titleLabel.leftAnchor, right: self.rightAnchor, top: titleLabel.bottomAnchor, bottom: nil, constantLeft: 0, constantRight: -25, constantTop: 5, constantBottom: 0, width: 0, height: 30);
        infoField.delegate = self;
        infoField.inputView = self.datePicker;
        
    }
    
    fileprivate func setupBorder(){
        self.addSubview(border);
        border.anchor(left: self.leftAnchor, right: self.rightAnchor, top: nil, bottom: self.bottomAnchor, constantLeft: 25, constantRight: 0, constantTop: 0, constantBottom: 0, width: 0, height: 0.4);
    }
    
    func setTitle(title: String, placeholder: String){
        self.titleLabel.text = title;
        self.infoField.placeholder = placeholder;
    }
    
    func setDatePicker(){
        self.isTime = false;
        self.infoField.inputView = self.datePicker;
    }
    
    func setTimePicker(){
        self.isTime = true;
        self.infoField.inputView = self.datePicker;
        datePicker.datePickerMode = .time;
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if(!isTime){
            let dateFormatter = DateFormatter();
            dateFormatter.dateFormat = "MM/dd/yyyy"
            self.infoField.text = dateFormatter.string(from: datePicker.date);
        }else{
            let dateFormatter = DateFormatter();
            dateFormatter.dateFormat = "hh:mm a";
            self.infoField.text = dateFormatter.string(from: datePicker.date);
        }
        return true;
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let name = Notification.Name(rawValue: resignLocationPage);
        NotificationCenter.default.post(name: name, object: nil);
    }
}

extension DatePageCell{
    @objc func dateChanged(){
        if(!isTime){
            let dateFormatter = DateFormatter();
            dateFormatter.dateFormat = "MM/dd/yyyy"
            self.infoField.text = dateFormatter.string(from: datePicker.date);
        }else{
            let dateFormatter = DateFormatter();
            dateFormatter.dateFormat = "hh:mm a";
            self.infoField.text = dateFormatter.string(from: datePicker.date);
        }
    }
    
    @objc func resignInfoField(){
        self.infoField.resignFirstResponder();
    }
}
