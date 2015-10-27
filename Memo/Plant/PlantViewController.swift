//
//  PlantViewController.swift
//  Memo
//
//  Created by wangchaojs02 on 15/10/26.
//  Copyright © 2015年 wangchaojs02. All rights reserved.
//

import UIKit
import MapKit
import SwiftyJSON

class PlantViewController:UIViewController, MKMapViewDelegate, CLLocationManagerDelegate
{
    @IBOutlet weak var mapView: MKMapView!

    let locationManager = CLLocationManager();
    let regionRadius:CLLocationDistance  = 10000.0; ///< 默认地图范围1000米
    var artworks = [Artwork]()

    override func viewDidLoad() {
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization();
        self.locationManager.startUpdatingLocation();

        self.mapView.delegate = self;
        self.mapView.showsUserLocation = true;

        loadArtworks();
        mapView.addAnnotations(artworks)
    }

    func checkLocationAuthorizationStatus(){
        if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse{
            mapView.showsUserLocation = true;
        }else {
            locationManager.requestWhenInUseAuthorization();
        }
    }
    func loadArtworks(){
        let fileName = NSBundle.mainBundle().pathForResource("PublicArt", ofType: "json")

        do {
            let data :NSData = try NSData(contentsOfFile: fileName!, options: NSDataReadingOptions(rawValue: 0))
            let json = JSON(data:data)
            let datas = json["data"];
            for (_,subJson):(String, JSON) in datas {
               if let artwork = Artwork.fromJSON(subJson.array!){
                artworks.append(artwork);
                }
            }
        }catch{
            print(error)
        }
    }
    @IBAction func search(sender: AnyObject) {
        print("region:\(self.mapView.region)");
    }
}

/// MKMapViewDelegate
extension PlantViewController{
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {

        if let annotation = annotation as? Artwork{
            let identifier = "pin";
            var view:ArtworkAnnotationView
            if let dequeueView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier) as? ArtworkAnnotationView{
                dequeueView.annotation = annotation;
                view = dequeueView;
            }else {
                view = ArtworkAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                //view.canShowCallout = true
                //view.calloutOffset = CGPoint(x: -5, y: 5)
                //view.rightCalloutAccessoryView = UIButton(type:.DetailDisclosure) as UIView

            }
            //view.image = UIImage(named: "animatedImageNamed")

            return view
        }
        return nil
    }
}


/// CLLocationManagerDelegate
extension PlantViewController{
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        let currentLocation:CLLocation = locations.last!;
        self.mapView.region = MKCoordinateRegionMakeWithDistance(currentLocation.coordinate, regionRadius*2.0, regionRadius*2.0);
        self.locationManager.stopUpdatingLocation();
    }

    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let location = view.annotation as! Artwork
        let launchOptions = [MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving]
        location.mapItem().openInMapsWithLaunchOptions(launchOptions)
    }
}