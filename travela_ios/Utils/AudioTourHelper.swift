//
//  AudioTourHelper.swift
//  travela_ios
//
//  Created by LEI SUN on 11/13/24.
//

import Foundation

class AudioTourHelper {
    
    static let audioFolderName: String = "audios"
    static let imageFolderName: String = "images"
    
    public static func prepareAudioTour(audioTourViewModel: inout AudioTourViewModel) async {
        let audioTourId = audioTourViewModel.id
        // Check if we need to refresh the files
        if !checkIfNeedToRefreshAudioFiles(audioTourId: audioTourId) {
            return;
        }
        // Refresh all files
        await downloadAudioTourFiles(audioTourViewModel: &audioTourViewModel)
    }
    
    private static func checkIfNeedToRefreshAudioFiles(audioTourId: String) -> Bool {
        return true
    }
    
    public static func downloadAudioTourFiles(audioTourViewModel: inout AudioTourViewModel) async {
        let audioTourId = audioTourViewModel.id
        let localAudioFileUrl = getLocalAudioTourFileUrl(audioTourId: audioTourId)
        let localImageFileUrl = getLocalImageFileUrl(audioTourId: audioTourId)
        audioTourViewModel.imageFileUrl = localImageFileUrl
        audioTourViewModel.audioFileUrl = localAudioFileUrl
        
        if FileHelper.isFileExists(path: localAudioFileUrl) && FileHelper.isFileExists(path: localImageFileUrl) {
            return
        }
        let imageGcsBlobName = "\(imageFolderName)/\(audioTourId).jpg"
        let imageContent = await downloadGcsBlob(blobName: imageGcsBlobName)
        let audioGcsBlobName = "\(audioFolderName)/\(audioTourId).mp3"
        let audioContent = await downloadGcsBlob(blobName: audioGcsBlobName)
        
        if let data = Data(base64Encoded: imageContent!) {
            FileHelper.writeDataFile(fileUrl: localImageFileUrl, data: data)
        }
        if let data = Data(base64Encoded: audioContent!) {
            FileHelper.writeDataFile(fileUrl: localAudioFileUrl, data: data)
        }
    }
    
    public static func getLocalImageFileUrl(audioTourId: String) -> URL {
        let filePath = "\(imageFolderName)/\(audioTourId).jpg"
        return getLocalFileUrl(filePath: filePath)
    }
    
    public static func getLocalAudioTourFileUrl(audioTourId: String) -> URL {
        let filePath = "\(audioFolderName)/\(audioTourId).mp3"
        return getLocalFileUrl(filePath: filePath)
    }
    
    public static func getRootDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    public static func getLocalFileUrl(filePath: String) -> URL {
        return getRootDirectory().appendingPathComponent(filePath)
    }
    
    public static func downloadGcsBlob(blobName: String) async -> String? {
        var audio_url = "https://travela-336226198293.us-central1.run.app/audiointro/download_gcs_blob"
        audio_url.append("?blob_name=\(blobName)")
        guard let url = URL(string: audio_url) else { return nil }
        
        do {
            let (data, _) = try await URLSession.shared.data(for: URLRequest(url: url))
            let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
            if let jsonDict = jsonResponse as? [String: String] {
                let blobContent = jsonDict["blobContent"]
                return blobContent
            }
        } catch {
            print("Failed to download GCS blob.")
        }
        return nil
    }
}
