//
//  Info.swift
//  NetworkModel
//
//  Created by Moon Jongseek on 2022/07/01.
//

import Foundation

struct Info: Decodable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}
