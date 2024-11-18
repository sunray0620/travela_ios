//
//  SlideCard.swift
//  travela_ios
//
//  Created by LEI SUN on 11/11/24.
//

import SwiftUI
import MapKit

struct MapView: View {
    static let smallSheet: PresentationDetent = .fraction(0)
    
    @State private var selectedDetent: PresentationDetent = .medium
    @State private var isSheetPresented: Bool = true
    @State var audioTourViewModels: [AudioTourViewModel] = allAudioTourViewModels
    
    var body: some View {
        VStack {
            AppleMapView()
                .sheet(isPresented: $isSheetPresented, content: {
                    VStack{
                        AudioTourListView(audioTourList: audioTourViewModels, selectedDetent: $selectedDetent)
                        // .disabled(selectedDetent == MapView.smallSheet)
                        // .scrollDisabled(selectedDetent != .large)
                            .disabled(selectedDetent != .large)
                    }
                    .interactiveDismissDisabled()
                    .presentationBackgroundInteraction(.enabled)
                    .presentationContentInteraction(.scrolls)
                    .presentationDetents([MapView.smallSheet, .medium, .large], selection: $selectedDetent)
                    .presentationDragIndicator(.visible)
                    .ignoresSafeArea()
                    .onChange(of: selectedDetent) {
                        updateSheetPresentation()
                    }
                })
            Button(action: {
                selectedDetent = .medium
                updateSheetPresentation()
            }) {
                Text("Show the list")
            }
        }
        
    }
    
    private func updateSheetPresentation() {
        isSheetPresented = (selectedDetent != MapView.smallSheet)
    }
}

#Preview {
    MapView()
}
