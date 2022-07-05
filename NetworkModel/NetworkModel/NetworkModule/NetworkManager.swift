//
//  NetworkManager.swift
//  NetworkModel
//
//  Created by Moon Jongseek on 2022/07/01.
//

import Foundation

final class NetworkManager {
    let baseURL: String
    private var session = URLSession(configuration: URLSessionConfiguration.default,
                                     delegate: nil,
                                     delegateQueue: nil)
    
    private let request: (URL, NetworkService.ModelRoute) -> URLRequest =  { url, route in
        var request = URLRequest(url: url)
        request.httpMethod = route.method.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        return request
    }
    
    init(baseURL: String) {
        self.baseURL = baseURL
    }
    
    deinit {
        self.session.finishTasksAndInvalidate()
    }
}

extension NetworkManager {
    func sendRequest<D: Codable>(route: NetworkService.ModelRoute, id: Int = 0, decodeTo: D.Type, completeHandler: @escaping NetworkClosure<D>) {
        var urlString = self.baseURL + route.stringValue
        if id > 0 {
            urlString += "/\(id)"
        }
        
        guard let url = URL(string: urlString) else {
            return completeHandler(nil, NetworkError.invalidURL)
        }
        
        let request = self.request(url, route)
        self.session.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completeHandler(nil, .nilResponse)
                return
            }
            
            print(response)
            
            guard let result = try? JSONDecoder().decode(D.self, from: data) else {
                completeHandler(nil, .errorDecodingJson)
                return
            }
            
            completeHandler(result, nil)
        }
        .resume()
    }
}
