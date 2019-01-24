//
//  CreatedEventsInProgressCell.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/17/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

protocol CreatedEventsInProgressCellDelegate{
    
    func handleLongPress(indexPath: IndexPath);
    
}

class CreatedEventsInProgressCell: UICollectionViewCell{
    
    var eventTitleLabel: NormalUILabel = {
        let eventTitleLabel = NormalUILabel(textColor: .darkText, font: .montserratSemiBold(fontSize: 14), textAlign: .left);
        return eventTitleLabel;
    }()
    
    var borderTop = BorderView();
    
    var stepsCounterLabel: NormalUILabel = {
        let stepsCounterLabel = NormalUILabel(textColor: .darkText, font: .montserratMedium(fontSize: 12), textAlign: .left);
        stepsCounterLabel.text = "Steps: 1/8";
//        stepsCounterLabel.backgroundColor = UIColor.blue;
        return stepsCounterLabel;
    }()
    
    var instructionsLabel: NormalUILabel = {
        let instructionsLabel = NormalUILabel(textColor: .gray, font: .montserratMedium(fontSize: 12), textAlign: .right);
        instructionsLabel.text = "Continue setting up your event"
        return instructionsLabel;
    }()
    
    var rightArrowImageView: UIImageView = {
        let rightArrowImageView = UIImageView(image: #imageLiteral(resourceName: "rightArrow"));
        rightArrowImageView.translatesAutoresizingMaskIntoConstraints = false;
        rightArrowImageView.contentMode = .scaleAspectFill;
        rightArrowImageView.alpha = 0.8;
        return rightArrowImageView;
    }()
    
    var delegate: CreatedEventsInProgressCellDelegate?;
    var indexPath: IndexPath?;
    var eventID: Int?;
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = UIColor.white;
        self.layer.borderColor = UIColor.veryLightGray.cgColor;
        self.layer.borderWidth = 0.4;
        self.isUserInteractionEnabled = true;
        self.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(self.handleLongPress)));
        setupEventTitleLabel();
        setupBorderTop();
        setupInstructionsLabel();
        setupStepCounter();
        setupRightArrow();
        addObservers();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self);
    }
    
    fileprivate func addObservers(){
        let name = Notification.Name(rawValue: overviewPageUpdateIndexPath);
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateIndexPath(notification:)), name: name, object: nil);
    }
    
    @objc func updateIndexPath(notification:NSNotification){
        if let userInfo = notification.userInfo{
            let compareIndexPath = userInfo["indexPath"] as! IndexPath
            if(self.indexPath!.item > compareIndexPath.item){
                let newIndexPath = IndexPath(item: self.indexPath!.item - 1, section: self.indexPath!.section);
                self.indexPath = newIndexPath;
            }
        }
    }
    
    fileprivate func setupEventTitleLabel(){
        self.addSubview(eventTitleLabel);
        eventTitleLabel.anchor(left: self.leftAnchor, right: self.rightAnchor, top: self.topAnchor, bottom: nil, constantLeft: 10, constantRight: -10, constantTop: 15, constantBottom: 0, width: 0, height: 30);
    }
    
    fileprivate func setupBorderTop(){
        self.addSubview(borderTop);
        borderTop.anchor(left: self.leftAnchor, right: self.rightAnchor, top: nil, bottom: self.bottomAnchor, constantLeft: 0, constantRight: 0, constantTop: 0, constantBottom: -40, width: 0, height: 0.4);
        
    }
    
    fileprivate func setupInstructionsLabel(){
        self.addSubview(instructionsLabel);
        instructionsLabel.anchor(left: nil, right: self.rightAnchor, top: borderTop.bottomAnchor, bottom: self.bottomAnchor, constantLeft: 0, constantRight: -20, constantTop: 0, constantBottom: 0, width: 175, height: 0);
    }
    
    fileprivate func setupStepCounter(){
        self.addSubview(stepsCounterLabel);
        stepsCounterLabel.anchor(left: self.leftAnchor, right: nil, top: borderTop.bottomAnchor, bottom: self.bottomAnchor, constantLeft: 10, constantRight: 0, constantTop: 0, constantBottom: 0, width: 75, height: 0);
    }
    
    fileprivate func setupRightArrow(){
        self.addSubview(rightArrowImageView);
        rightArrowImageView.anchor(left: nil, right: self.rightAnchor, top: nil, bottom: nil, constantLeft: 0, constantRight: -10, constantTop: 0, constantBottom: 0, width: 20, height: 20);
        rightArrowImageView.centerYAnchor.constraint(equalTo: self.eventTitleLabel.centerYAnchor).isActive = true
//        rightArrowImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true;
    }
    
    @objc func handleLongPress(g: UIGestureRecognizer){
        if let indexPath = self.indexPath{
            if(g.state == .began){
//                print("long press");
                delegate?.handleLongPress(indexPath: indexPath);
                
            }
        }
        
        
    }
    
    func setSteps(stepNumber: Int){
        let readableStepNumber = stepNumber + 1;
        self.stepsCounterLabel.text = "Steps: \(readableStepNumber)/10";
    }
    
    func setTitle(title:String){
        self.eventTitleLabel.text = title;
    }
}
