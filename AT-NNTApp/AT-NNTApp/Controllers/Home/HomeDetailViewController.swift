//
//  HomeDetailViewController.swift
//  AT-NNTApp
//
//  Created by Truong Nguyen on 7/14/16.
//  Copyright © 2016 demo. All rights reserved.
//

import UIKit
import MapKit
class HomeDetailViewController: UIViewController {

    @IBOutlet weak var myMap: MKMapView!
    @IBOutlet weak var myCollectionView: UICollectionView!
    @IBOutlet weak var myPageControl: UIPageControl!
    @IBOutlet weak var restName: UILabel!
    @IBOutlet weak var restAddress: UILabel!
    @IBOutlet weak var shortDes: UILabel!
    @IBOutlet weak var longDes: UILabel!
    
    let cellIdentifier = "Cell"
    
    var rest = Restaurant(image: "", name: "", address: "", shortDes: "", longDes: "", latitude: 0, longtitude: 0, favorite: true, food: [""])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let nib = UINib(nibName: "HomeDetailCollectionViewCell", bundle: nil)
        self.myCollectionView.registerNib(nib, forCellWithReuseIdentifier: cellIdentifier)
        
        self.myCollectionView.delegate = self
        self.myCollectionView.dataSource = self
        myMap.delegate = self
        
        restName.text = rest.name
        restAddress.text = rest.address
        shortDes.text = rest.shortDes
        longDes.text = rest.longDes
            
        let location = CLLocationCoordinate2D(latitude: rest.latitude!, longitude: rest.longtitude!)
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegionMake(location, span)
        myMap.setRegion(region, animated: true)
            
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = rest.name
        annotation.subtitle = rest.address
        myMap.addAnnotation(annotation)
        
        self.configPageController()
        
    }
    
    @IBAction func nextButton(sender: AnyObject) {
        if (self.myPageControl.currentPage + 1 < self.rest.food.count) {
            self.myPageControl.currentPage = self.myPageControl.currentPage + 1
            let newOffset = CGPointMake(CGFloat(self.myPageControl.currentPage * Int(myCollectionView.frame.size.width)), myCollectionView.contentOffset.y)
            myCollectionView.setContentOffset(newOffset, animated: true)
        } else {
            self.myPageControl.currentPage = 0
            let newOffset = CGPointMake(CGFloat(self.myPageControl.currentPage * Int(myCollectionView.frame.size.width)), myCollectionView.contentOffset.y)
            myCollectionView.setContentOffset(newOffset, animated: true)
        }
    }
    
    @IBAction func backButton(sender: AnyObject) {
        if (self.myPageControl.currentPage - 1 >= 0) {
            self.myPageControl.currentPage = self.myPageControl.currentPage - 1
            let newOffset = CGPointMake(CGFloat(self.myPageControl.currentPage * Int(myCollectionView.frame.size.width)), myCollectionView.contentOffset.y)
            myCollectionView.setContentOffset(newOffset, animated: true)
        }

    }
    
    func configPageController() {
        self.myPageControl.numberOfPages = self.rest.food.count
        self.myPageControl.currentPage = 0
        self.myPageControl.tintColor = UIColor.grayColor()
        self.myPageControl.pageIndicatorTintColor = UIColor.grayColor()
       // self.myPageControl.currentPageIndicatorTintColor = UIColor.init(hex: 0x04C8FF)
        self.myCollectionView.addSubview(myPageControl)
    }
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        myPageControl.currentPage = Int(pageNumber)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension HomeDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(self.rest.food.count)
        return self.rest.food.count
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath) as! HomeDetailCollectionViewCell
        cell.backgroundColor = UIColor.blackColor()
        cell.foodImageView.image = UIImage(named: self.rest.food[indexPath.row])
        print(self.rest.food[indexPath.row])
        // Configure the cell
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width = self.myCollectionView.frame.width
        let height = self.myCollectionView.frame.height
        return CGSize(width: width, height: height)
    }
}

extension HomeDetailViewController: MKMapViewDelegate {
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseIdentifier = "pin"
        var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseIdentifier)
        if pinView == nil {
            pinView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
            pinView!.canShowCallout = true
        } else {
            pinView!.annotation = annotation
        }
        pinView!.image = UIImage(named: "pin")
         let button = UIButton(type: UIButtonType.DetailDisclosure) as UIButton
         pinView?.rightCalloutAccessoryView = button
        return pinView
    }
    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
        let detailMap = DetailMapViewController()
        let selectedLocal = view.annotation! as MKAnnotation
        detailMap.locate = selectedLocal
        self.navigationController?.pushViewController(detailMap, animated: true)
    }
    // map zom
    func zoomToRegion() {
        let location = CLLocationCoordinate2D(latitude: 16.0718911, longitude: 108.2228753)
        let span = MKCoordinateSpanMake(0.05, 0.01)
        let region = MKCoordinateRegion(center: location, span: span)
        myMap.setRegion(region, animated: true)
    }
    
}
