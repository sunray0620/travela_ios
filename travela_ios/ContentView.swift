//
//  ContentView.swift
//  travela_ios
//
//  Created by LEI SUN on 11/4/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        AudioPlayerView(audioTourId: "lesunAudioTour").preferredColorScheme(.dark)
    }
}

#Preview {
    AudioPlayerView(audioTourId: "lesunAudioTour").preferredColorScheme(.dark)
}
