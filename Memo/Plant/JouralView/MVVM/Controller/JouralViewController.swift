//
//  JouralViewController.swift
//  Memo
//
//  Created by wangchaojs02 on 15/11/10.
//  Copyright © 2015年 wangchaojs02. All rights reserved.
//

import UIKit

class JouralViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    lazy var proxy:MMArrayTableViewProxy = MMArrayTableViewProxy(tableView: self.tableView
        , identifier: { (tableView, indexPath) -> String in
            return "JournalPhotoCell";
        }, builder: { (tableView, indexPath) -> UITableViewCell in
            return JournalCell.viewFromXib() as! JournalCell;
        }, modifier: { (tableView, tableViewCell, cellData) -> () in
            if let cell = tableViewCell as? JournalCell{
                
            }
        }
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.tableView.registerNibName("JournalPhotoCell", forCellReuseIdentifier: "JournalPhotoCell")
        self.proxy.datas = [1,2,3,4,5,6,7,8];
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
