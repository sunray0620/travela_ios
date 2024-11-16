//
//  FileHelper.swift
//  travela_ios
//
//  Created by LEI SUN on 11/13/24.
//

import Foundation

class FileHelper {
    public static func readFile(fileUrl: URL) -> String {
        do {
            let data = try Data(contentsOf: fileUrl)
            if let fileContent = String(data: data, encoding: .utf8) {
                return fileContent
            }
        } catch {
            print("Error reading file: \(error)")
        }
        return ""
    }
    
    public static func readDataFile(fileUrl: URL) -> Data {
        do {
            let data = try Data(contentsOf: fileUrl)
            return data
        } catch {
            print("Error reading file: \(error)")
        }
        return Data()
    }
    
    public static func writeFile(fileUrl: URL, fileContent: String) {
        let folderUrl = fileUrl.deletingLastPathComponent()
        if !FileManager.default.fileExists(atPath: folderUrl.path) {
            createFolder(folderUrl: folderUrl)
        }
        
        if let data = fileContent.data(using: .utf8) {
            do {
                try data.write(to: fileUrl)
            } catch {
                print("Error writing file: \(error)")
            }
        }
    }
    
    public static func writeDataFile(fileUrl: URL, data: Data) {
        let folderUrl = fileUrl.deletingLastPathComponent()
        if !FileManager.default.fileExists(atPath: folderUrl.path) {
            createFolder(folderUrl: folderUrl)
        }
        
        do {
            try data.write(to: fileUrl)
        } catch {
            print("Error writing file: \(error)")
        }
    }
    
    public static func createFolder(folderUrl: URL) {
        do {
            try FileManager.default.createDirectory(at: folderUrl, withIntermediateDirectories: true, attributes: nil)
            print("created directory: \(folderUrl.path)")
        } catch {
            print("Error creating directory: \(error)")
        }
    }
    
    public static func deleteFileOrFolder(path: URL) {
        do {
            try FileManager.default.removeItem(at: path)
        } catch {
            print("Error deleting file: \(error)")
        }
    }
    
    public static func isFileExists(path: URL) -> Bool {
        return FileManager.default.fileExists(atPath: path.path)
    }
    
    public static func isFolderExists(path: URL) -> Bool {
        return FileManager.default.fileExists(atPath: path.path, isDirectory: nil)
    }
}
