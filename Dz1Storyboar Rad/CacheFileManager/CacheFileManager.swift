//
//  CacheFileManager.swift
//  Dz1Storyboar Rad
//
//  Created by Andrey Rachitskiy on 27.01.2022.
//

import Foundation

enum FileError: Swift.Error {

    case fileAlreadyExists
    case invalidDirectory
    case writtingFailed(error: Error)
    case deletedFailed(error: Error)
}

class CacheFileManager {

    private var fileManager: FileManager = {
        return FileManager.default
    }()

    func save(fileName: String, data: Data) throws -> URL? {
        guard let url = makeUrl(forFileNamed: fileName) else {
            throw FileError.invalidDirectory
        }
        if fileManager.fileExists(atPath: url.absoluteString) {
            throw FileError.fileAlreadyExists
        }

        fileManager.createFile(atPath: url.path, contents: data, attributes: nil)
        return url
    }

    func deleted(fileUrl: URL) throws {
        do {
            try fileManager.removeItem(at: fileUrl)
        } catch {
            throw FileError.deletedFailed(error: error)
        }
    }

    func makeUrl(forFileNamed fileName: String) -> URL? {
        guard let url = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        return url.appendingPathComponent(fileName)
    }

    func getFile(url text: String) -> Data? {
        guard let url = makeUrl(forFileNamed: text) else { return nil }
        let path = url.path
        let dataUrl = URL.init(fileURLWithPath: path)
        return try? Data(contentsOf: dataUrl)
    }
}
