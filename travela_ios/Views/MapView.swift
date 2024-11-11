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
            Text("Sheet Text")
                .interactiveDismissDisabled()
                .presentationBackgroundInteraction(.enabled)
                .presentationDetents([.fraction(0.1), .fraction(0.5), .fraction(0.9)])
                .presentationDragIndicator(.visible)
                .ignoresSafeArea()
        })
    }
}

#Preview {
    MapView()
}
