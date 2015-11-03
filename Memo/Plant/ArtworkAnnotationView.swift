//
//  MKAnnotationView+ArtworkAnnotationView.swift
//  Memo
//
//  Created by wangchaojs02 on 15/10/27.
//  Copyright © 2015年 wangchaojs02. All rights reserved.
//

import MapKit
import Haneke
import XCGLogger

class ArtworkAnnotationContentView:UIView{
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var badgeLabel: MPLabel!
}


/** 
 ArtworkAnnotationView  
 */
class ArtworkAnnotationView: MKAnnotationView {
    var contentView:ArtworkAnnotationContentView?;

    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
       if let wrapperView = NSBundle.mainBundle().loadNibNamed("ArtworkAnnotationContentView", owner: nil, options: nil)[0] as? UIView {
            if let contentView = wrapperView.subviews.first as? ArtworkAnnotationContentView{
                self.contentView = contentView
                let fittingSize = contentView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize)
                let frame = self.frame;
                var origin = frame.origin;
                origin.x -= (fittingSize.width - frame.size.width)/2;
                origin.y -= (fittingSize.height - frame.size.height)/2;
                self.frame = CGRect(origin: origin, size: fittingSize);
                contentView.frame = CGRect(origin: self.bounds.origin, size: fittingSize);
                contentView.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
                contentView.translatesAutoresizingMaskIntoConstraints = true;
                self.addSubview(contentView)
            }
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame);
    }

    override func prepareForReuse() {
    }

    internal func update(sight:SightModel?){
        let artwork = self.annotation as? Artwork;
        let sightModel = artwork?.model as SightModel?;
        if sightModel == nil {
            return;
        }

        var count = sightModel!.count
        if count == 0 {
            count = UInt.random(min: 100, max: 10000)//   arc4random_uniform(1000) + 100;
        }
        self.contentView?.badgeLabel.text = String.init(format: "%d",count);

        if let url = NSURL(string: sightModel!.thumbnail!){
            self.contentView?.imageView.hnk_setImageFromURL(url)
        }
    }

}