//
//  PhotoListView.swift
//  Memo
//
//  Created by wangchaojs02 on 15/11/1.
//  Copyright © 2015年 wangchaojs02. All rights reserved.
//

import UIKit

class PhotoListView: UIView {
    @IBOutlet weak var collectionView: UICollectionView!

    lazy var proxy:MMArrayCollectionViewProxy = MMArrayCollectionViewProxy(
                    collectionView: self.collectionView
                    , identifier: { (tableView, indexPath) -> String in
                        return "PhotoCell";
                    }, builder: { (tableView, indexPath) -> UICollectionViewCell in
                        return PhotoCell.viewFromXib() as! PhotoCell;
                    }, modifier: { (tableView, tableViewCell, cellData) -> () in
                        if let cell = tableViewCell as? PhotoCell{

                        }
                    }, measurer: {(collectionView, collectionViewLayout, indexPath) -> CGSize in
                        return MMCollectionViewCellSquareSize(collectionView, column: 3)
                    }
    )
 
    override func awakeFromNib() {
        self.collectionView.registerNibName("PhotoCell", forCellReuseIdentifier: "PhotoCell")
    }
}
