//
//  SightPopupListView.swift
//  Memo
//
//  Created by wangchaojs02 on 15/11/1.
//  Copyright © 2015年 wangchaojs02. All rights reserved.
//

import UIKit

class SightPopupListView: UIView {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var segmentedControl:UISegmentedControl!;
    
    
    lazy var proxy:MMArrayCollectionViewProxy = MMArrayCollectionViewProxy(
                    collectionView: self.collectionView
                    , identifier: { (collectionView, indexPath) -> String in
                        return "SightPopupCell";
                    }, builder: { (collectionView, indexPath) -> UICollectionViewCell in
                        return SightPopupCell.viewFromXib() as! SightPopupCell;
                    }, modifier: { (collectionView, collectionViewCell, cellData) -> () in
                        if let cell:SightPopupCell = collectionViewCell as? SightPopupCell{
                            cell.content?.removeFromSuperview();

                            let view = cellData as! UIView;
                            view.frame = cell.contentView.bounds;
                            view.translatesAutoresizingMaskIntoConstraints = true
                            cell.contentView.addSubview(view);
                            cell.content = view;
                            
                            if let journalListView = view as? JournalListView{
                                journalListView.proxy.datas = [1,2,3,4,5,6]
                            }
                            else if let photoListView = view as? PhotoListView{
                                photoListView.proxy.datas = [1,2,3,4,5,6]
                            }
                            else if let touristListView = view as? TouristListView{
                                touristListView.proxy.datas = [1,2,3,4,5,6]
                            }
                        }
                    }, measurer: {(collectionView, collectionViewLayout, indexPath) -> CGSize in
                        return MMCollectionViewCellSingleColumnSize(collectionView)
                    }
                )
 

    override func awakeFromNib() {
        self.collectionView.registerNibName("SightPopupCell", forCellReuseIdentifier: "SightPopupCell")
        self.proxy.datas = [JournalListView.viewFromXib()
                            ,PhotoListView.viewFromXib()
                            ,TouristListView.viewFromXib()];
    }
    
    @IBAction func modeChanged(sender: AnyObject) {
        let segmentedControl = sender as! UISegmentedControl
        let item = segmentedControl.selectedSegmentIndex
        self.collectionView.scrollToItemAtIndexPath(NSIndexPath(forItem: item, inSection: 0), atScrollPosition:UICollectionViewScrollPosition.CenteredHorizontally , animated: true)
    }
}
