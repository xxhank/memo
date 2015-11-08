//
//  TouristCell.swift
//  Memo
//
//  Created by wangchaojs02 on 15/11/1.
//  Copyright © 2015年 wangchaojs02. All rights reserved.
//

import UIKit

class TouristCell:UITableViewCell{
    @IBOutlet weak var collectionView: UICollectionView!
    override func awakeFromNib() {
        self.collectionView.registerNibName("PhotoCell", forCellReuseIdentifier: "PhotoCell")
    }
    
    lazy var proxy:MMArrayCollectionViewProxy = MMArrayCollectionViewProxy(collectionView: self.collectionView
        , identifier: { (tableView, indexPath) -> String in
            return "PhotoCell";
        }, builder: { (tableView, indexPath) -> UICollectionViewCell in
            return PhotoCell.viewFromXib() as! PhotoCell;
        }, modifier: { (tableView, tableViewCell, cellData) -> () in
            if let cell = tableViewCell as? PhotoCell{
                
            }
        }, measurer: {(collectionView, collectionViewLayout, indexPath) -> CGSize in
            return MMCollectionViewCellSquareSize(collectionView, column: 5)
        }
    )
    override func prepareForReuse() {
        self.proxy.datas = [1,2,3,4,5,6];
    }
}
