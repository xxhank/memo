//
//  SightPopupListView.swift
//  Memo
//
//  Created by wangchaojs02 on 15/11/1.
//  Copyright © 2015年 wangchaojs02. All rights reserved.
//

import UIKit
import ReactiveCocoa
import SwiftColors

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
 
    var journalListView:JournalListView?
    var photoListView:PhotoListView?
    var touristListView:TouristListView?

    override func awakeFromNib() {
        self.collectionView.registerNibName("SightPopupCell", forCellReuseIdentifier: "SightPopupCell")
        journalListView = JournalListView.viewFromXib() as? JournalListView
        photoListView = PhotoListView.viewFromXib() as? PhotoListView
        touristListView = TouristListView.viewFromXib() as? TouristListView
        self.proxy.datas = [journalListView!
                            ,photoListView!
                            ,touristListView!];
        
        //self.segmentedControl.layer.borderWidth = 0;
        //self.segmentedControl.layer.borderColor = UIColor.clearColor().CGColor;
        
        let barMetrics: UIBarMetrics = .Default
        
       // self.segmentedControl.layer.cornerRadius = 0;
        let clearImage:UIImage = UIImage();
        self.segmentedControl.setDividerImage( clearImage, forLeftSegmentState: .Normal, rightSegmentState: .Selected, barMetrics: barMetrics)
        self.segmentedControl.setDividerImage( clearImage, forLeftSegmentState: .Selected, rightSegmentState: .Normal, barMetrics: barMetrics)
        self.segmentedControl.setDividerImage( clearImage, forLeftSegmentState: .Normal, rightSegmentState: .Normal, barMetrics: barMetrics)
        
        let backgroundImageSize = CGSize(width: 10, height: 10)
        let backgroundImage = UIImage(color: UIColor(hex: 0x424b54)!, size: backgroundImageSize).resizableImageWithCapInsets(UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1))
        self.segmentedControl.setBackgroundImage(backgroundImage, forState: .Normal, barMetrics: barMetrics)
        
        let selectBackgroundImage = UIImage(color: UIColor(hex: 0x27313b)!, size: backgroundImageSize).resizableImageWithCapInsets(UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1))
        self.segmentedControl.setBackgroundImage(selectBackgroundImage, forState: .Selected, barMetrics: barMetrics)
        let attributs:[String:AnyObject] = [NSFontAttributeName:UIFont.systemFontOfSize(16)
                                        , NSForegroundColorAttributeName:UIColor(hex: 0xDAE2E9)!]
        self.segmentedControl.setTitleTextAttributes(attributs, forState: .Normal)
        self.segmentedControl.setTitleTextAttributes(attributs, forState: .Selected)
    }
    
    @IBAction func modeChanged(sender: AnyObject) {
        let segmentedControl = sender as! UISegmentedControl
        let item = segmentedControl.selectedSegmentIndex
        self.collectionView.scrollToItemAtIndexPath(NSIndexPath(forItem: item, inSection: 0), atScrollPosition:UICollectionViewScrollPosition.CenteredHorizontally , animated: true)
    }
}

// MARK: signals

extension SightPopupListView{
    func journalListSelectSignal()->Signal<(NSIndexPath, AnyObject?), NSError>{
        return (self.journalListView?.selectSignal())!
    }
    func photoListSelectSignal()->Signal<(NSIndexPath, AnyObject?), NSError>{
        return (self.photoListView?.selectSignal())!
    }
    func touristListSelectSignal()->Signal<(NSIndexPath, AnyObject?), NSError>{
        return (self.touristListView?.selectSignal())!
    }
}
