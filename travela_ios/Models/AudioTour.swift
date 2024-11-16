//
//  AudioTour.swift
//  travela_ios
//
//  Created by LEI SUN on 11/15/24.
//

import Foundation
import SwiftUICore

struct AudioTourViewModel: Hashable, Codable, Identifiable {
    var id: String
    var name: String
    var description: String
    var isAutoGenerated: Bool   // If it is gerated by Travela
    var language: String
    var length: Int             // In seconds.
    
    var creator: String
    var createdTime: String     // ISO8601: "2016-04-14T10:44:00+0000"
    var latitude: Double
    var longitude: Double
    
    var imageFileName: String?
    var audioFileName: String?
    
    var imageFileUrl: URL?
    var audioFileUrl: URL?
}

func loadAudioTours() -> [AudioTourViewModel] {
    guard let fileUrl = Bundle.main.url(forResource: "AudioTours.json", withExtension: nil) else { print("shabi"); return [AudioTourViewModel(id: "1d07effb-1156-4104-bfe4-439ed88c89f3", name: "Space Needle", description: "Space Needle", isAutoGenerated: false, language: "en-US", length: 10, creator: "LEI SUN", createdTime: "2016-04-14T10:44:00+0000", latitude: 0, longitude: 0)] }
    let data = FileHelper.readDataFile(fileUrl: fileUrl)
    let audioTourViewModels: [AudioTourViewModel] = DataLoader.deserialize(data)
    return audioTourViewModels
}

var allAudioTourViewModels: [AudioTourViewModel] = loadAudioTours()
