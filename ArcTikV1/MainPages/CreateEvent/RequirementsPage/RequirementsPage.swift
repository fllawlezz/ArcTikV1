//
//  RequirementsPage.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/10/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

class RequirementsPage: UIViewController, RequirementsPageListCellDelegate{
    
    var requirementsListView: RequirementsTableView = {
        let requirementsListView = RequirementsTableView(frame: .zero);
        requirementsListView.translatesAutoresizingMaskIntoConstraints = false;
        return requirementsListView;
        
    }()
    
    var nextButton: NormalUIButton = {
        let nextButton = NormalUIButton(type: .system);
        nextButton.setButtonProperties(backgroundColor: .appBlue, title: "Next", font: .montserratSemiBold(fontSize: 14), fontColor: .white);
        return nextButton;
    }()
    
    var plusButton: UIBarButtonItem?;
    
    var fromEventsInfo: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad();
        setCurrentEventData();
        self.view.backgroundColor = UIColor.white;
        setupRequirementsList();
        setupNavBar();
        if(!fromEventsInfo){
            setupNextButton();
        }
    }
    
    fileprivate func setCurrentEventData(){
        currentEvent?.stepNumber = 3;
        let name = Notification.Name(rawValue: reloadCreateEventPage);
        NotificationCenter.default.post(name: name, object: nil);
    }
    
    fileprivate func setupNavBar(){
        let clearButton = UIBarButtonItem(image: UIImage(named: "clearWhiteNav"), style: .plain, target: self, action: #selector(self.handleClearPressed));
        self.navigationItem.leftBarButtonItem = clearButton;
        if(!fromEventsInfo){
            plusButton = UIBarButtonItem(image: UIImage(named: "whitePlus"), style: .plain, target: self, action: #selector(self.handleAddButtonPressed));
            self.navigationItem.rightBarButtonItem = plusButton;
        }
    }
    
    fileprivate func setupRequirementsList(){
        self.view.addSubview(requirementsListView);
        requirementsListView.anchor(left: self.view.leftAnchor, right: self.view.rightAnchor, top: self.view.topAnchor, bottom: self.view.safeAreaLayoutGuide.bottomAnchor, constantLeft: 0, constantRight: 0, constantTop: 0, constantBottom: 0, width: 0, height: 0);
        requirementsListView.requirementsPage = self
    }
    
    fileprivate func setupNextButton(){
        self.view.addSubview(nextButton);
        nextButton.anchor(left: nil, right: self.view.rightAnchor, top: nil, bottom: self.view.bottomAnchor, constantLeft: 0, constantRight: -25, constantTop: 0, constantBottom: -25, width: 100, height: 40);
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
        currentEvent?.requirements = self.requirementsListView.requirementsList;
        
        let layout = UICollectionViewFlowLayout();
        let privacyPage = PrivacyPage(collectionViewLayout: layout);
        self.navigationController?.pushViewController(privacyPage, animated: true);
    }
    
    
    @objc func handleAddButtonPressed() {
        //handle add button pressed
        if(self.requirementsListView.requirementsList.count < 10){
            let alert = UIAlertController(title: "Enter a requirement", message: "Enter a requirement for any applicants", preferredStyle: .alert);
            alert.addTextField { (textField) in
                textField.placeholder = "Requirement";
            }
            alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { (action) in
                //check for the length and append to the requirements list
                let textField = alert.textFields?[0]
                if(textField!.text!.count > 0){
//                    requirementsList.append(textField!.text!);
                    self.requirementsListView.requirementsList.append(textField!.text!);
                    print(self.requirementsListView.requirementsList.count);
                    if(self.requirementsListView.requirementsList.count > 1){//there were 0 before and now there is 1 item in the list, so reload
                        self.requirementsListView.insertRows(at: [IndexPath(item: self.requirementsListView.requirementsList.count-1, section: 0)], with: .fade);
                        print("inserted rows");
                    }else{
                        self.requirementsListView.reloadData();
                    }
                }
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil));
            self.present(alert, animated: true, completion: nil);
        }else{
            let name = Notification.Name(rawValue: requirementsPageMaximumReach);
            NotificationCenter.default.post(name: name, object: nil);
        }
    }
    
    func deleteCellAt(indexPath: IndexPath) {
        if(!fromEventsInfo){
            let alert = UIAlertController(title: "Delete Requirement?", message: "Are you sure you want to delete this requirement?", preferredStyle: .alert);
            alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { (action) in
                self.requirementsListView.requirementsList.remove(at: indexPath.item);
                if(self.requirementsListView.requirementsList.count > 0){
                    self.requirementsListView.deleteRows(at: [indexPath], with: .fade);
                }else{
                    self.requirementsListView.reloadData();
                }
            }))
            alert.addAction(UIAlertAction(title: "No", style: .default, handler: nil));
            self.present(alert, animated: true, completion: nil);
        }
        
    }
    
}
