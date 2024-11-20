//
//  SettingsView.swift
//  travela_ios
//
//  Created by LEI SUN on 11/17/24.
//

import SwiftUI

struct SettingsView: View {
    
    @AppStorage("preferredLanguage") private var preferredLanguage: String = "en-US"
    @AppStorage("refreshAudio") private var refreshAudio: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("User Preferences")) {
                        Text("Preferred Language")
                        Picker("", selection: $preferredLanguage) {
                            Text("English - USA").tag("en-US")
                            Text("中文 - 中华人民共和国").tag("zh-CN")
                        }
                        .pickerStyle(MenuPickerStyle())
                        
                        // Toggle for Notifications
                        Toggle(isOn: $refreshAudio) {
                            Text("Refresh Audio Every Time")
                        }
                    }
                }
                Spacer()
            }
        }
    }
}

#Preview {
    SettingsView()
}
