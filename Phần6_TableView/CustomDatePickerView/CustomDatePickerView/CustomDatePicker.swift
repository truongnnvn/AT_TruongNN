//
//  CustomDatePicker.swift
//  CustomDatePickerView
//
//  Created by Truong Nguyen on 7/6/16.
//  Copyright © 2016 TruongNguyen. All rights reserved.
//

import UIKit

protocol PickerViewProtocol {
    func cancelPickerView()
    func donePickerView(day: Int, month: Int, year: Int)
}

class CustomDatePicker: UIView, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var pickerView: UIPickerView!
    var isChanged = false

    var days = [Int]()
    var months = [Int]()
    var years = [Int]()
    var selectedDay = 1
    var selectedMonth = 1
    var selectYear = 1970
    
    var delegate:PickerViewProtocol!
 
    override func awakeFromNib() {
        loadData()
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func loadData() {
        for i in 1...31 {
            days.append(i)
        }
        
        for j in 1...12 {
            months.append(j)
        }
        
        for k in 1970...2016 {
            years.append(k)
        }
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return days.count
        case 1:
            return months.count
        default:
            return years.count
        }
    }
    //MARK: Delegates
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return String(days[row])
        case 1:
            return String(months[row])
        default:
            return String(years[row])
        }
    }

    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            selectedDay = days[row]
        case 1:
            selectedMonth = months[row]
        default:
            selectYear = years[row]
        }
        
    }
    
    @IBAction func cancel(sender: AnyObject) {
        if let delegate = delegate {
            delegate.cancelPickerView()
        }
    }

    
    @IBAction func done(sender: AnyObject) {
        if let delegate = delegate {
            delegate.donePickerView(selectedDay, month: selectedMonth, year: selectYear)
        }
    }
    
}
