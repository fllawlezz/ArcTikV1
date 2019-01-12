//
//  ChatPage.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/8/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

class ChatPage: UITableViewController{
    
    let messageCellReuse = "messageCellReuse";
    
    let sendMessageView = SendMessageView();
    
    let exampleChats = [
        "Hello there this is a testing string!",
        "Why is it that every targaryean in Westeros is trying to be killed? I mean Danny went to the wall and almost got herself killed! She even sacrificed one of her dragons! That Jon Snow must be good in bed!",
        "LOL if that isn't the truth, then what is!!!????",
        "I heard Jon Snow and Danny are aunt and nephew.... that is really really really sick if you think about it. What is wrong with George RR Martin and incest?"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.view.backgroundColor = UIColor.white;
        tableView.separatorStyle = .none
        
        self.tableView.register(ChatCell.self, forCellReuseIdentifier: messageCellReuse);
        setupNavBar();
        self.tableView.keyboardDismissMode = .interactive;
    }
    
    override var inputAccessoryView: UIView?{
        get{
            return self.sendMessageView;
        }
    }
    
    override var canBecomeFirstResponder: Bool{
        return  true;
    }
    
    fileprivate func setupNavBar(){
        self.navigationItem.title = "Daniel Negreanu";
        
        let infoButton = UIBarButtonItem(image: #imageLiteral(resourceName: "info"), style: .plain, target: nil, action: nil);
        self.navigationItem.rightBarButtonItem = infoButton;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: messageCellReuse, for: indexPath) as! ChatCell;
        cell.setMessageText(message: exampleChats[indexPath.item]);
        cell.isIncoming = indexPath.row % 2 == 0 //checks for ood/even
        return cell;
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exampleChats.count;
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
}
