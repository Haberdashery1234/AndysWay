//
//  LocationManager.swift
//  AndysWay
//
//  Created by Christian Grise on 10/25/24.
//

import Foundation
import MapKit
import CoreLocation
import Combine

final class LocationManager: NSObject, ObservableObject {
    private let locationManager = CLLocationManager()
    
    @Published var region = MKCoordinateRegion()
    
    @Published var userLocation: CLLocation?
    
    override init() {
        super.init()
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.setup()
    }
    
    private func setup() {
        switch locationManager.authorizationStatus {
            //If we are authorized then we request location just once,
            // to center the map
        case .authorizedWhenInUse:
            locationManager.requestLocation()
            //If we don´t, we request authorization
        case .notDetermined:
            locationManager.startUpdatingLocation()
            locationManager.requestWhenInUseAuthorization()
        default:
            break
        }
    }
    
    func getCurrentLocation() {
        guard .authorizedWhenInUse == locationManager.authorizationStatus else { return }
        locationManager.startUpdatingLocation()
        locationManager.requestLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        guard .authorizedWhenInUse == manager.authorizationStatus else { return }
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Location updated: \(String(describing: locations.last?.coordinate))")
        locationManager.stopUpdatingLocation()
        locations.last.map {
            userLocation = $0
            region = MKCoordinateRegion(center: $0.coordinate, span: .init(latitudeDelta: 0.01, longitudeDelta: 0.01))
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error: \(error)")
    }
}
