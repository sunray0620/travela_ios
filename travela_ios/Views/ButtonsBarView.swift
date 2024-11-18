//
//  ButtonBar.swift
//  travela_ios
//
//  Created by LEI SUN on 11/17/24.
//

import SwiftUI

struct ButtonsBarView: View {
    @State var selectedView: String
    
    var body: some View {
        HStack(spacing: 0) {
            Spacer()
            NavigationLink(destination: MapView()) {
                Image(systemName: "map.fill")
                    .font(.title3)
                    .padding(5)
                    .background(Color.white.opacity(0.7))
                    .clipShape(Circle())
                    .foregroundColor(selectedView == "map" ? .blue : .gray)
            }
            
            Spacer()
            
            // Button 2 - Navigates to Discovery View
            NavigationLink(destination: SettingsView()) {
                Image(systemName: "magnifyingglass")
                    .font(.title3)
                    .padding(5)
                    .background(Color.white.opacity(0.7))
                    .clipShape(Circle())
                    .foregroundColor(selectedView == "discover" ? .blue : .gray)
            }
            
            Spacer()
            
            // Button 3 - Navigates to Playing View
            NavigationLink(destination: SettingsView()) {
                Image(systemName: "play.fill")
                    .font(.title3)
                    .padding(5)
                    .background(Color.white.opacity(0.7))
                    .clipShape(Circle())
                    .foregroundColor(selectedView == "playing" ? .blue : .gray)
            }
            
            Spacer()
            
            // Button 4 - Navigates to Settings View
            NavigationLink(destination: SettingsView()) {
                Image(systemName: "gearshape.fill")
                    .font(.title3)
                    .padding(5)
                    .background(Color.white.opacity(0.7))
                    .clipShape(Circle())
                    .foregroundColor(selectedView == "settings" ? .blue : .gray)
            }
            
            Spacer()
        }
        .background(Color.white)
        .cornerRadius(5)
    }
}

#Preview {
    ButtonsBarView(selectedView: "settings")
}
