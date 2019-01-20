//
//  ThingsToBringList.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/19/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

class ThingsToBringList: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    let reuseCell = "ThingsToBringPageListCell";
    let headerCell = "ThingsToBringPageHeaderReuse";
    let emptyCell = "ThingsToBringEmptyCell";
    
    var thingsToBringList = [String]();
    var thingsToBringPage: ThingsToBringPage?;
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style);
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = UIColor.white;
        self.separatorStyle = .none;
        self.register(ThingsToBringCell.self, forCellReuseIdentifier: reuseCell);
        self.register(ThingsToBringEmptyCell.self, forCellReuseIdentifier: emptyCell);
        self.register(ThingsToBringTitleHeader.self, forHeaderFooterViewReuseIdentifier: headerCell);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    override var numberOfSections: Int{
        return 1;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(thingsToBringList.count > 0){
            //            print("requirements Cell dequeed");
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseCell, for: indexPath) as! ThingsToBringCell;
            cell.delegate = self.thingsToBringPage;
            cell.indexPath = indexPath;
            cell.setRequirementText(requirement: thingsToBringList[indexPath.item]);
            return cell;
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: emptyCell, for: indexPath) as! ThingsToBringEmptyCell;
            cell.setTitleLabel(title: "You didn't tell your friends what they need to bring! Tell them!");
            return cell;
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(thingsToBringList.count > 0){
            return thingsToBringList.count;
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
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerCell) as! ThingsToBringTitleHeader;
        header.setTitleLabel(title: "Add things to bring! Up to 15");
        return header;
    }
    
}

