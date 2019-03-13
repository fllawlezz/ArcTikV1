//
//  ComposeMessageTableView.swift
//  ArcTikV1
//
//  Created by Brandon In on 2/2/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

class ComposeMessageTableView: UITableView, UITableViewDelegate, UITableViewDataSource{

    let cellReuse = "ComposeMessageTableViewReuse";
    
//    var selectedIndexPaths = [IndexPath]();
    var friendList = [Friend]();
    var selectedList = NSMutableDictionary();
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style);
        self.dataSource = self;
        self.delegate = self;
        self.backgroundColor = UIColor.white;
        self.separatorStyle = .none;
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.register(ComposeUserCell.self, forCellReuseIdentifier: cellReuse);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendList.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuse, for: indexPath) as! ComposeUserCell;
        let friend = friendList[indexPath.item];
        cell.setUserName(userName: friend.firstName!);
        if(friend.selected!){
            cell.checkMarkImage.isHidden = false;
        }else{
            cell.checkMarkImage.isHidden = true;
        }
        return cell;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! ComposeUserCell;
        //friend list is a class, so its a reference type
        let friend = friendList[indexPath.item];
        if(friend.selected!){
            
            
            selectedList.removeObject(forKey: "\(Int(friend.userID))")
            friend.selected = false;
            cell.checkMarkImage.isHidden = true;
            
        }else{
            
            selectedList.setValue(friend, forKey: "\(Int(friend.userID))")
            friend.selected = true;
            cell.checkMarkImage.isHidden = false;
        }
        
        
        
        tableView.deselectRow(at: indexPath, animated: true);
    }
    
}

extension ComposeMessageTableView{
    func getData()->NSMutableDictionary{
//        print(selectedList);
        return self.selectedList;
    }
}
