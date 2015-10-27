//
//  MKAnnotationView+ArtworkAnnotationView.swift
//  Memo
//
//  Created by wangchaojs02 on 15/10/27.
//  Copyright © 2015年 wangchaojs02. All rights reserved.
//

import MapKit

/** 
 ArtworkAnnotationView Extends MKAnnotationView
*/
class ArtworkAnnotationView: MKAnnotationView {
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        let image = UIImage(named: "iconbutton_framewhite");
        self.image = image;
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame);
    }
}