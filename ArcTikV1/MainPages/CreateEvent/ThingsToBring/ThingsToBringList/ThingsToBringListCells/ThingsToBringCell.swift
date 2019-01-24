//
//  ThingsToBringCell.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/19/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

protocol ThingsToBringCellDelegate{
    func deleteCellAt(indexPath: IndexPath);
}

class ThingsToBringCell: RequirementsPageListCell{
    
    var thingsDelegate:ThingsToBringCellDelegate?;
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        addObservers();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    func setupThingsGesture(){
        self.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(handleLongHold)))
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self);
    }
    
    fileprivate func addObservers(){
        let name = Notification.Name(rawValue: updateThingsToBringIndex);
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateThingsIndexPath(notification:)), name: name, object: nil);
    }
    
    @objc func handleLongHold(){
        self.thingsDelegate?.deleteCellAt(indexPath: self.indexPath!);
    }
    
    @objc func updateThingsIndexPath(notification: NSNotification){
        if let userInfo = notification.userInfo{
            let compareIndexPath = userInfo["indexPath"] as! IndexPath;
            if(self.indexPath!.item > compareIndexPath.item){
                let newIndexPath = IndexPath(item: self.indexPath!.item - 1, section: self.indexPath!.section);
                self.indexPath = newIndexPath;
            }
        }
    }
    
}
