//
//  SightModel.swift
//  Memo
//
//  Created by wangchaojs02 on 15/10/28.
//  Copyright © 2015年 wangchaojs02. All rights reserved.
//

import CoreLocation
import ObjectMapper
import SwiftyJSON

class SightModel: Mappable{
    var name:String?
    var count:UInt = 0
    var thumbnail:String?

    private var latitude:CLLocationDegrees = 0
    private var longitude:CLLocationDegrees = 0

    var coordinate:CLLocationCoordinate2D{
        get {
            return CLLocationCoordinate2D(latitude: latitude, longitude: longitude);
        }
        set {
            longitude = newValue.longitude;
            latitude = newValue.latitude;
        }
    }

    required init?(_ map:Map){

    }

    func mapping(map: Map) {
        name        <- map["photo_title"]
        count       <- map["count"]
        thumbnail   <- map["photo_file_url"]
        latitude    <- map["latitude"]
        longitude   <- map["longitude"]
    }

    class func fromJSON(json:SwiftyJSON.JSON)->SightModel?{
        if let dictionary = json.object as? [String : AnyObject]{
            return Mapper<SightModel>().map(dictionary);
        }
        return nil;
    }
}