//
//  ViewController.swift
//  Map.swift
//
//  Created by 安田 悠麿 on 2020/08/04.
//  Copyright © 2020 安田 悠麿. All rights reserved.
//

import UIKit
import MapKit
class ViewController: UIViewController, UITextFieldDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        inputText.delegate = self
    }

    @IBOutlet weak var inputText: UITextField!
    @IBOutlet weak var dispMap: MKMapView!
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        
        textField.resignFirstResponder()
        
        if let searchKey = textField.text{
            
            print(searchKey)
            
            let geocoder = CLGeocoder()
            
            geocoder.geocodeAddressString(searchKey , completionHandler: { (placemarks,
                                                                             error) in
                
                if let unwrapPlacemarks = placemarks {
                    
                    if let firstPlacemark = unwrapPlacemarks.first {
                        
                        if let location = firstPlacemark.location {
                            
                            let targetCoordinate = location.coordinate
                            
                            print(targetCoordinate)
                            
                            let pin = MKPointAnnotation()
                            
                            pin.coordinate = targetCoordinate
                            
                            pin.title = searchKey
                            
                            self.dispMap.addAnnotation(pin)
                            
                            self.dispMap.region = MKCoordinateRegion(center: targetCoordinate,  latitudinalMeters:
                                500.0, longitudinalMeters: 500.0)
                        }
                    }
                }
                
            })
        }
        return true
    }
}

