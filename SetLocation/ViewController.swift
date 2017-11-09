//
//  ViewController.swift
//  SetLocation
//
//  Created by Rimil Dey on 09/11/17.
//  Copyright © 2017 Rimil Dey. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    // MARK: - view did load
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        
    }
    
    // MARK: - outlets
    
    @IBOutlet weak var locationLabel: UILabel!
    
    // MARK: - interactions
    
    @IBAction func tapSetLocationButton(_ sender: UIButton) {
        getLocation()
    }
    
    // MARK: - core location
    let locationManager = CLLocationManager()

    // MARK:  location functions
    
    func getLocation() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.startUpdatingLocation()
    }
    
    // MARK:  CLLocation Manager Delegate
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let geoCoder = CLGeocoder()
        
        geoCoder.reverseGeocodeLocation(manager.location!) { (placemarks, error) in
            if let placemarksData = placemarks {
                let locationData = placemarksData[0]
                
                let city = locationData.locality!
                let state = locationData.administrativeArea!
                let zipCode = locationData.postalCode!
                let country = locationData.country!
                let location = "\(city), \(state), \(zipCode), \(country)"
                
                self.locationLabel.text = location
                self.locationLabel.textColor = .black
                
                self.locationManager.stopUpdatingLocation()

            } else {
                print("Error: \(String(describing: error?.localizedDescription))")
            }
        }
    }
    

}

