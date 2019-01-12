//
//  RequirementsPage.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/10/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

class RequirementsPage: UIViewController{
    
    var titleLabel: NormalUILabel = {
        let titleLabel = NormalUILabel(textColor: .darkText, font: .montserratSemiBold(fontSize: 18), textAlign: .left);
        titleLabel.text = "What are the requirements for people?";
        return titleLabel;
    }()
    
    var requirementsTextView: UITextView = {
        let requirementsTextView = UITextView();
        requirementsTextView.translatesAutoresizingMaskIntoConstraints = false;
        requirementsTextView.font = UIFont.systemFont(ofSize: 14);
        requirementsTextView.layer.borderColor = UIColor.darkText.cgColor;
        requirementsTextView.layer.borderWidth = 1;
        requirementsTextView.layer.cornerRadius = 5;
        return requirementsTextView;
    }()
    
    var descriptionLabel: NormalUILabel = {
        let descriptionLabel = NormalUILabel(textColor: .lightGray, font: .montserratSemiBold(fontSize: 14), textAlign: .left);
        descriptionLabel.text = "List Requirements";
//        descriptionLabel.backgroundColor = UIColor.red;
        return descriptionLabel;
    }()
    
    var nextButton: NormalUIButton = {
        let nextButton = NormalUIButton(type: .system);
        nextButton.setButtonProperties(backgroundColor: .appBlue, title: "Next", font: .montserratSemiBold(fontSize: 14), fontColor: .white);
        return nextButton;
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.view.backgroundColor = UIColor.white;
        setupNavBar();
        setupTitleLabel();
        setupTextView()
        setupDescription();
        setupNextButton();
        
        self.requirementsTextView.becomeFirstResponder();
    }
    
    fileprivate func setupNavBar(){
        let clearButton = UIBarButtonItem(image: UIImage(named: "clearWhiteNav"), style: .plain, target: self, action: #selector(self.handleClearPressed));
        self.navigationItem.leftBarButtonItem = clearButton;
    }
    
    fileprivate func setupTitleLabel(){
        self.view.addSubview(titleLabel);
        titleLabel.anchor(left: self.view.leftAnchor, right: self.view.rightAnchor, top: self.view.topAnchor, bottom: nil, constantLeft: 25, constantRight: -25, constantTop: 10, constantBottom: 0, width: 0, height: 70);
    }
    
    fileprivate func setupTextView(){
        self.view.addSubview(requirementsTextView);
        requirementsTextView.anchor(left: self.titleLabel.leftAnchor, right: self.titleLabel.rightAnchor, top: self.titleLabel.bottomAnchor, bottom: nil, constantLeft: 0, constantRight: 0, constantTop: 5, constantBottom: 0, width: 0, height: 150);
    }
    
    fileprivate func setupDescription(){
        self.view.addSubview(descriptionLabel);
        descriptionLabel.anchor(left: self.requirementsTextView.leftAnchor, right: nil, top: self.requirementsTextView.bottomAnchor, bottom: nil, constantLeft: 0, constantRight: 0, constantTop: 5, constantBottom: 0, width: 100, height: 30);
    }
    
    fileprivate func setupNextButton(){
        self.view.addSubview(nextButton);
        nextButton.anchor(left: nil, right: self.requirementsTextView.rightAnchor, top: self.descriptionLabel.bottomAnchor, bottom: nil, constantLeft: 0, constantRight: 0, constantTop: 5, constantBottom: 0, width: 100, height: 40);
        nextButton.addTarget(self, action: #selector(self.handleNextButtonPressed), for: .touchUpInside);
    }
    
}

extension RequirementsPage{
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
        let layout = UICollectionViewFlowLayout();
        let privacyPage = PrivacyPage(collectionViewLayout: layout);
        self.navigationController?.pushViewController(privacyPage, animated: true);
    }
}
