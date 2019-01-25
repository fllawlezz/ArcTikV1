//
//  TitlePage.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/17/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class TitlePage: UIViewController, UITextViewDelegate, NVActivityIndicatorViewable{
    
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
    
    let dispatch = DispatchGroup();
    var eventID: Int?;
    var wordCount = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.view.backgroundColor = UIColor.white;
        setCurrentData();
        setupNavBar();
        setupTitleLabel();
        setupTextView();
        setupWordCount();
        setupNextButton();
        
        self.titleTextView.becomeFirstResponder();
    }
    
    fileprivate func setCurrentData(){
//        if let titleString = currentEvent?.eventTitle{
//            self.titleTextView.text = titleString;
//        }
        
        if let titleString = currentEventInProgress?.title{
            self.titleTextView.text = titleString;
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
        self.showLoadingView()
        if(titleTextView.text.count > 0){
//            currentEvent?.eventTitle = titleTextView.text;
            currentEventInProgress?.title = titleTextView.text!;
            
            if(currentEventInProgress == nil){
                
                let errorExists = createEventOnServer();

                if(!errorExists){
                    self.stopAnimating();
                    createAndSaveEvent();
                    let descriptionPage = DescriptionPage();
                    self.navigationController?.pushViewController(descriptionPage, animated: true);
                }else{
                    self.stopAnimating();
                    self.showServerAlert();
                }
                
                
            }
        }else{
            self.showEmptyAlert();
        }
        
    }
    
    func createEventOnServer() -> Bool{
        
        var errorExists = false;
        let url = URL(string: "http://localhost:3000/startCreateEvent")!;
//        let url = URL(string: "http://arctikllc.com:3000/startCreateEvent")!;
        var request = URLRequest(url: url);
        let requestBody = "userID=\(user!.userID)"
        request.httpMethod = "POST";
        request.httpBody = requestBody.data(using: .utf8);
        request.timeoutInterval = 10;
        let dataTask = URLSession.shared.dataTask(with: request) { (data, res, err) in
            if(err != nil){
                errorExists = true;
                self.dispatch.leave();
                
            }else{
                if(data != nil){
                    let response = NSString(data: data!, encoding: 8);
                    self.eventID = Int(response! as String);
                    self.dispatch.leave();
                }
            }
            
            
        }
        
        self.dispatch.enter();
        dataTask.resume();
        self.dispatch.wait();
        
        return errorExists;
        
    }
    
    func createAndSaveEvent(){
        let inProgressEvent = EventInProgress(context: PersistenceManager.shared.context);
        inProgressEvent.step = 1;
        inProgressEvent.hosterID = Int16(user!.userID)
        //set eventID
        inProgressEvent.eventID = Int16(self.eventID!)
        inProgressEvent.price = 0;
        inProgressEvent.people = 2;
        inProgressEvent.title = titleTextView.text!;
        inProgressEvent.hosterID = Int16(user!.userID);
        PersistenceManager.shared.save();
        
        currentEventInProgress = inProgressEvent;
        
        let createEventName = Notification.Name(rawValue: reloadCreateEventPage);
        NotificationCenter.default.post(name: createEventName, object: nil);
        
        let reloadName = Notification.Name(rawValue: reloadOverViewPage);
        NotificationCenter.default.post(name: reloadName, object: nil);
    }
    func showLoadingView(){
        let size = CGSize(width: 50, height: 50)
        self.startAnimating(size, message: "Loading", messageFont: UIFont.montserratSemiBold(fontSize: 14), type: NVActivityIndicatorType.circleStrokeSpin, color: UIColor.white, padding: 0, displayTimeThreshold: 20, minimumDisplayTime: 1, backgroundColor: UIColor.black.withAlphaComponent(0.5), textColor: UIColor.white, fadeInAnimation: nil);
    }
    
    fileprivate func showEmptyAlert(){
        let alert = UIAlertController(title: "Oops!", message: "You didn't fill out the title field!", preferredStyle: .alert);
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil));
        self.present(alert, animated: true, completion: nil);
    }
    
    fileprivate func showServerAlert(){
        let alert = UIAlertController(title: "Oops!", message: "There was a problem submitting your title! Try again later!", preferredStyle: .alert);
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            
            let userInfo = ["failed":true];
            
            let notification = Notification.Name(rawValue: dismissCreateEventPage);
            NotificationCenter.default.post(name: notification, object: nil, userInfo: userInfo);
        }))
        self.present(alert, animated: true, completion: nil);
    }
}
