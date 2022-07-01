//
//  Character.swift
//  NetworkModel
//
//  Created by Moon Jongseek on 2022/07/01.
//

import Foundation

struct Character: Codable {
    let id: Int
    let name: String
    let status: String
    let url: String
    let species: String
    let type: String
    let gender: String
}
