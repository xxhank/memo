//
//  JournalCell.swift
//  Memo
//
//  Created by wangchaojs02 on 15/11/1.
//  Copyright © 2015年 wangchaojs02. All rights reserved.
//

import UIKit
import TagListView

class JournalCell:UITableViewCell{
    @IBOutlet weak var tagsView: TagListView!
    
    override func awakeFromNib() {
        self.tagsView.textFont = UIFont.systemFontOfSize(9);
        self.tagsView.addTag("北京")
        self.tagsView.addTag("成都")
        self.tagsView.addTag("昆明")
        self.tagsView.addTag("大理")
        self.tagsView.addTag("香格里拉")
        self.tagsView.addTag("...")
        self.tagsView.addTag("拉萨")
    }
}
