//
//  Network.swift
//  Dz1Storyboar Rad
//
//  Created by Andrey Rachitskiy on 03.02.2022.
//

import Foundation
import PromiseKit

enum ParseError: Error {
    case failedToDecode
    case errorTask
    case notCorrectUrl
}

class NetworkingService {

    var urlConstructor = URLComponents()
    let configuration: URLSessionConfiguration!
    let session: URLSession!

    init() {
        urlConstructor.scheme = "https"
        urlConstructor.host = "api.vk.com"
        configuration = URLSessionConfiguration.default
        session = URLSession(configuration: configuration)
    }
    
    func compileUrl() -> Promise<URL> {
        urlConstructor.path = "/method/friends.get"

        urlConstructor.queryItems = [
            URLQueryItem(name: "fields", value: "first_name,photo_50"),
            URLQueryItem(name: "access_token", value: Session.instance.token),
            URLQueryItem(name: "v", value: "5.131"),
        ]

        return Promise { resolver in
            guard let url = urlConstructor.url else {
                resolver.reject(ParseError.notCorrectUrl)
                return
            }
            resolver.fulfill(url)
        }
    }

    func createRequest(_ url: URL) -> Promise<Data> {
        return Promise { resolver in
            session.dataTask(with: url) { (data, response, error) in
                guard let data = data else {
                    resolver.reject(ParseError.errorTask)
                    return
                }
                resolver.fulfill(data)
            }.resume()
        }
    }

    func parseData(_ data: Data) -> Promise<FriendItems> {
        return Promise { resolver in
            do {
                let response = try JSONDecoder().decode(ResponseFriends.self, from: data).response
                resolver.fulfill(response)
            } catch {
                resolver.reject(ParseError.failedToDecode)
            }
        }
    }
}
