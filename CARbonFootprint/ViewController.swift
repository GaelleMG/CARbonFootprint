//
//  ViewController.swift
//  CARbonFootprint
//
//  Created by Gaelle Muller-Greven on 10/4/20.
//  Copyright © 2020 Gaelle Muller-Greven. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var carbonFootprint: UILabel!
    @IBOutlet weak var carbonFootprintE: UILabel!
    @IBOutlet weak var selectStateLabel: UILabel!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var mpgSliderLabel: UILabel!
    @IBOutlet weak var vehicleMPG: UISlider!
    @IBOutlet weak var vehicleType: UISegmentedControl!
    @IBOutlet weak var statePicker: UIPickerView!
    @IBOutlet weak var carbonplot: UIImageView!
    
    var state = ""
    
    let states = ["AL", "AK", "AZ", "AR", "CA", "CO", "CT", "DE", "FL", "GA", "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME", "MD", "MA", "MI", "MN", "MS", "MO", "MT", "NE", "NV", "NH", "NJ", "NM", "NY", "NC", "ND", "OH", "OK", "OR", "PA", "RI", "SC", "SD", "TN", "TX", "UT", "VT", "VA", "WA", "WV", "WI", "WY"]
    
    var stateCarbon: [String:Float] = ["AL":425, "AK":485, "AZ":445, "AR":550, "CA":273, "CO":611, "CT":330, "DE":594, "FL":534, "GA":467, "HI":650, "ID":152, "IL":333, "IN":761, "IA":429, "KS":371, "KY":809, "LA":524, "ME":130, "MD":370, "MA":439, "MI":501, "MN":422, "MS":511, "MO":734, "MT":508, "NE":545, "NV":459, "NH":155, "NJ":367, "NM":705, "NY":234, "NC":419, "ND":607, "OH":636, "OK":407, "OR":250, "PA":423, "RI":564, "SC":297, "SD":230, "TN":349, "TX":506, "UT":756, "VT":22, "VA":402, "WA":165, "WV":882, "WI":597, "WY":814]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return states[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return states.count
    }
    
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        state = states[row]
//        carbonFootprint.text = String((((10000/3)*22)/1000))
//    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        state = states[row]
        carbonFootprint.text = String(Int((((10000/3)*stateCarbon[state]!)/1000)))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func vehicleTypeIndex(_ sender: Any) {
        
        switch vehicleType.selectedSegmentIndex {
        case 0:
            statePicker.isHidden = true
            selectStateLabel.isHidden = true
            label.isHidden = false
            vehicleMPG.isHidden = false
            mpgSliderLabel.isHidden = false
            carbonFootprint.text = ""
            vehicleMPG.setValue(50, animated: false)
            mpgSliderLabel.text = "50 MPG"
            carbonplot.isHidden = true
        case 1:
            statePicker.isHidden = false
            selectStateLabel.isHidden = false
            label.isHidden = true
            vehicleMPG.isHidden = true
            mpgSliderLabel.isHidden = true
            carbonFootprint.text = ""
            carbonplot.isHidden = false
        default:
            print("")
        }
        
    }
    
    @IBAction func mpgValue(_ sender: Any) {
        mpgSliderLabel.text = String(Int(vehicleMPG.value)) + " MPG"
        
        carbonFootprint.text = String(Int(((10000/(vehicleMPG.value))*8887)/1000))
    }

}

