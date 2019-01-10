//
//  MoreInfoCollectionView.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/8/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

let accountInfoFieldsResign = "AccountInfoFieldsResign";

class MoreInfoCollectionView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, MoreInfoCollectionViewCellDelegate{
    
    let moreInfoCell = "MoreInfoCellReuse";
    let passwordInfoCell = "PasswordCellReuse";
    
    let cellTitles = ["First Name","Last Name","UserName","Email","Phone","Password"]
    let infoList = ["Daniel","Negreanu","DNeg","dneg@gmail.com","510-289-6877"]
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout);
        
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.backgroundColor = UIColor.white;
        self.delegate = self;
        self.dataSource = self;
        self.register(MoreInfoCollectionViewCell.self, forCellWithReuseIdentifier: moreInfoCell);
        self.register(PasswordCollectionViewCell.self, forCellWithReuseIdentifier: passwordInfoCell);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(indexPath.item < 5){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: moreInfoCell, for: indexPath) as! MoreInfoCollectionViewCell;
            cell.setTitleAndInfo(title: cellTitles[indexPath.item], info: infoList[indexPath.item])
            cell.index = indexPath.item;
            cell.selfDelegate = self;
            if(indexPath.item < 4){
                cell.infoField.returnKeyType = .next;
            }else{
                cell.infoField.returnKeyType = .done;
            }
            
            return cell;
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: passwordInfoCell, for: indexPath) as! PasswordCollectionViewCell
            return cell;
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width, height: 50);
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
}

extension MoreInfoCollectionView{
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let name = Notification.Name(rawValue: accountInfoFieldsResign);
        NotificationCenter.default.post(name: name, object: nil);
    }
    
    func nextField(index: Int) {
        let cell = self.cellForItem(at: IndexPath(item: index+1, section: 0)) as! MoreInfoCollectionViewCell;
        cell.infoField.becomeFirstResponder();
    }
    
}

protocol MoreInfoCollectionViewCellDelegate{
    func nextField(index: Int);
}

class MoreInfoCollectionViewCell: UICollectionViewCell, UITextFieldDelegate{
    
    var titleLabel: NormalUILabel = {
        let titleLabel = NormalUILabel(textColor: .darkText, font: .montserratSemiBold(fontSize: 14), textAlign: .left);
        titleLabel.text = "Name";
        return titleLabel;
    }()
    
    var infoField: NormalUITextField = {
        let infoField = NormalUITextField();
        infoField.translatesAutoresizingMaskIntoConstraints = false;
        infoField.font = UIFont.systemFont(ofSize: 16);
        infoField.text = "Daniel";
        infoField.spellCheckingType = .no;
        infoField.autocorrectionType = .no;
        return infoField;
    }()
    
    var border: UIView = {
        let border = UIView();
        border.translatesAutoresizingMaskIntoConstraints = false;
        border.backgroundColor = UIColor.veryLightGray;
        return border;
    }()
    
    var selfDelegate: MoreInfoCollectionViewCellDelegate?;
    
    var index: Int?{
        didSet{
            if(index == 3){
                self.infoField.keyboardType = .emailAddress;
            }
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = UIColor.white;
        addObservers();
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
    
    fileprivate func addObservers(){
        let name = Notification.Name(rawValue: accountInfoFieldsResign);
        NotificationCenter.default.addObserver(self, selector: #selector(self.resignInfoField), name: name, object: nil);
        
        let editButtonPressedName = Notification.Name(rawValue: accountInfoEditButtonPressed);
        NotificationCenter.default.addObserver(self, selector: #selector(self.setUserInteractionEnabled), name: editButtonPressedName, object: nil);
        
        let doneButtonPressedName = Notification.Name(rawValue: accountInfoDoneButtonPressed);
        NotificationCenter.default.addObserver(self, selector: #selector(self.setuUserInteractionDisabled), name: doneButtonPressedName, object: nil);
    }
    
    fileprivate func setupTitleLabel(){
        self.addSubview(titleLabel);
        titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true;
        titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true;
        titleLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true;
        titleLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true;
    }
    
    fileprivate func setupInfoField(){
        self.addSubview(infoField);
        infoField.leftAnchor.constraint(equalTo: self.titleLabel.rightAnchor).isActive = true;
        infoField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true;
        infoField.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true;
        infoField.heightAnchor.constraint(equalToConstant: 50).isActive = true;
        infoField.isUserInteractionEnabled = false;
        infoField.delegate = self;
    }
    
    fileprivate func setupBorder(){
        self.addSubview(border);
        border.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true;
        border.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true;
        border.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true;
        border.heightAnchor.constraint(equalToConstant: 0.4).isActive = true;
    }
    
    func setTitleAndInfo(title: String, info: String){
        self.titleLabel.text = "\(title):";
        self.infoField.text = info;
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let index = index{
            if(index < 4){
                //next line
                selfDelegate?.nextField(index: index);
            }else{
                let name = Notification.Name(rawValue: accountInfoFieldsResign);
                NotificationCenter.default.post(name: name, object: nil);
            }
        }
        return true;
    }
    
    @objc func resignInfoField(){
        self.infoField.resignFirstResponder();
    }
    
    @objc func setUserInteractionEnabled(){
        self.infoField.isUserInteractionEnabled = true;
    }
    
    @objc func setuUserInteractionDisabled(){
        self.infoField.isUserInteractionEnabled = false;
    }
    
}

class PasswordCollectionViewCell: UICollectionViewCell{
    
    var passwordButton: NormalUIButton = {
        let passwordButton = NormalUIButton(type: .system);
        passwordButton.translatesAutoresizingMaskIntoConstraints = false;
        passwordButton.setButtonProperties(backgroundColor: .white, title: "Change Password", font: .montserratSemiBold(fontSize: 15), fontColor: .darkText);
        return passwordButton;
    }()
    
    var border: UIView = {
        let border = UIView();
        border.translatesAutoresizingMaskIntoConstraints = false;
        border.backgroundColor = UIColor.veryLightGray;
        return border;
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = UIColor.white;
        setupPasswordTitleLabel();
        setupBorder();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setupPasswordTitleLabel(){
        self.addSubview(passwordButton);
        passwordButton.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true;
        passwordButton.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true;
        passwordButton.topAnchor.constraint(equalTo: self.topAnchor).isActive = true;
        passwordButton.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true;
    }
    
    fileprivate func setupBorder(){
        self.addSubview(border);
        border.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true;
        border.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true;
        border.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true;
        border.heightAnchor.constraint(equalToConstant: 0.4).isActive = true;
    }
    
}
