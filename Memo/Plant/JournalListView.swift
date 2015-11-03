//
//  JournalListView.swift
//  Memo
//
//  Created by wangchaojs02 on 15/11/1.
//  Copyright © 2015年 wangchaojs02. All rights reserved.
//

import UIKit

class JournalListView: UIView {
    @IBOutlet weak var tableView: UITableView!

    lazy var proxy:MMArrayTableViewProxy = MMArrayTableViewProxy(tableView: self.tableView
                    , identifier: { (tableView, indexPath) -> String in
                        return "JournalCell";
                    }, builder: { (tableView, indexPath) -> UITableViewCell in
                        return JournalCell.viewFromXib() as! JournalCell;
                    }, modifier: { (tableView, tableViewCell, cellData) -> () in
                        if let cell = tableViewCell as? JournalCell{

                        }
                    }
                )



    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(frame: CGRect) {
        super.init(frame: frame);
    }

    override func didMoveToSuperview() {
        self.tableView.registerNibName("JournalCell", forCellReuseIdentifier: "JournalCell")
    }
}
