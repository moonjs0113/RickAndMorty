//
//  NetworkManager.swift
//  RickAndMorty
//
//  Created by Moon Jongseek on 2022/07/01.
//

import Foundation

final class NetworkManager {
    enum CacheType {
        case model
        case image
    }
    
    // MARK: - Properties
    private let baseURL: String = "https://rickandmortyapi.com/api/"
    
    private var session: URLSession {
        URLSession(
            configuration: .default,
            delegate: nil,
            delegateQueue: nil
        )
    }
    
    // MARK: - Methods
    private func createRequest(_ urlString: String, _ method: HTTPMethod) throws -> URLRequest {
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        return request
    }
    
    // MARK: - Life Cycles
    deinit {
        self.session.finishTasksAndInvalidate()
    }
}

extension NetworkManager {
    func multipleObjectRouteValue(ids: [Int]) -> String {
        var result = ""
        if ids.count > 0 {
            result += "/"
            for id in ids {
                result += "\(id),"
            }
            _ = result.popLast()
        }
        return result
    }
    
    func request(
        to urlString: String,
        _ httpMethod: HTTPMethod = .GET,
        _ cacheType: CacheType = .model
    ) async throws -> Data {
        let request = try createRequest(urlString, httpMethod)
        let session = self.session
        session.configuration.urlCache = {
            switch cacheType {
            case .model: return CacheManger.dataCache
            case .image: return CacheManger.imageCache
            }
        }()
        guard let result: (data: Data, response: URLResponse) = try? await session.data(for: request) else {
            throw NetworkError.nilResponse
        }
        return result.data
    }
    
    func request<D: Codable>(
        to urlString: String
    ) async throws -> D {
        let data = try await request(to: urlString)
        guard let result = try? JSONDecoder().decode(D.self, from: data) else {
            throw NetworkError.errorDecodingJson
        }
        return result
    }
    
    func request<D: Codable>(
        from endPoint: DataType,
        with queryParameters: String
    ) async throws -> D {
        let urlString = baseURL + endPoint.toString + "/" + queryParameters
        let data = try await request(to: urlString)
        guard let result = try? JSONDecoder().decode(D.self, from: data) else {
            throw NetworkError.errorDecodingJson
        }
        return result
    }
}
