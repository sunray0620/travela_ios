//
//  Playing.swift
//  travela_ios
//
//  Created by LEI SUN on 11/18/24.
//

import SwiftUI

struct PlayingView: View {

    @AppStorage("preferredLanguage") private var preferredLanguage: String = "en-US"
    
    var body: some View {
        VStack {
            Text("Playing View")
            Text("TBD")
            Text("\(preferredLanguage)")
        }
    }
}

#Preview {
    PlayingView()
}
