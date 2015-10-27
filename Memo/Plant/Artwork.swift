//
//  Artwork.swift
//  Memo
//
//  Created by wangchaojs02 on 15/10/27.
//  Copyright © 2015年 wangchaojs02. All rights reserved.
//

import MapKit
import AddressBook
import SwiftyJSON
/** Artwork protocol

*/
class Artwork : NSObject, MKAnnotation {
    let title:String?;
    let locationName :String;
    let discipline:String;
    let coordinate : CLLocationCoordinate2D;

    init(title:String
        , locationName:String
        , discipline:String
        , coordinate : CLLocationCoordinate2D  ){

            self.title = title;
            self.locationName = locationName;
            self.discipline = discipline;
            self.coordinate = coordinate;

            super.init();

    }

    var subtitle:String? {
        return locationName;
    }

    func mapItem()->MKMapItem{
        let addressDictionary = [String(kABPersonAddressStateKey):subtitle!];

        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDictionary)

        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title

        return mapItem;
    }

    class func fromJSON(json:[JSON]) ->Artwork?{
        var title:String
        if let titleOrNil = json[16].string {
            title = titleOrNil;
        }else{
            title = "";
        }

        let locationName = json[12].string;
        let discipline = json[15].string;

        let latitude = NSNumberFormatter().numberFromString(json[18].string!)?.doubleValue;
        let longitude = NSNumberFormatter().numberFromString(json[19].string!)?.doubleValue;
        let coordinate = CLLocationCoordinate2D(latitude: latitude!, longitude: longitude!)

        return Artwork(title: title, locationName: locationName!, discipline: discipline!, coordinate: coordinate)
    }
}
