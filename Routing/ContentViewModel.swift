//
//  ContentViewModel.swift
//  Routing
//
//  Created by Tero Jankko on 11/1/22.
//

import Foundation
import MapKit

enum MapDetails {
    static let startingLocation = CLLocationCoordinate2D(latitude: 37, longitude: -121)
    static let span = MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
}
final class ContentViewModel: NSObject, CLLocationManagerDelegate, ObservableObject {

    @Published var region = MKCoordinateRegion(center: MapDetails.startingLocation, span: MapDetails.span)

    var locationManager: CLLocationManager?

    func checkIfLocationServicesIsEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager!.delegate = self
            locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        } else {
            print("No location services available")
        }
    }

    func checkLocationAuthorization() {
        guard let locationManager = locationManager else { return }
        switch locationManager.authorizationStatus {

        case .notDetermined:
            print("not determined")
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("restricted")
        case .denied:
            print("denied")
        case .authorizedAlways, .authorizedWhenInUse:
            region = MKCoordinateRegion(center: locationManager.location!.coordinate, span: MapDetails.span)
        @unknown default:
            break
        }
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
}
