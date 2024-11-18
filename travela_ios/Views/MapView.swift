//
//  SlideCard.swift
//  travela_ios
//
//  Created by LEI SUN on 11/11/24.
//

import SwiftUI
import MapKit

struct MapView: View {
    @State private var selectedDetent: PresentationDetent = .fraction(0.1)
    
    var body: some View {
        AppleMapView()
        .sheet(isPresented: .constant(true), content: {
            VStack{}
                .frame(width: .infinity, height: 10)
                .interactiveDismissDisabled()
                .presentationBackgroundInteraction(.enabled)
                .presentationContentInteraction(.scrolls)
                .presentationDetents([.fraction(0.1), .medium, .large], selection: $selectedDetent)
                .presentationDragIndicator(.visible)
                .ignoresSafeArea()
            
            AudioTourListView(audioTourList: allAudioTourViewModels, selectedDetent: $selectedDetent)
        })
    }
}

#Preview {
    MapView()
}
