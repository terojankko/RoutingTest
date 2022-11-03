////
////  ContentViewModel.swift
////  Routing
////
////  Created by Tero Jankko on 11/1/22.
////
//
//import Foundation
//import MapKit
//
//enum MapDetails {
//    static var sourceLocation = CLLocationCoordinate2D(latitude: 37, longitude: -121)
//    static var destinationLocation = CLLocationCoordinate2D(latitude: 38, longitude: -122)
//    static let span = MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
//}
//
//final class ContentViewModel: NSObject, CLLocationManagerDelegate, ObservableObject {
//
//    @Published var region = MKCoordinateRegion(center: MapDetails.startingLocation, span: MapDetails.span)
//
//    var locationManager: CLLocationManager?
//
//    func checkIfLocationServicesIsEnabled() {
//        if CLLocationManager.locationServicesEnabled() {
//            locationManager = CLLocationManager()
//            locationManager!.delegate = self
//            locationManager?.desiredAccuracy = kCLLocationAccuracyBest
//            locationManager?.startUpdatingLocation()
//        } else {
//            print("No location services available")
//        }
//    }
//
//    func checkLocationAuthorization() {
//        guard let locationManager = locationManager else { return }
//        switch locationManager.authorizationStatus {
//
//        case .notDetermined:
//            print("not determined")
//            locationManager.requestWhenInUseAuthorization()
//        case .restricted:
//            print("restricted")
//        case .denied:
//            print("denied")
//        case .authorizedAlways, .authorizedWhenInUse:
//            region = MKCoordinateRegion(center: locationManager.location!.coordinate, span: MapDetails.span)
//        @unknown default:
//            break
//        }
//    }
//
//    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
//        checkLocationAuthorization()
//    }
//
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let location: CLLocationCoordinate2D = manager.location?.coordinate else { return }
//        MapDetails.sourceLocation = location
//        print("location = \(location.latitude) \(location.longitude)")
//
//        createPath(sourceLocation: MapDetails.sourceLocation, destinationLocation: MapDetails.destinationLocation)
//    }
//
//    func createPath(sourceLocation : CLLocationCoordinate2D, destinationLocation : CLLocationCoordinate2D) {
//        let sourcePlaceMark = MKPlacemark(coordinate: sourceLocation, addressDictionary: nil)
//        let destinationPlaceMark = MKPlacemark(coordinate: destinationLocation, addressDictionary: nil)
//
//
//        let sourceMapItem = MKMapItem(placemark: sourcePlaceMark)
//        let destinationItem = MKMapItem(placemark: destinationPlaceMark)
//
//
//        let sourceAnotation = MKPointAnnotation()
//        sourceAnotation.title = "Delhi"
//        sourceAnotation.subtitle = "The Capital of INIDA"
//        if let location = sourcePlaceMark.location {
//            sourceAnotation.coordinate = location.coordinate
//        }
//
//        let destinationAnotation = MKPointAnnotation()
//        destinationAnotation.title = "Gurugram"
//        destinationAnotation.subtitle = "The HUB of IT Industries"
//        if let location = destinationPlaceMark.location {
//            destinationAnotation.coordinate = location.coordinate
//        }
//
//        self.mapView.showAnnotations([sourceAnotation, destinationAnotation], animated: true)
//
//
//
//        let directionRequest = MKDirections.Request()
//        directionRequest.source = sourceMapItem
//        directionRequest.destination = destinationItem
//        directionRequest.transportType = .automobile
//
//        let direction = MKDirections(request: directionRequest)
//
//
//        direction.calculate { (response, error) in
//            guard let response = response else {
//                if let error = error {
//                    print("ERROR FOUND : \(error.localizedDescription)")
//                }
//                return
//            }
//
//            let route = response.routes[0]
//            self.mapView.addOverlay(route.polyline, level: MKOverlayLevel.aboveRoads)
//
//            let rect = route.polyline.boundingMapRect
//
//            self.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
//
//        }
//    }
//
//}
