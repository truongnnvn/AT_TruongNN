//
//  HomeViewController.swift
//  AT-NNTApp
//
//  Created by Truong Nguyen on 7/13/16.
//  Copyright © 2016 demo. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var cellIdentifier = "Cell"
    var datasource: NSDictionary?
    var restaurantNames = [String]()
    var restaurants = [Restaurant]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
     func configurationUI() {
    
    }
    
    func loadData() {
        if let plist = Plist(name: "Restaurants") {
            if let datasource = plist.getValuesInPlistFile() {
                self.datasource = datasource
                self.restaurantNames = self.datasource?.allKeys as? [String] ?? []
                self.fillDatasourceIntoArray(datasource)
            }
        }
        let nib = UINib(nibName: "HomeTableViewCell", bundle: nil)
        self.tableView.registerNib(nib, forCellReuseIdentifier: cellIdentifier)
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
                self.restaurants.append(Restaurant(image: image, name: restaurantNames[i], address: address, shortDes: shortDes, longDes: longDes, latitude: latitude, longtitude: longtitude, favorite: favorite, food: foods))
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurants.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as? HomeTableViewCell
        let rest = restaurants[indexPath.row]
        cell?.imageRestaurant.image = UIImage(named: rest.image)
        cell?.nameRestaurantLabel.text = rest.name
        cell?.addressLabel.text = rest.address
        cell?.shortDesLabel.text = rest.shortDes
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let detailVC = HomeDetailViewController(nibName: "HomeDetailViewController", bundle: nil)
        detailVC.rest = restaurants[indexPath.row]
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
