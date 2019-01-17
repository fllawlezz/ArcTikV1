//
//  TitlePage.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/17/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

class TitlePage: UIViewController, UITextViewDelegate{
    
    var titleLabel: NormalUILabel = {
        let titleLabel = NormalUILabel(textColor: .darkText, font: .montserratSemiBold(fontSize: 18), textAlign: .left);
        titleLabel.text = "Give your event a title";
        return titleLabel;
    }();
    
    var titleTextView: UITextView = {
        let titleTextView = UITextView();
        titleTextView.translatesAutoresizingMaskIntoConstraints = false;
        titleTextView.font = UIFont.systemFont(ofSize: 14);
        titleTextView.textColor = UIColor.darkText;
        titleTextView.layer.borderColor = UIColor.darkText.cgColor;
        titleTextView.layer.borderWidth = 1;
        return titleTextView;
    }()
    
    var wordCountLabel: NormalUILabel = {
        let wordCountLabel = NormalUILabel(textColor: .darkText, font: .montserratSemiBold(fontSize: 14), textAlign: .right);
        wordCountLabel.text = "0/65";
        return wordCountLabel;
    }()
    
    var nextButton: NormalUIButton = {
        let nextButton = NormalUIButton(type: .system);
        nextButton.setButtonProperties(backgroundColor: .appBlue, title: "Next", font: .montserratSemiBold(fontSize: 14), fontColor: .white);
        return nextButton;
    }()
    
    var wordCount = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.view.backgroundColor = UIColor.white;
        setupNavBar();
        setupTitleLabel();
        setupTextView();
        setupWordCount();
        setupNextButton();
        
        self.titleTextView.becomeFirstResponder();
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
        self.view.addSubview(titleTextView);
        titleTextView.anchor(left: self.titleLabel.leftAnchor, right: self.titleLabel.rightAnchor, top: self.titleLabel.bottomAnchor, bottom: nil, constantLeft: 0, constantRight: 0, constantTop: 10, constantBottom: 0, width: 0, height: 50);
        titleTextView.delegate = self;
    }
    
    fileprivate func setupWordCount(){
        self.view.addSubview(wordCountLabel);
        wordCountLabel.anchor(left: nil, right: self.titleTextView.rightAnchor, top: self.titleTextView.bottomAnchor, bottom: nil, constantLeft: 0, constantRight: 0, constantTop: 5, constantBottom: 0, width: 50, height: 20);
    }
    
    fileprivate func setupNextButton(){
        self.view.addSubview(nextButton);
        nextButton.anchor(left: nil, right: self.titleTextView.rightAnchor, top: self.wordCountLabel.bottomAnchor, bottom: nil, constantLeft: 0, constantRight: 0, constantTop: 10, constantBottom: 0, width: 100, height: 40);
        nextButton.addTarget(self, action: #selector(self.handleNextButtonPressed), for: .touchUpInside);
    }
    
}
extension TitlePage{
    func textViewDidChange(_ textView: UITextView) {
        wordCount = textView.text.count;
        self.wordCountLabel.text = "\(wordCount)/65"
        
        if(wordCount == 65){
            self.wordCountLabel.textColor = UIColor.red;
        }else if(wordCount < 65){
            self.wordCountLabel.textColor = UIColor.darkText;
        }else if(wordCount > 65){
            wordCount = 65;
            self.wordCountLabel.text = "\(wordCount)/65"
            
            let currentText = textView.text;
            let newText = currentText?.dropLast();
            titleTextView.text = String(newText!);
        }
    }
    
    @objc func handleClearPressed(){
        self.dismiss(animated: true, completion: nil);
        //        self.navigationController?.dismiss(animated: true, completion: nil);
    }
    
    @objc func handleNextButtonPressed(){
        let descriptionPage = DescriptionPage();
        self.navigationController?.pushViewController(descriptionPage, animated: true);
    }
}
