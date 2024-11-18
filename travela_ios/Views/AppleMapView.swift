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
    
    @State private var audioTourMarkers: [AudioTourMarker] = [
        AudioTourMarker(id: "2", name: "Golden Gate Bridge", latitude: 37.8199, longitude: -122.4783),
        AudioTourMarker(id: "d", name: "Ferry Building", latitude: 37.7955, longitude: -122.3937),
        AudioTourMarker(id: "2e", name: "Mirage Ferry Building", latitude: 37.33346374277115, longitude: -122.00535316079615)
    ]
    
    var body: some View {
        VStack {
            Map(position: $position) {
                UserAnnotation()
                
                // Add markers for each location
                ForEach(audioTourMarkers) { audioTourMarker in
                    // Marker(audioTourMarker.name, image: "mappin.and.ellipse", coordinate: audioTourMarker.coordinate)
                }
                
                ForEach(audioTourMarkers) { audioTourMarker in
                    Annotation(audioTourMarker.name, coordinate: audioTourMarker.coordinate) {
                        HStack(spacing: 8) {
                            Image(systemName: "mappin.circle.fill")
                                .font(.title2)
                                .foregroundColor(.white)

                            VStack(alignment: .leading, spacing: 4) {
                                Text(audioTourMarker.name)
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .bold()

                                Text("Click to know more")
                                    .font(.caption)
                                    .foregroundColor(.white.opacity(0.8))
                            }
                        }
                        .padding(12)
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.blue, Color.purple]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 5)
                        .onTapGesture {
                            // Set selected marker when tapped
                            print("You click on \(audioTourMarker.name)")
                        }
                    }
                    .annotationTitles(.hidden)
                }
                
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

struct AudioTourMarker: Identifiable {
    let id: String
    let name: String
    let latitude: Double
    let longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: latitude,
            longitude: longitude)
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
