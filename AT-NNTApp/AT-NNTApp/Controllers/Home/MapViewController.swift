//
//  MapViewController.swift
//  AT-NNTApp
//
//  Created by Truong Nguyen on 7/13/16.
//  Copyright © 2016 demo. All rights reserved.
//

import UIKit
import MapKit
class MapViewController: UIViewController {
    var rest: Restaurant!
    var rests = [Restaurant]()
    var datasource: NSDictionary?
    var restaurantNames = [String]()
    @IBOutlet weak var myMap: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Map"
        //self.myMap.delegate = self
        loadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func loadData() {
        if let plist = Plist(name: "Restaurants") {
            if let datasource = plist.getValuesInPlistFile() {
                self.datasource = datasource
                self.restaurantNames = self.datasource?.allKeys as? [String] ?? []
                self.fillDatasourceIntoArray(datasource)
            }
        }
    }
    
    func fillDatasourceIntoArray(datasource: NSDictionary) {
        for i in 0..<datasource.count {
            let res = datasource.objectForKey(self.restaurantNames[i]) as? NSDictionary
            if let res = res {
                
                let image = res.objectForKey("imageRestaurant") as? String ?? ""
                let address = res.objectForKey("address")  as? String ?? ""
                let shortDes = res.objectForKey("shortDes") as? String ?? ""
                let longDes = res.objectForKey("longDes") as? String ?? ""
                let latitude = res.objectForKey("latitude") as? Double ?? 0.0
                let longtitude = res.objectForKey("longtitude") as? Double ?? 0.0
                let favorite = res.objectForKey("favorite") as? Bool ?? false
                var foods = [String]()
                if let foodObj = res.objectForKey("menu") as? NSArray {
                    for item in foodObj {
                        foods.append(String(item))
                    }
                }
                self.rests.append(Restaurant(image: image, name: restaurantNames[i], address: address, shortDes: shortDes, longDes: longDes, latitude: latitude, longtitude: longtitude, favorite: favorite, food: foods))
                
                    let location = CLLocationCoordinate2D(latitude: latitude, longitude: longtitude)
                    let span = MKCoordinateSpanMake(0.05, 0.05)
                    let region = MKCoordinateRegionMake(location, span)
                    myMap.setRegion(region, animated: true)
                
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = location
                    annotation.title = restaurantNames[i]
                    annotation.subtitle = address
                    myMap.addAnnotation(annotation)
            }
        }
    }
}
extension MapViewController: MKMapViewDelegate {
    
    func mapView(mapView: MKMapView,viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView?{
        let reuseIdentifier = "pin"
        var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseIdentifier)
        if pinView == nil {
            pinView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
            pinView!.canShowCallout = true
        } else {
            pinView!.annotation = annotation
        }
        pinView!.image = UIImage(named:"pin")
        let button = UIButton(type: UIButtonType.DetailDisclosure) as UIButton
        pinView?.rightCalloutAccessoryView = button
        return pinView
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            let locationMap = view.annotation
            for location in self.rests {
                if location.name == (locationMap?.title)! {
                    let detailView = HomeDetailViewController(nibName: "HomeDetailViewController", bundle: nil)
                    detailView.rest = location
                    self.navigationController?.pushViewController(detailView, animated: true)
                }
            }
        }
    }
    // map zom
    func zoomToRegion() {
        let location = CLLocationCoordinate2D(latitude: 16.0718911, longitude: 108.2228753)
        let span = MKCoordinateSpanMake(0.01, 0.01)
        let region = MKCoordinateRegion(center: location, span: span)
        myMap.setRegion(region, animated: true)
    }
}