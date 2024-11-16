//
//  DataLoader.swift
//  travela_ios
//
//  Created by LEI SUN on 11/15/24.
//

import Foundation

class DataLoader {
    public static func saveDataToFile(data: [String: Any], fileUrl: URL) {
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                FileHelper.writeDataFile(fileUrl: fileUrl, data: jsonData)
            } catch {
                print("Failed to serialize data: \(error.localizedDescription)")
            }
        }
    
    public static func deserialize<T: Decodable>(_ data: Data) -> T {
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("Failed to desertialize data: \(T.self):\n\(error)")
        }
    }
}
