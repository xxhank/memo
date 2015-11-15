//
//  TouristListView.swift
//  Memo
//
//  Created by wangchaojs02 on 15/11/1.
//  Copyright © 2015年 wangchaojs02. All rights reserved.
//

import UIKit
import ReactiveCocoa

class TouristListView: UIView {
    @IBOutlet weak var tableView: UITableView!

    lazy var proxy:MMArrayTableViewProxy = MMArrayTableViewProxy(tableView: self.tableView
                    , identifier: { (tableView, indexPath) -> String in
                        return "TouristCell";
                    }, builder: { (tableView, indexPath) -> UITableViewCell in
                        return TouristCell.viewFromXib() as! TouristCell;
                    }, modifier: { (tableView, tableViewCell, cellData) -> () in
                        if let cell = tableViewCell as? TouristCell{

                        }
                    }
                )
    override func awakeFromNib(){
        self.tableView.registerNibName("TouristCell", forCellReuseIdentifier: "TouristCell")
    }
    
    func selectSignal()->Signal<(NSIndexPath, AnyObject?), NSError>{
        return self.proxy.selectSignal;
    }
}
