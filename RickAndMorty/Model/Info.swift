//
//  Info.swift
//  RickAndMorty
//
//  Created by Moon Jongseek on 2022/07/01.
//

import Foundation

struct ModelList<T: ModelProtocol>: Codable {
    var info: Info
    var results: [T]?
}

struct Info: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}
