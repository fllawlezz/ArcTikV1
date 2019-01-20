//
//  PricingPage.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/11/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

class PricingPage: UIViewController, UITextFieldDelegate{
    
    var titleLabel: NormalUILabel = {
        let titleLabel = NormalUILabel(textColor: .darkText, font: .montserratSemiBold(fontSize: 18), textAlign: .left);
        titleLabel.text = "How much do you want charge?";
        titleLabel.numberOfLines = 2;
//        titleLabel.backgroundColor = UIColor.red;
        return titleLabel;
    }()
    
    var chargeField: NormalUITextField = {
        let chargeInfoField = NormalUITextField();
        chargeInfoField.translatesAutoresizingMaskIntoConstraints = false;
        chargeInfoField.font = UIFont.systemFont(ofSize: 14);
        chargeInfoField.textColor = UIColor.darkText;
        chargeInfoField.placeholder = "eg: $1"
        chargeInfoField.keyboardType = .decimalPad;
//        chargeInfoField.backgroundColor = UIColor.blue;
        return chargeInfoField;
    }()
    
    var chargeFieldBorder: UIView = {
        let chargeFieldBorder = UIView();
        chargeFieldBorder.translatesAutoresizingMaskIntoConstraints = false;
        chargeFieldBorder.backgroundColor = UIColor.lightGray;
        return chargeFieldBorder;
    }()
    
    var nextButton: NormalUIButton = {
        let nextButton = NormalUIButton(type: .system);
        nextButton.setButtonProperties(backgroundColor: .appBlue, title: "Next", font: .montserratSemiBold(fontSize: 14), fontColor: .white)
        return nextButton;
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.view.backgroundColor = UIColor.white;
        setCurrentEventData();
        setupNavBar();
        setupTitleLabel();
        setupChargeField();
        setupBorder();
        setupNextButton();
        self.chargeField.becomeFirstResponder();
    }
    
    fileprivate func setCurrentEventData(){
        currentEvent?.stepNumber = 6;
        let name = Notification.Name(rawValue: reloadCreateEventPage);
        NotificationCenter.default.post(name: name, object: nil);
    }
    
    fileprivate func setupNavBar(){
        let clearButton = UIBarButtonItem(image: UIImage(named: "clearWhiteNav"), style: .plain, target: self, action: #selector(self.handleClearPressed));
        self.navigationItem.leftBarButtonItem = clearButton;
    }
    
    fileprivate func setupTitleLabel(){
        self.view.addSubview(titleLabel);
        titleLabel.anchor(left: self.view.leftAnchor, right: self.view.rightAnchor, top: self.view.topAnchor, bottom: nil, constantLeft: 25, constantRight: -25, constantTop: 10, constantBottom: 0, width: 0, height: 70);
    }
    
    fileprivate func setupChargeField(){
        self.view.addSubview(chargeField);
        chargeField.anchor(left: self.titleLabel.leftAnchor, right: self.titleLabel.rightAnchor, top: self.titleLabel.bottomAnchor, bottom: nil, constantLeft: 0, constantRight: 0, constantTop: 0, constantBottom: 0, width: 0, height: 50);
        chargeField.delegate = self;
        chargeField.addTarget(self, action: #selector(infoFieldDataChanged), for: .editingChanged);
        
    }
    
    fileprivate func setupNextButton(){
        self.view.addSubview(nextButton)
        nextButton.anchor(left: nil, right: self.view.rightAnchor, top: self.chargeFieldBorder.bottomAnchor, bottom: nil, constantLeft: 0, constantRight: -25, constantTop: 15, constantBottom: 0, width: 100, height: 40)
        nextButton.addTarget(self, action: #selector(self.handleNextButtonPressed), for: .touchUpInside);
    }
    
    fileprivate func setupBorder(){
        self.view.addSubview(chargeFieldBorder);
        chargeFieldBorder.anchor(left: self.titleLabel.leftAnchor, right: self.view.rightAnchor, top: self.chargeField.bottomAnchor, bottom: nil, constantLeft: 0, constantRight: 0, constantTop: 10, constantBottom: 0, width: 0, height: 0.4);
    }
    
}

extension PricingPage{
    @objc func infoFieldDataChanged(){
        let originalText = chargeField.text!.replacingOccurrences(of: "$", with: "");
        self.chargeField.text = "$\(originalText)"
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
    
    @objc func handleNextButtonPressed(){
//        let uploadImagesPage = UploadImagesPage();
        if((self.chargeField.text?.count)! < 2){
            //show error alert
        }else{
            let noDollarSignText = chargeField.text?.replacingOccurrences(of: "$", with: "");
            let chargeInt = Double(noDollarSignText!);
            currentEvent?.charge = chargeInt;
            
            let thingsToBringPage = ThingsToBringPage();
            self.navigationController?.pushViewController(thingsToBringPage, animated: true);
        }
        
        
    }
}
