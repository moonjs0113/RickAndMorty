//
//  RNMService.swift
//  NetworkModel
//
//  Created by Moon Jongseek on 2022/07/01.
//

import Foundation

enum NetworkService {
    static let baseURL = "https://rickandmortyapi.com/api/"
    static let manager = NetworkManager(baseURL: baseURL)
}

extension NetworkService {
    enum CharacterRoute: Route {
        case allCharacter
        case id(Int)
        case base([Filters])
        
        var stringValue: String {
            switch self {
            case .allCharacter:
                return "character"
            case .id(let id):
                return "character/\(id)"
            case .base(let characterFilters):
                var stringValue = "character/" + (characterFilters.isEmpty ? "" : "?" + characterFilters.map { $0.getStringValue() + "&"}.joined())
                stringValue.removeLast()
                return stringValue
            }
        }
        
        var method: HTTPMethod {
            switch self {
            case .allCharacter:
                return .GET
            case .id:
                return .GET
            case .base:
                return .GET
            }
        }
        
        static func getCharacterCount(completion: @escaping(Info?, NetworkError?) -> ()) {
            manager.sendRequest(route: Self.allCharacter,
                                decodeTo: CharacterList.self) {
                completion($0?.info, $1)
            }
        }
        
        static func searchBy(id: Int, completion: @escaping(Character?, NetworkError?) -> ()) {
            manager.sendRequest(route: Self.id(id),
                                decodeTo: Character.self) {
                completion($0, $1)
            }
        }

        static func searchWith(filters: [Filters], completion: @escaping([Character]?, NetworkError?) -> ()) {
            
            struct SearchWithFiltersResponse: Decodable {
                let info: Info
                let results: [Character]
            }
            
            manager.sendRequest(route: Self.base(filters),
                                decodeTo: SearchWithFiltersResponse.self) {
                completion($0?.results, $1)
                
            }
        }
    }
    
    enum Filters {
        case name(String)
        case status(String)
        case species(String)
        case type(String)
        case gender(String)
        case page(Int)
        
        func getStringValue() -> String {
            switch self {
            case .name(let name):
                return "name=" + name
            case .status(let status):
                return "status=" + status
            case .species(let species):
                return "species=" + species
            case .type(let type):
                return "type=" + type
            case .gender(let gender):
                return "gender=" + gender
            case .page(let page):
                return "page=" + "\(page)"
            }
        }
    }
}
