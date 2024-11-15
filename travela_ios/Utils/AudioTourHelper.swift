//
//  AudioTourHelper.swift
//  travela_ios
//
//  Created by LEI SUN on 11/13/24.
//

import Foundation

class AudioTourHelper {
    
    static let audioFolderName: String = "audios"
    
    public static func prepareAudioTour(audioTourId: String) async {
        // Check if we need to refresh the files
        if !checkIfNeedToRefreshAudioFiles(audioTourId: audioTourId) {
            return;
        }
        // Refresh all files
        await downloadAudioFile(audioTourId: audioTourId)
    }
    
    private static func checkIfNeedToRefreshAudioFiles(audioTourId: String) -> Bool {
        return true
    }
    
    public static func downloadAudioFile(audioTourId: String) async {
        let localAudioFileUrl = getAudioTourFileUrl(audioTourId: audioTourId)
        if FileHelper.isFileExists(path: localAudioFileUrl) {
            print("The audio file is already downloaded.")
            return
        }
        await downloadFile(audioTourId: audioTourId)
    }
    
    public static func getAudioTourFileUrl(audioTourId: String) -> URL {
        let filePath = "\(audioFolderName)/\(audioTourId).mp3"
        return getFileUrl(filePath: filePath)
    }
    
    public static func getRootDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    public static func getFileUrl(filePath: String) -> URL {
        return getRootDirectory().appendingPathComponent(filePath)
    }
    
    public static func downloadFile(audioTourId: String) async {
        var audio_url = "https://travela-336226198293.us-central1.run.app/audiointro/download_audio"
        audio_url.append("?audio_tour_id=\(audioTourId)")
        guard let url = URL(string: audio_url) else { return }
        
        do {
            let (data, _) = try await URLSession.shared.data(for: URLRequest(url: url))
            let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
            if let jsonDict = jsonResponse as? [String: String] {
                let audioContent = jsonDict["audioContent"]
                if let data = Data(base64Encoded: audioContent!) {
                    FileHelper.writeDataFile(fileUrl: getAudioTourFileUrl(audioTourId: audioTourId), data: data)
                }
            }
        } catch {
            print("Failed to download audio file.")
        }
    }
}
