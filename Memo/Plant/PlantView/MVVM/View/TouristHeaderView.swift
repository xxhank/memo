//
//  TouristHeaderView.swift
//  Memo
//
//  Created by wangchaojs02 on 15/11/15.
//  Copyright © 2015年 wangchaojs02. All rights reserved.
//

import UIKit
import ReactiveCocoa

@objc protocol TouristHeaderViewDelegate{
    func backButtonClicked()->();
}

class TouristHeaderView: MPXIBView {
    @IBOutlet weak var delegate:TouristHeaderViewDelegate?
    @IBOutlet weak var backButton: UIButton?
}

extension TouristHeaderView{
    @IBAction func backButtonClicked(sender: AnyObject) {
        self.delegate?.backButtonClicked();
    }
}

extension UIViewController:TouristHeaderViewDelegate{
    func backButtonClicked() {
        self.navigationController?.popViewControllerAnimated(true);
    }
}