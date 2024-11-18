//
//  SettingsView.swift
//  travela_ios
//
//  Created by LEI SUN on 11/17/24.
//

import SwiftUI

struct SettingsView: View {
    @State private var preferredLanguage: String = "en-US"
    
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
