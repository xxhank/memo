//
//  Artwork.swift
//  Memo
//
//  Created by wangchaojs02 on 15/10/27.
//  Copyright © 2015年 wangchaojs02. All rights reserved.
//

import MapKit
import AddressBook


/** Artwork protocol

*/
class Artwork : NSObject, MKAnnotation {
    internal let model:SightModel;

    init( model:SightModel){
        self.model = model;
        super.init();
    }

    /// MKAnnotation
    var subtitle:String? {
        return model.name
    }
    var title:String?{
        return model.name;
    }

    var coordinate: CLLocationCoordinate2D{
        return model.coordinate;
    }

    func mapItem()->MKMapItem{
        let addressDictionary = [String(kABPersonAddressStateKey):subtitle!];

        let placemark = MKPlacemark(coordinate: model.coordinate, addressDictionary: addressDictionary)

        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = model.name

        return mapItem;
    }
}
