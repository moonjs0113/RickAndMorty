//
//  Character.swift
//  RickAndMorty
//
//  Created by Moon Jongseek on 2022/07/01.
//

import Foundation

struct Character: ModelProtocol {    
    typealias FilterType = CharacterFilter
    
    let id: Int
    let name: String

    let status: String
    let species: String
    let type: String
    let gender: String

    let origin: CharacterLocation
    let location: CharacterLocation

    let image: String

    let url: String
    let episode: [String]
    let created: String

    var imageURL: URL {
        guard let url = URL(string: self.image) else {
            return URL(fileURLWithPath: "")
        }
        return url
    }
    
    enum CharacterFilter: FilterProtocol {
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

struct CharacterLocation: Codable {
    let name: String
    let url: String
}
