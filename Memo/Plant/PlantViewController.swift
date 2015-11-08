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
        let fileName = NSBundle.mainBundle().pathForResource("sights", ofType: "json")

        do {
            let data :NSData = try NSData(contentsOfFile: fileName!, options: NSDataReadingOptions(rawValue: 0))
            let json = JSON(data:data)
            let sights = json["photos"];
            for (_,subJson):(String, JSON) in sights {
                if let sight = SightModel.fromJSON(subJson){
                     artworks.append(Artwork(model: sight));
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
            let identifier = "sight";
            var annotationView:ArtworkAnnotationView
            if let dequeueView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier) as? ArtworkAnnotationView{
                annotationView = dequeueView;
            }else {
                annotationView = ArtworkAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            }

            annotationView.update(nil);

            return annotationView
        }
        return nil
    }

    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
        if let annotation = (view as! ArtworkAnnotationView).annotation as? Artwork{
            /// let sightModel = annotation.model
            if let listView = SightPopupListView.viewFromXib() as? SightPopupListView {
                var frame = self.view.bounds;
                frame.origin.y    = frame.size.height - 400;
                frame.size.height = 400;
                listView.frame = frame;
                listView.translatesAutoresizingMaskIntoConstraints = true
                self.view.addSubview(listView);
            }
        }
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