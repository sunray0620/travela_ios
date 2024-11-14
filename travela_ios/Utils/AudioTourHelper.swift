//
//  AudioTourHelper.swift
//  travela_ios
//
//  Created by LEI SUN on 11/13/24.
//

import Foundation

class AudioTourHelper {
    
    static let audioFolderName: String = "audios"
    
    public static func prepareAudioTour(audioTourId: String) {
        // Check if we need to refresh the files
        if !checkIfNeedToRefreshAudioFiles(audioTourId: audioTourId) {
            return;
        }
        // Refresh all files
        downloadAudioFile(audioTourId: audioTourId)
    }
    
    private static func checkIfNeedToRefreshAudioFiles(audioTourId: String) -> Bool {
        return true
    }
    
    public static func downloadAudioFile(audioTourId: String) {
        if let path = Bundle.main.path(forResource: "canon_in_d", ofType: "mp3") {
            let fileContent = FileHelper.readDataFile(fileUrl: URL(fileURLWithPath: path))
            FileHelper.writeDataFile(fileUrl: getAudioTourFileUrl(audioTourId: audioTourId), data: fileContent)
        }
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
}
