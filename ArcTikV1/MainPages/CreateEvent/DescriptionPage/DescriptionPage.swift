//
//  DescriptionPage.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/10/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

class DescriptionPage: UIViewController, UITextViewDelegate{
    
    var titleLabel: NormalUILabel = {
        let titleLabel = NormalUILabel(textColor: .darkText, font: .montserratSemiBold(fontSize: 18), textAlign: .left);
        titleLabel.text = "Give a short description of your event";
        return titleLabel;
    }();
    
    var descriptionTextView: UITextView = {
        let descriptionTextView = UITextView();
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false;
        descriptionTextView.font = UIFont.systemFont(ofSize: 14);
        descriptionTextView.textColor = UIColor.darkText;
        descriptionTextView.layer.borderColor = UIColor.darkText.cgColor;
        descriptionTextView.layer.borderWidth = 1;
        return descriptionTextView;
    }()
    
    var nextButton: NormalUIButton = {
        let nextButton = NormalUIButton(type: .system);
        nextButton.setButtonProperties(backgroundColor: .appBlue, title: "Next", font: .montserratSemiBold(fontSize: 14), fontColor: .white);
        return nextButton;
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.view.backgroundColor = UIColor.white;
        setCurrentEventData();
        setupNavBar();
        setupTitleLabel();
        setupTextView();
        setupNextButton();
        
        self.descriptionTextView.becomeFirstResponder();
    }
    
    fileprivate func setCurrentEventData(){
        currentEvent?.stepNumber = 1;
        let name = Notification.Name(rawValue: reloadCreateEventPage);
        NotificationCenter.default.post(name: name, object: nil);
        
        if let description = currentEvent?.description{
            self.descriptionTextView.text = description;
        }
    }
    
    fileprivate func setupNavBar(){
        let clearButton = UIBarButtonItem(image: UIImage(named: "clearWhiteNav"), style: .plain, target: self, action: #selector(self.handleClearPressed));
        self.navigationItem.leftBarButtonItem = clearButton;
    }
    
    fileprivate func setupTitleLabel(){
        self.view.addSubview(titleLabel);
        titleLabel.anchor(left: self.view.leftAnchor, right: self.view.rightAnchor, top: self.view.safeAreaLayoutGuide.topAnchor, bottom: nil, constantLeft: 25, constantRight: -25, constantTop: 10, constantBottom: 0, width: 0, height: 50);
    }
    
    fileprivate func setupTextView(){
        self.view.addSubview(descriptionTextView);
        descriptionTextView.anchor(left: self.titleLabel.leftAnchor, right: self.titleLabel.rightAnchor, top: self.titleLabel.bottomAnchor, bottom: nil, constantLeft: 0, constantRight: 0, constantTop: 10, constantBottom: 0, width: 0, height: 200);
        descriptionTextView.delegate = self;
    }
    
    fileprivate func setupNextButton(){
        self.view.addSubview(nextButton);
        nextButton.anchor(left: nil, right: self.descriptionTextView.rightAnchor, top: self.descriptionTextView.bottomAnchor, bottom: nil, constantLeft: 0, constantRight: 0, constantTop: 10, constantBottom: 0, width: 100, height: 40);
        nextButton.addTarget(self, action: #selector(self.handleNextButtonPressed), for: .touchUpInside);
    }
    
}

extension DescriptionPage{
//    func textViewDidChange(_ textView: UITextView) {
//        wordCount = textView.text.count;
//        self.wordCountLabel.text = "\(wordCount)/225"
//
//        if(wordCount == 225){
//            self.wordCountLabel.textColor = UIColor.red;
//        }else if(wordCount < 225){
//            self.wordCountLabel.textColor = UIColor.darkText;
//        }else if(wordCount > 225){
//            wordCount = 225;
//            self.wordCountLabel.text = "\(wordCount)/225"
//
//            let currentText = textView.text;
//            let newText = currentText?.dropLast();
//            descriptionTextView.text = String(newText!);
//        }
//    }
}

extension DescriptionPage{
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
        if(descriptionTextView.text.count > 0){
            currentEvent?.description = self.descriptionTextView.text!;
            
            let layout = UICollectionViewFlowLayout();
            let locationPage = LocationPage(collectionViewLayout: layout);
            self.navigationController?.pushViewController(locationPage, animated: true);
        }else{
            self.showEmptyAlert();
        }
    }
    
    fileprivate func showEmptyAlert(){
        let alert = UIAlertController(title: "Oops!", message: "You didn't fill out the description field!", preferredStyle: .alert);
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil));
        self.present(alert, animated: true, completion: nil);
    }
}
