//
//  AppleMapView.swift
//  travela_ios
//
//  Created by LEI SUN on 11/10/24.
//

import SwiftUI
import MapKit

struct AppleMapView: View {
    // @StateObject private var locationManager = LocationManager()
    @State private var position: MapCameraPosition = .userLocation(followsHeading: false, fallback: .automatic)

    var body: some View {
        Map(position: $position) {
            UserAnnotation()
        }.mapControls {
            MapPitchToggle()
            MapUserLocationButton()
            MapCompass()
        }
    }
}

/*
class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var userLocation: CLLocation?

    private let locationManager = CLLocationManager()

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }

    func requestLocation() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            DispatchQueue.main.async {
                self.userLocation = location
            }
        }
    }
}
*/

#Preview {
    AppleMapView()
}
