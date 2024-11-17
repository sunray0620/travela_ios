//
//  AppleMapView.swift
//  travela_ios
//
//  Created by LEI SUN on 11/10/24.
//

import SwiftUI
import MapKit

struct AppleMapView: View {
    @StateObject private var locationManager = LocationManager()
    @State private var position: MapCameraPosition = .userLocation(followsHeading: false, fallback: .automatic)
    @State private var showAuthorizationDialog = false
    
    var body: some View {
        VStack {
            Map(position: $position) {
                UserAnnotation()
            }.mapControls {
                MapPitchToggle()
                MapUserLocationButton()
                MapCompass()
            }
        }.onAppear {
            locationManager.checkAuthorizationStatus()
            if locationManager.authorizationStatus == .denied {
                showAuthorizationDialog = true
            }
        }.confirmationDialog("Location Access Needed", isPresented: $showAuthorizationDialog, titleVisibility: .visible) {
            Button("Open Settings") {
                if let url = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Please allow location access in Settings to use the map features.")
        }
    }
}

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var authorizationStatus: CLAuthorizationStatus = .notDetermined
    
    private let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        checkAuthorizationStatus()
    }
    
    func requestAuthorization() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func checkAuthorizationStatus() {
        authorizationStatus = locationManager.authorizationStatus
        if authorizationStatus == .notDetermined {
            requestAuthorization()
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatus = manager.authorizationStatus
    }
    
}

#Preview {
    AppleMapView()
}
