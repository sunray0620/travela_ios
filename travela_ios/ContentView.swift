//
//  ContentView.swift
//  travela_ios
//
//  Created by LEI SUN on 11/4/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        AudioPlayerView(audioTourViewModel: allAudioTourViewModels[0]).preferredColorScheme(.dark)
    }
}

#Preview {
    AudioPlayerView(audioTourViewModel: allAudioTourViewModels[0]).preferredColorScheme(.dark)
}
