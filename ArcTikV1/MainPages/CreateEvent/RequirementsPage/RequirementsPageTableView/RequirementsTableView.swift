//
//  RequirementsTableView.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/18/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

class RequirementsTableView: UITableView, UITableViewDelegate, UITableViewDataSource {

    let reuseCell = "RequirementsPageListCell";
    let headerCell = "RequirementsPageHeaderReuse";
    let emptyCell = "RequirementsEmptyCell";
    
    var requirementsList = [String]();
    var requirementsPage: RequirementsPage?;
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style);
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = UIColor.white;
        self.separatorStyle = .none;
        self.register(RequirementsPageListCell.self, forCellReuseIdentifier: reuseCell);
        self.register(RequirementsEmptyCell.self, forCellReuseIdentifier: emptyCell);
        self.register(RequirementsPageTitleHeader.self, forHeaderFooterViewReuseIdentifier: headerCell);
        getData();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func getData(){
        if let event = currentEventInProgress{
            if(event.requirements != nil){
                let eventData = NSKeyedUnarchiver.unarchiveObject(with: event.requirements! as Data) as! [String];
                if(eventData.count > 0){
                    self.requirementsList = eventData;
                    self.reloadData();
                }
            }
        }
    }
    
    override var numberOfSections: Int{
        return 1;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(requirementsList.count > 0){
            //            print("requirements Cell dequeed");
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseCell, for: indexPath) as! RequirementsPageListCell;
            cell.delegate = self.requirementsPage;
            cell.indexPath = indexPath;
            cell.setupRequirementGestureRecognizer();
            cell.setRequirementText(requirement: requirementsList[indexPath.item]);
            return cell;
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: emptyCell, for: indexPath) as! RequirementsEmptyCell;
            cell.setTitleLabel(title: "You don't have any requirements... add some!");
            return cell;
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(requirementsList.count > 0){
            return requirementsList.count;
        }
        return 1;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true);
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70;
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerCell) as! RequirementsPageTitleHeader;
        header.setTitleLabel(title: "You may add up to 10 different requirements");
        return header;
    }
    
}
