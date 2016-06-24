//
//  RootViewController.swift
//  BTCN_24062016
//
//  Created by Truong Nguyen on 6/24/16.
//  Copyright © 2016 TruongNguyen. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    @IBOutlet weak var aView: UIView!
    @IBOutlet weak var bView: UIView!
    @IBOutlet weak var cView: UIView!
    var selectedView = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
        let segmentedView = NSBundle.mainBundle().loadNibNamed("CustomSegmented", owner: nil, options: nil).last as! CustomSegmented
        segmentedView.frame = CGRectMake(40, 50, 300 , 30)
        segmentedView.delegate = self
        self.view.addSubview(segmentedView)
        
        if let index = NSUserDefaults.standardUserDefaults().objectForKey("index") as? Int {
            showView(segmentedView, index: index)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension RootViewController: mySegmentedDelegate {
    func showView(view: CustomSegmented, index: Int) {
        switch index {
        case 0:
            aView.hidden = false
            bView.hidden = true
            cView.hidden = true
        case 1:
            aView.hidden = true
            bView.hidden = false
            cView.hidden = true
        case 2:
            aView.hidden = true
            bView.hidden = true
            cView.hidden = false
        default:
            break
        }
        NSUserDefaults.standardUserDefaults().setInteger(index, forKey: "index")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
}