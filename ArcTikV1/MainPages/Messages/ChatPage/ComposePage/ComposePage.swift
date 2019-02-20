//
//  ComposePage.swift
//  ArcTikV1
//
//  Created by Brandon In on 2/3/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

let dismissComposePage = "DismissComposePage";

protocol ComposePageDelegate{
    func handlePeopleSelected(selectedList: NSMutableDictionary);
}

class ComposePage: UIViewController{
    
    var composeMessageTableView: ComposeMessageTableView = {
        let composeMessageTableView = ComposeMessageTableView();
        return composeMessageTableView;
    }()
    
    var delegate: ComposePageDelegate?;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.view.backgroundColor = UIColor.white;
        setupNavBar();
        setupComposeMessage();
    }
    
    fileprivate func setupNavBar(){
        let leftBarButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.handleCancelPressed));
        self.navigationItem.leftBarButtonItem = leftBarButton;
        
        let okButton = UIBarButtonItem(title: "Ok", style: .plain, target: self, action: #selector(self.handleOkPressed));
        self.navigationItem.rightBarButtonItem = okButton;
        
        self.navigationItem.title = "Select People";
    }
    
    fileprivate func setupComposeMessage(){
        self.view.addSubview(composeMessageTableView);
        composeMessageTableView.anchor(left: self.view.leftAnchor, right: self.view.rightAnchor, top: self.view.topAnchor, bottom: self.view.safeAreaLayoutGuide.bottomAnchor, constantLeft: 0, constantRight: 0, constantTop: 0, constantBottom: 0, width: 0, height: 0);
    }
    
}

extension ComposePage{
    @objc func handleCancelPressed(){
//        self.dismiss(animated: true, completion: nil);
        let name = Notification.Name(rawValue: dismissComposePage);
        NotificationCenter.default.post(name: name, object: nil);
    }
    
    @objc func handleOkPressed(){
        let selectedList = composeMessageTableView.getData();
        if(selectedList.count > 0){
            delegate?.handlePeopleSelected(selectedList: selectedList);
            self.dismiss(animated: true , completion: nil);
        }else{
            self.showNoneSelected();
        }
    }
    
    func showNoneSelected(){
        let alert = UIAlertController(title: "Ugh-Oh", message: "You didn't select any people to send your message to! Select some!", preferredStyle: .alert);
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil));
        self.present(alert, animated: true, completion: nil);
    }
}
