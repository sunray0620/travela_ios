//
//  ContentView.swift
//  travela_ios
//
//  Created by LEI SUN on 11/4/24.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab: Int = 3
    
    var body: some View {
        VStack {
            // Display the currently selected view
            ZStack {
                switch selectedTab {
                case 0:
                    MapView()
                case 1:
                    DiscoverView()
                case 2:
                    PlayingView()
                case 3:
                    SettingsView()
                default:
                    SettingsView()
                }
            }
            
            Spacer()
            
            HStack {
                Spacer()
                Button(action: {
                    print("Button 1 tapped")
                    selectedTab = 0
                }) {
                    Image(systemName: "map.fill")
                        .font(.title3) // Reduced font size
                        .padding(4)    // Reduced padding
                }
                Spacer()
                Button(action: {
                    print("Button 2 tapped")
                    selectedTab = 1
                }) {
                    Image(systemName: "magnifyingglass")
                        .font(.title3).padding(4)
                }
                Spacer()
                Button(action: {
                    print("Button 3 tapped")
                    selectedTab = 2
                }) {
                    Image(systemName: "location.fill")
                        .font(.title3).padding(4)
                }
                Spacer()
                Button(action: {
                    print("Button 4 tapped")
                    selectedTab = 3
                }) {
                    Image(systemName: "gearshape.fill")
                        .font(.title3).padding(4)
                }
                Spacer()
            }
            .background(Color.white)

        }
    }
}


#Preview {
    ContentView()
}
