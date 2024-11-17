//
//  SlideCard.swift
//  travela_ios
//
//  Created by LEI SUN on 11/11/24.
//

import SwiftUI
import MapKit

struct MapView: View {
    var body: some View {
        AppleMapView()
        .sheet(isPresented: .constant(true), content: {
            VStack{}
                .interactiveDismissDisabled()
                .presentationBackgroundInteraction(.enabled)
                .presentationContentInteraction(.scrolls)
                .presentationDetents([.fraction(0.1), .fraction(0.55), .fraction(1)])
                .presentationDragIndicator(.visible)
                .ignoresSafeArea()
            
            AudioTourListView(audioTourList: allAudioTourViewModels)
        })
    }
}

#Preview {
    MapView()
}
