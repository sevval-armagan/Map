//
//  Map.swift
//  Map
//
//  Created by Appcent on 27.10.2020.
//

import Foundation
import MapKit
import CoreLocation

protocol CoordinatorHelperProtocol {
    func getAddressFromLatLon(pdblLatitude: String, withLongitude pdblLongitude: String) -> Adress
}

class CoordinatorHelper: CoordinatorHelperProtocol{
    
    
    func getAddressFromLatLon(pdblLatitude: String, withLongitude pdblLongitude: String) -> Adress {
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let lat: Double = Double("\(pdblLatitude)")!
        //21.228124
        let lon: Double = Double("\(pdblLongitude)")!
        //72.833770
        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = lat
        center.longitude = lon
        
        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
        
        var adress = Adress()
        ceo.reverseGeocodeLocation(loc, completionHandler:
                                    {(placemarks, error) in
                                        if (error != nil)
                                        {
                                            print("reverse geodcode fail: \(error!.localizedDescription)")
                                        }
                                        let pm = placemarks! as [CLPlacemark]
                                        
                                        if pm.count > 0 {
                                            let pm = placemarks![0]
                                            
                                            
                                            // var addressString : String = ""
                                            if pm.subLocality != nil {
                                                adress.subLocality =  pm.subLocality! + ", "
                                            }
                                            if pm.thoroughfare != nil {
                                                adress.thoroughfare =  pm.thoroughfare! + ", "
                                            }
                                            if pm.subThoroughfare != nil {
                                                adress.subThoroughfare = pm.subThoroughfare! + ", "
                                            }
                                            if pm.locality != nil {
                                                adress.locality =  pm.locality! + ", "
                                            }
                                            if pm.country != nil {
                                                adress.country =  pm.country! + ", "
                                            }
                                            if pm.postalCode != nil {
                                                adress.postalCode =  pm.postalCode! + " "
                                            }
                                        }
                                        
                                        print(adress)
                                    })
        return adress
        
    }
    
}
