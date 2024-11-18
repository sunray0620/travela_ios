//
//  SlideCard.swift
//  travela_ios
//
//  Created by LEI SUN on 11/11/24.
//

import SwiftUI
import MapKit

struct MapView: View {
    static let smallSheet : PresentationDetent = .fraction(0.1)
    
    @State private var selectedDetent: PresentationDetent = .large
    @State var audioTourViewModels: [AudioTourViewModel] = allAudioTourViewModels
    
    var body: some View {
        AppleMapView()
        .sheet(isPresented: .constant(true), content: {
            VStack{
                ButtonsBarView(selectedView: "map").padding(.top, 10).padding(.bottom, 0)
                
                AudioTourListView(audioTourList: audioTourViewModels, selectedDetent: $selectedDetent)
                    // .disabled(selectedDetent == MapView.smallSheet)
                    // .scrollDisabled(selectedDetent != .large)
                    .disabled(selectedDetent != .large)
                    .gesture(
                        DragGesture().onChanged { value in
                            if selectedDetent != .large && value.translation.height < 0 {
                                // When dragging up, change detent to `.fraction(1)`
                                selectedDetent = .large
                            }
                            if selectedDetent != MapView.smallSheet && value.translation.height > 0 {
                                // When dragging up, change detent to `.fraction(1)`
                                selectedDetent = MapView.smallSheet
                            }
                        }
                    )
            }
                .interactiveDismissDisabled()
                .presentationBackgroundInteraction(.enabled)
                .presentationContentInteraction(.scrolls)
                .presentationDetents([MapView.smallSheet, .medium, .large], selection: $selectedDetent)
                .presentationDragIndicator(.visible)
                .ignoresSafeArea()

        })
    }
}

#Preview {
    MapView()
}
