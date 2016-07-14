//
//  DetailMapViewController.swift
//  AT-NNTApp
//
//  Created by Truong Nguyen on 7/14/16.
//  Copyright © 2016 demo. All rights reserved.
//

import UIKit
import MapKit

class DetailMapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var myMap: MKMapView!
    
    var locate: MKAnnotation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        locate?.coordinate
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegionMake(locate.coordinate, span)
        myMap.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = locate.coordinate
        annotation.title = title
        annotation.subtitle = locate.subtitle!
        myMap.addAnnotation(annotation)
        drawMap()
        //showRouteOnMap()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func drawMap() {
        self.zoomToRegion()
        // 1
        self.myMap.delegate = self
        // 2.current location
        let currentLocal = CLLocationCoordinate2D(latitude: 16.0762123, longitude: 108.2355277)
        // restaurant location
        let restaurantLocal: CLLocationCoordinate2D = locate.coordinate
        // 3.
        let currentPlaceMark = MKPlacemark(coordinate: currentLocal, addressDictionary: nil)
        let restaurantPlaceMark = MKPlacemark(coordinate: restaurantLocal, addressDictionary: nil)
        // 4.
        let currentMapItem = MKMapItem(placemark: currentPlaceMark)
        let restaurantMapItem = MKMapItem(placemark: restaurantPlaceMark)
        // 5. set info
        let currentAnnotation = MKPointAnnotation()
        currentAnnotation.title = "Current Location"
        if let location = currentPlaceMark.location {
            currentAnnotation.coordinate = location.coordinate
        }
        let restaurantAnnotaton = MKPointAnnotation()
        restaurantAnnotaton.title = locate.title!
        restaurantAnnotaton.subtitle = locate.subtitle!
        if let location = restaurantPlaceMark.location {
            restaurantAnnotaton.coordinate = location.coordinate
        }
        // 6.
        self.myMap.showAnnotations([currentAnnotation, restaurantAnnotaton], animated: true)
        // 7.
        let directRequest = MKDirectionsRequest()
        directRequest.source = currentMapItem
        directRequest.destination = restaurantMapItem
        directRequest.transportType = .Automobile
        let directions = MKDirections(request: directRequest)
        // 8.
        directions.calculateDirectionsWithCompletionHandler {
            (response, error) -> Void in
            guard let response = response else {
                if let error = error {
                    print("Error: \(error)")
                }
                return
            }
            let route = response.routes[0]
            self.myMap.addOverlay((route.polyline), level: MKOverlayLevel.AboveRoads)
            
            let rect = route.polyline.boundingMapRect
            self.myMap.setRegion(MKCoordinateRegionForMapRect(rect), animated: true)
        }
    }
    func zoomToRegion() {
        
        let location = CLLocationCoordinate2D(latitude: 16.072096, longitude: 108.226992)
        let span = MKCoordinateSpanMake(0.05, 0.01)
        let region = MKCoordinateRegion(center: location, span: span)
        myMap.setRegion(region, animated: true)
    }
    func showRouteOnMap(){
        self.myMap.delegate = self
        let request = MKDirectionsRequest()
        let currentLocal = CLLocationCoordinate2D(latitude: 16.0762123, longitude: 108.2355277)
        
        let currentPlaceMark = MKPlacemark(coordinate: currentLocal, addressDictionary: nil)
        let currentAnnotation = MKPointAnnotation()
        currentAnnotation.title = "Current Location"
        if let location = currentPlaceMark.location {
            currentAnnotation.coordinate = location.coordinate
        }
        
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: currentLocal, addressDictionary: nil))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: locate.coordinate, addressDictionary: nil))
        request.requestsAlternateRoutes = true
        request.transportType = .Automobile
        let direction = MKDirections(request: request)
        direction.calculateDirectionsWithCompletionHandler { [unowned self] response, error in
            guard let unwrappedResponse = response else { return }
            
            if (unwrappedResponse.routes.count > 0) {
                self.myMap.addOverlay(unwrappedResponse.routes[0].polyline)
                self.myMap.setVisibleMapRect(unwrappedResponse.routes[0].polyline.boundingMapRect, animated: true)
            }
        }
    }
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKPolyline {
            let polylineRenderer = MKPolylineRenderer(overlay: overlay)
            //polylineRenderer.strokeColor = UIColor.init(hex: 0x04C8FF)
            polylineRenderer.lineWidth = 3
            return polylineRenderer
        }
        return MKOverlayRenderer()
    }
}
