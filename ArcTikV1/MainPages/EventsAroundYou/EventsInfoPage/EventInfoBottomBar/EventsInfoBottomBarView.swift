//
//  EventsInfoBottomBarView.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/15/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

class EventsInfoBottomBarView: UIView {
    
    var borderTop = BorderView();
    
    var applyButton: NormalUIButton = {
        let applyButton = NormalUIButton(type: .system);
        applyButton.setButtonProperties(backgroundColor: .appBlue, title: "Apply", font: .montserratSemiBold(fontSize: 14), fontColor: .white);
        return applyButton;
    }()
    
    var peopleView: EventsInfoBottomBarPeopleView = {
        let peopleView = EventsInfoBottomBarPeopleView();
        return peopleView;
    }()
    
    var costView: EventsInfoBottomBarCostView = {
        let costView = EventsInfoBottomBarCostView();
        return costView;
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.backgroundColor = UIColor.white;
        self.layer.shadowColor = UIColor.darkText.cgColor;
        self.layer.shadowOffset = CGSize(width: 2, height: -0.5);
        self.layer.shadowRadius = 1;
        self.layer.shadowOpacity = 0.2;
//        setupBorderTop();
        setupApplyButton();
        setupPeople();
        setupCost();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setupBorderTop(){
        self.addSubview(borderTop);
        borderTop.anchor(left: self.leftAnchor, right: self.rightAnchor, top: self.topAnchor, bottom: nil, constantLeft: 0, constantRight: 0, constantTop: 0, constantBottom: 0, width: 0, height: 0.4);
    }
    
    fileprivate func setupApplyButton(){
        self.addSubview(applyButton);
        applyButton.anchor(left: nil, right: self.rightAnchor, top: nil, bottom: nil, constantLeft: 0, constantRight: -10, constantTop: 10, constantBottom: -10, width: 150, height: 40);
        applyButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true;
    }
    
    fileprivate func setupPeople(){
        self.addSubview(peopleView);
        peopleView.anchor(left: self.leftAnchor, right: nil, top: nil, bottom: nil, constantLeft: 25, constantRight: 0, constantTop: 0, constantBottom: 0, width: 0, height: 60);
        peopleView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true;
    }
    fileprivate func setupCost(){
        self.addSubview(costView);
        costView.anchor(left: self.peopleView.rightAnchor, right: nil, top: nil, bottom: nil, constantLeft: 50, constantRight: 0, constantTop: 0, constantBottom: 0, width: 0, height: 60);
        costView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true;
    }
    
    func setPeople(currentPeople: Int, people: Int){
        self.peopleView.setText(numberOfPeople: "\(currentPeople)/\(people)")
    }
    
    func setCost(cost: Double){
        if(cost != 0){
            let costString = String(format: "%.2f", cost);
            self.costView.costLabel.text = "$\(costString)"
        }else{
            self.costView.costLabel.text = "Free";
        }
    }
}
