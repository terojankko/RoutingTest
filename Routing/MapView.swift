//
//  MapView.swift
//  Routing
//
//  Created by Tero Jankko on 11/2/22.
//

import SwiftUI
import Foundation
import MapKit

struct MapView: UIViewRepresentable {
    typealias UIViewType = MKMapView

    @Binding var directions: [String]

    let homeLocationCoordinates  = (47.64511372884968, -121.98533735862324)
    let groceryStoreLocationCoordinates = (47.69880785788883, -122.02594461444315)

    var locationManager = CLLocationManager()

    func makeCoordinator() -> MapViewCoordinator {
        return MapViewCoordinator()
    }

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator

        let region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: homeLocationCoordinates.0, longitude: homeLocationCoordinates.1),
            span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))

        mapView.setRegion(region, animated: true)

        let homeLocation = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: homeLocationCoordinates.0, longitude: homeLocationCoordinates.1))

        let groceryStoreLocation = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: groceryStoreLocationCoordinates.0, longitude: groceryStoreLocationCoordinates.1))

        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: homeLocation)
        request.destination = MKMapItem(placemark: groceryStoreLocation)
        request.transportType = .automobile

        let directions = MKDirections(request: request)
        directions.calculate { response, error in
            guard let route = response?.routes.first else { return }
            mapView.addAnnotations([homeLocation, groceryStoreLocation])
            mapView.addOverlay(route.polyline)
            mapView.setVisibleMapRect(
                route.polyline.boundingMapRect,
                edgePadding: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20),
                animated: true)
            self.directions = route.steps.map { $0.instructions }.filter { !$0.isEmpty }
        }
        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
    }

    class MapViewCoordinator: NSObject, MKMapViewDelegate {
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.strokeColor = .systemBlue
            renderer.lineWidth = 5
            return renderer
        }
    }
}
